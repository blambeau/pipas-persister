Feature: Pinging the service
  In order to let other components know whether I'm available
  As the PIPAS persister
  I want to support a ping service

  Scenario: Pinging the RESTful way

    Given I receive a GET request to '/'

    Then  I should return a "200 Ok" response
