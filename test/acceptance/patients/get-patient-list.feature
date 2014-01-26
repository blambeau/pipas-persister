Feature: Getting the current schedule
  In order to display patients
  As a PIPAS component
  I want to obtain the list of them

  Background:
    Given the situation is the one described in the 'initial-state' dataset

  Scenario: Getting the list of patients on the RESTful interface

    Given I make a GET request to '/patients/' with the following headers:
      | Accept           |
      | application/json |

    Then I should receive a "200 Ok" response
    And the response should have the following headers:
      | Content-Type     |             X-Accuracy-Timestamp |
      | application/json | 2014-01-01T12:15:00.000000+00:00 |

    And the body should be a json array
    And all objects in this array should have the following keys:
      | key          |
      |   patient_id |
      |   first_name |
      |    last_name |
      |       gender |
