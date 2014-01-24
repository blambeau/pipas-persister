Feature: Pinging the service
  In order to know whether the Persister service is available
  As another software component
  I want to ping it

  Scenario: Pinging the RESTful way
    Given I make a GET request to '/'
    Then  I should observe a "200 Ok" response
