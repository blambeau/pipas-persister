Feature: Updating unavailabilities
  In order to let the GUI update unavailabilities
  As the PIPAS persister
  I want to provide him with an update service

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Adding an unavailability

    Given I receive a PUT request to '/unavailabilities/d9027510-66ff-0131-38cb-3c07545ed162' with the headers:
      | Content-Type     |
      | application/json |

    And the request has the body:
      """
      {
        "unavailable_at": "2014-05-24 09:00:00",
        "reason": "no reason"
      }
      """

    Then I should return a "200 Ok" response

    ### check that something changed

    Given I receive a GET request to '/unavailabilities/d9027510-66ff-0131-38cb-3c07545ed162' with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the 'unavailable_at' attribute should equal "2014-05-24 09:00:00"
