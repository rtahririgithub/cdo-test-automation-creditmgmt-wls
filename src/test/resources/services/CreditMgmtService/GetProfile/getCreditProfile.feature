@getCreditProfile
Feature: getCreditProfile

  Background: Configuration and Precondition steps
    * def envName = karate.env
    * def headerData = {env: 'it03'}
    * def res = PATH_TMF+ 'getAuthToken.feature'
    * def token = karate.call(res)
    * headerData.Authorization = token.authToken
    * print 'final headerData: ' + headerData
    * headers headerData
    * configure proxy = 'http://pac.tsl.telus.com:8080'

  Scenario: get Credit management profile
    * print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + SERVICE_VERSION
    Given url ENDPOINT_URL + 'customer/creditProfile/' + SERVICE_VERSION
    And path '/customer/' + Id
    When method get
  
    