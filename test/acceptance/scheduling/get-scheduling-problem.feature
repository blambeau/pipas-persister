Feature: Serving the scheduling problem
  In order for the Scheduler to to compute the optimal schedule
  As the PIPAS persister
  I want to provide it with the scheduling problem

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Responding to a RESTful request to the scheduling problem

    Given I receive a GET request to '/scheduling/problem' with the following headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the response should have the following headers:
      | Content-Type     |             X-Accuracy-Timestamp |
      | application/json | 2014-01-01T12:15:00.000000+00:00 |

    And the body should be a json object having the following keys:
      | key          |
      | scheduled_at |
      |      service |
      |   treatments |
