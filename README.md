# kargotakip-examples
Tracking service usage examples (kargonuzvar.com)

The documention is [here](http://kargonuzvar.com/pages/api "here")

Replace the email and password with yours!
## Get All Shipments
-  C

```c
CURL *hnd = curl_easy_init();

curl_easy_setopt(hnd, CURLOPT_CUSTOMREQUEST, "GET");
curl_easy_setopt(hnd, CURLOPT_URL, "http://kargotakip.herokuapp.com/shipments.json?email=YOUR-EMAIL&password=PASSWORD");

CURLcode ret = curl_easy_perform(hnd);
```
- C#

```csharp
var client = new RestClient("http://kargotakip.herokuapp.com/shipments.json?email=YOUR-EMAIL&password=PASSWORD");
var request = new RestRequest(Method.GET);
IRestResponse response = client.Execute(request);
```
- Go

```go
package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "http://kargotakip.herokuapp.com/shipments.json?email=YOUR-EMAIL&password=PASSWORD"

	req, _ := http.NewRequest("GET", url, nil)

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
```
- Java

```java
HttpResponse<String> response = Unirest.get("http://kargotakip.herokuapp.com/shipments.json?email=YOUR-EMAIL&password=PASSWORD")
  .asString();
```
- Javascript

```javascript
var data = null;

var xhr = new XMLHttpRequest();
xhr.withCredentials = true;

xhr.addEventListener("readystatechange", function () {
  if (this.readyState === this.DONE) {
    console.log(this.responseText);
  }
});

xhr.open("GET", "http://kargotakip.herokuapp.com/shipments.json?email=YOUR-EMAIL&password=PASSWORD");

xhr.send(data);
// Or if you are using Jquery
var settings = {
  "async": true,
  "crossDomain": true,
  "url": "http://kargotakip.herokuapp.com/shipments.json?email=YOUR-EMAIL&password=PASSWORD",
  "method": "GET",
  "headers": {}
}

$.ajax(settings).done(function (response) {
  console.log(response);
});
```
- Python

```python
import requests

url = "http://kargotakip.herokuapp.com/shipments.json"

querystring = {"email":"your_email_address","password":"your_password"}

payload = ""
response = requests.request("GET", url, data=payload, params=querystring)

print(response.text)
```
