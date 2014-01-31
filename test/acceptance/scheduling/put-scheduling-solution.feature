Feature: Saving a scheduling solution
  In order to let the scheduler save a scheduling solution
  As the PIPAS persister
  I want to provide him with a saving service

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Receiving a solution with a fresh accuracy timestamp

    Given the current accuracy timestamp is:
      |             X-Accuracy-Timestamp |
      | 2014-01-01T12:15:00.000000+00:00 |

    Given I receive a PUT request to '/scheduling/solution'...

    And the request has the headers:
      | Accept           |             X-Accuracy-Timestamp |
      | application/json | 2014-01-01T12:15:00.000000+00:00 |

    And the request has the body:
      """
      {
        "treatments": [
          {
            "treatment_id": "d9026fa0-66ff-0131-38cb-3c07545ed162",
            "appointments": [
              {
                "step_id": "74685ae0-66fd-0131-38cb-3c07545ed162",
                "scheduled_at": "2014-01-15T09:00:00",
                "fixed": true
              },
              {
                "step_id": "74685c90-66fd-0131-38cb-3c07545ed162",
                "scheduled_at": "2014-02-06T09:00:00",
                "fixed": false
              },
            ]
          }
        ]
      }
      """

    Then I should return a "201 Created" response
