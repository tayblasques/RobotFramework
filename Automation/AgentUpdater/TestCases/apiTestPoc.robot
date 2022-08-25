*** Settings ***
Documentation    API implementation for POC                  API Link: https://fakerestapi.azurewebsites.net/index.html  
Resource         ../Resources/apiResources.robot             #indica onde os testes serão implementados
# Suite Setup      Connect to API


*** Test Cases ***
Test Case 01 - API Get Request
    Given an API endpoint
    When I send a GET request to the API
    Then Then it should return a 200 status code    200
    And a list with "200" results

Test Case 02 - API Get Request With ID
    Given an API endpoint
    When I send a GET request to the API with the ID "15"
    Then Then it should return a 200 status code    200
    And only the book I requested

Test Case 03 - API Post Request
    Given an API endpoint
    When I send a POST request
    Then the book should be registered
    And POST should return a 200 status code    200

Test Case 04 - API Put Request
    Given an API endpoint
    When I send a PUT request to the API with the ID "18975"
    Then the book should be updated
    And PUT should return a 200 status code    200

Test Case 05 - API Delete Request
    Given an API endpoint
    When I send a DELETE request to the API with the ID "18975"
    Then the book "18975" should be deleted
    And DELETE should return a 200 status code    200

