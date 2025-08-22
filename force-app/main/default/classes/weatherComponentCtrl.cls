// API website : https://www.weatherapi.com/

public with sharing class weatherComponentCtrl {
    @AuraEnabled
    public static Map <String,Object> getWeatherByCity(String city){
        try {
            Map <String,Object> weatherResults = new Map <String,Object> ();
            HttpRequest request = new HttpRequest();
    
            String cityParam = city!=''?city.replace(' ', '%20').replace('ñ', 'n'): 'London';
            Http http = new Http();
            request.setMethod('GET');
            String API_KEY='d9c016ed86ed4b7292881842252108'; // only active until September 4th.
            request.setEndpoint('http://api.weatherapi.com/v1/forecast.json?key='+API_KEY+'&q='+cityParam+'&aqi=no&days=2&alerts=no');
            HttpResponse response = http.send(request);

            if(response.getStatusCode() == 200){
                weatherResults = (Map <String,Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('weatherResults:::'+weatherResults);
            }
            return weatherResults;
        } catch (Exception e) {
            throw new HandledException('exceptionText: ' + e.getMessage());
        }
    }
}