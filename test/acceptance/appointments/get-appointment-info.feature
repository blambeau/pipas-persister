Feature: Appointment information
  In order to let the GUI know about appointments
  As the PIPAS persister
  I want to provide him with service to get appointment information

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Getting an appointment information

    Given I receive a GET request to '/appointments/e5f1ba70-671d-0131-38d1-3c07545ed162' with the headers:
      | Content-Type     |
      | application/json |

    Then I should return a "200 Ok" response
    And the body should be a valid '/appointments/singular' resource representation
