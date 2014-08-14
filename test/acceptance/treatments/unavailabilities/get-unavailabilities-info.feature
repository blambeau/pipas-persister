Feature: Unavailabilities information
  In order to let the GUI know about unavailabilities
  As the PIPAS persister
  I want to provide him with service to get unavailabilities information

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Getting unavailabilities information

    Given I receive a GET request to '/treatments/d9026fa0-66ff-0131-38cb-3c07545ed162/unavailabilities' with the headers:
      | Content-Type     |
      | application/json |

    Then I should return a "200 Ok" response
    And the body should be a valid '/treatments/unavailabilities/singular' resource representation
