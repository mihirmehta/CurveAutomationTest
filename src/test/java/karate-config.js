function fn() {    
  
  var apiKey = karate.properties['apiKey'];
  var config = {
  apiKey: apiKey,
  weather_7day_api: 'http://api.weatherapi.com/v1/history.json'
  };
  
  return config;
  
  karate.configure('report', { showLog: true, showAllSteps: false });
  
  
}