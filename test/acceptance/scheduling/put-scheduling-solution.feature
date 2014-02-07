Feature: Saving a scheduling solution
  In order to let the scheduler save a scheduling solution
  As the PIPAS persister
  I want to provide him with a saving service

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Receiving a solution with a fresh accuracy timestamp and If-Match

    Given I receive a PUT request to '/scheduling/solution' with the headers:
      | Content-Type     |                                   If-Match |
      | application/json | "c9f0e57c4301b7286ff3ed1b6dc112cb0ff56ffb" |

    And the request has the body:
      """
      {
        "problem_key": "927118a0-6cba-0131-3a34-3c07545ed162",
        "service": {
          "bed_load": 1.0,
          "nurse_load": 1.0
        },
        "treatments": [
          {
            "treatment_id": "d9026fa0-66ff-0131-38cb-3c07545ed162",
            "rdi": 1.0,
            "appointments": [
              {
                "step_id": "74685ae0-66fd-0131-38cb-3c07545ed162",
                "scheduled_at": "2014-01-15T09:00:00"
              },
              {
                "step_id": "74685c90-66fd-0131-38cb-3c07545ed162",
                "scheduled_at": "2014-02-06T09:00:00"
              }
            ]
          }
        ]
      }
      """

    Then I should return a "200 Ok" response

    ### check that something changed

    Given I receive a GET request to '/scheduling/solution' with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the 'last_scheduled' attribute should be a few seconds ago

  Scenario: Receiving a solution with an outdated problem key
    Given I receive a PUT request to '/scheduling/solution' with the headers:
      | Content-Type     |
      | application/json |

    And the request has the body:
      """
      {
        "problem_key": "927118a0-6cba-0131-3a34-old",
        "service": {
          "bed_load": 1.0,
          "nurse_load": 1.0
        },
        "treatments": [
        ]
      }
      """

    Then I should return a "412 Precondition Failed" response

  Scenario: Receiving a solution with an outdated If-Match

    Given I receive a PUT request to '/scheduling/solution' with the headers:
      | Content-Type     |   If-Match |
      | application/json | "outdated" |

    Then I should return a "412 Precondition Failed" response
