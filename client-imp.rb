require 'active_support/concern'
module Kargotakip
  extend ActiveSupport::Concern

  # it works in sidekiq
  def register_tracking_status
    return unless (tracking_code_changed?(from: nil) || kargotakip_id.nil? )
    request = {
      "email": "email@domaim.com",
      "password": "password",
      "tracking_code": tracking_code
    }
    begin
      response = RestClient.post "kargotakip.herokuapp.com/shipments.json", request.to_json, {content_type: :json}
    rescue RestClient::ExceptionWithResponse => e
      response = e.response
      Bugsnag.notify(e)
    end
    if response.code == 201
      shipment = JSON.parse(response.body, object_class: OpenStruct)
      self.kargotakip_id = shipment.id
      self.save      
    end
  end

  def tracking_status
    unless kargotakip_id.blank?
      return self.tracking_status_cache unless self.tracking_status_cache.nil?
      begin
        resource = RestClient::Resource.new "kargotakip.herokuapp.com/shipments/#{kargotakip_id}.json"
        response = resource.get params: {:email => 'email@domain.com', :password => 'password'}
        self.tracking_status_cache = response
      rescue RestClient::ExceptionWithResponse => e
      
        Bugsnag.notify(e)
        nil
      end
    end
  end

  included do
    before_update -> { TrackingStatusRegistererWorker.perform_async(id) }
    attr_accessor :tracking_status_cache
  end
end
