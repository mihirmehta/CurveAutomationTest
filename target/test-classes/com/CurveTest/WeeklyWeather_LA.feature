#Tags can be defined here. Tests can be chosen to run based on the tags we define. If there are no tags, all tests are executed by default
@HappyPath

Feature: Get hottest and coldest date from last one week for LA

  Given I have access to the historical weather data of weather api
  And I want to know the hottest and coldest day of the last week in LA
  When I call the historical data weather api
  Then I can get the hottest and the coldest day of the week for LA

	Background: 
	 # Calling a java class GetDates.java that returns today's date as StartDate and 7th day as ToDate or end date
	  * def GetDates = Java.type('com.CurveTest.GetDates')	
	 
	 # Calling initialSetup method that encapsulates the logic on how the the dates are computed
	 	* def setup = GetDates.initialSetup()
	
	 # Storing the dates to the variables that will be used as path parameters in the endpoint URL	
		* def ToDate = GetDates.getTodaysDate()
		* def StartDate = GetDates.get7DaysAgoDate()
	
   Scenario: Get the hottest day and coldest day of the week
   # weather_7day_api is declared in karate-config.js. This is where all the end points are listed.
   # All variables in karate-config.js act like 'global variables' in Karate
   # apiKey comes from the maven command line. This key is got from weather API to use their APIs.
   # The reason I have added this on the command line is that this can go as a configuration on the CI/CD configs
   
    Given url weather_7day_api
    And param key = apiKey
   # names get picked up from the Examples table defined at the bottom of this feature file
    And param q = 'los angeles' 
    And param dt = StartDate
    And param end_dt = ToDate
    When method get
   # Asserting the end point gives a 200 OK status
    Then status 200 
    And def result = response 
   # Checking if the results of the endpoint gives us exactly 7 days of data 
    And assert response.forecast.forecastday.length == 7 
   # More assertions can be very easily defined here. We can have various matches too, matching the values in the response with the expected values  
  
   # javascript function that returns the index of the array that has the highest temperature in the last 7 days
   # There are various different ways of doing this but wrote a js function just to demo that Karate very easily
   # supports calling java classes and even javascript functions.
   # These functions can be placed in the Background section of this feature file too.
		* def hottest = 
		"""
		function(array) {
  	var greatest;
  	var indexOfGreatest;
  	for (var i = 0; i < array.length; i++) {
    if (!greatest || array[i].day.maxtemp_c > greatest) {
      greatest = array[i].day.maxtemp_c;
      indexOfGreatest = i;
    }
  	}
  	return indexOfGreatest;
		}
		"""

	# javascript function that returns the index of the array that has the lowest temperature in the last 7 days
		* def coldest = 
		"""
		function(array) {
  	var greatest;
  	var indexOfGreatest;
  	for (var i = 0; i < array.length; i++) {
    if (!greatest || array[i].day.mintemp_c < greatest) {
      greatest = array[i].day.mintemp_c;
      indexOfGreatest = i;
    }
  	}
  	return indexOfGreatest;
		}
		"""
		# calling the js function to get the index of the hottest day
		# The path in the json response that has the max temperature is - $.forecast.forecastday[x].day.maxtemp_c
		# The path in the json response that has the date is - $.forecast.forecastday[x].date
		* def hotindex = call hottest response.forecast.forecastday
		* def hottestdate = response.forecast.forecastday[hotindex].date
		* def hottesttemp = response.forecast.forecastday[hotindex].day.maxtemp_c
	
	  # calling the js function to get the index of the coldest day
		# The path in the json response that has the min temperature is - $.forecast.forecastday[x].day.mintemp_c
		# The path in the json response that has the date is - $.forecast.forecastday[x].date
		* def coldindex = call coldest response.forecast.forecastday
		* def coldestdate = response.forecast.forecastday[coldindex].date
		* def coldesttemp = response.forecast.forecastday[coldindex].day.mintemp_c
		
		# printing the hottest date and the temperature for LA. This is available in the logs, on the console and the reports too.
		* print 'Hottest date in LA in the last week was: ',hottestdate ,	'with max temperature' , hottesttemp
		* print 'Coldest date in LA in the last week was : ',coldestdate	, 'with min temperature' , coldesttemp
		
    
    
    