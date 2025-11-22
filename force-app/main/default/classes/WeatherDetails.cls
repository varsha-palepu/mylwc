public with sharing class WeatherDetails {
@AuraEnabled
  public static String getdetails(String city){
    String key='https://api.tomorrow.io/v4/weather/forecast?location='+ city +'&apikey=wR5jR7dsNVfHMumuGYbrtvyGIidmHCOJ';
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(key);
    req.setMethod('GET');
    Httpresponse res = http.send(req);
    return res.getBody();
  }
}