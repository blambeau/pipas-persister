Feature: Getting the current schedule
  In order to compute/improve the current schedule
  As the scheduler component
  I want to obtain the current scheduling problem from the persister

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Getting the scheduling problem on the RESTful interface

    Given I make a GET request to '/scheduling/problem' with the following headers:
      | Accept           |
      | application/json |

    Then I should receive a "200 Ok" response
    And the response should have the following headers:
      | Content-Type     |             X-Accuracy-Timestamp |
      | application/json | 2014-01-01T12:15:00.000000+00:00 |

    And the body should be a json object having the following keys:
      | key          |
      | scheduled_at |
      |      service |
      |   treatments |
