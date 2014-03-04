Feature: Delivery information
  In order to let the GUI know about deliveries
  As the PIPAS persister
  I want to provide him with service to get delivery information

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Getting an appointment information

    Given I receive a GET request to '/deliveries/08bfd040-6cb9-0131-3a25-3c07545ed162' with the headers:
      | Content-Type     |
      | application/json |

    Then I should return a "200 Ok" response
    And the body should be a valid '/deliveries/singular' resource representation
