Feature: Serving the service planning
  In order for the GUI to display information about service availability
  As the PIPAS persister
  I want to provide it with the information

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Responding to a request to the service availability

    Given I receive a GET request to '/service/availabilities' with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response
    And the body should be a valid '/service/availabilities' resource representation
