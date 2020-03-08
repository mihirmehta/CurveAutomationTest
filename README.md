# CurveAutomationTest
                                WeatherAPI tests for Curve
These are the tests that are written as part of the Curve Test Automation activity.

The backend API testing framework used is Karate DSL

There are 2 scenarios as part of this repository

1. A scenario where 5 cities are chosen and the test gives the hottest day and the coldest day in the last 7 days for each of the cities.
2. A scenario that gives the hottest and coldest day for LA

Inorder to run the tests, a prerequsite is to have maven installed on the machine where the tests are going to be run.

Once the repository is cloned, the commands to run the tests are as follows

1. Go to the repo directory. Example cd C:/Workspace/CurveTests
2. Run the following command - mvn test -DapiKey={apiKey}
   The<apiKey> is the api key obtained by signing up on the weatherapi.com website. This api key can be configured on the CI/CD so we avoid    sharing apiKey in the code.
3. Once the tests are run, the reports will be available under target\cucumber-html-reports. 
   Example - C:\EclipseWorkspace\CurveTest\target\cucumber-html-reports\  
4. The API Key to be used will be shared via email.
