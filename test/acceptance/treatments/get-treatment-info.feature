Feature: Treatment information
  In order to let the GUI know about treatments
  As the PIPAS persister
  I want to provide him with service to get treatment information

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Getting a treatment information

    Given I receive a GET request to '/treatments/d9026fa0-66ff-0131-38cb-3c07545ed162' with the headers:
      | Content-Type     |
      | application/json |

    Then I should return a "200 Ok" response
    And the body should be a valid '/treatments/singular' resource representation
