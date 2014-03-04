Feature: Posting a delivery
  In order to let the GUI posting information about deliveries
  As the PIPAS persister
  I want to provide him with a service

  Background:
    Given the situation is the one described in the 'operation-tests/add-delivery' dataset

  Scenario: Posting a delivery info

    Given I receive a POST request to '/deliveries/' with the headers:
      | Content-Type     |
      | application/json |

    And the request has the body:
      """
      {
        "treatment_id": "d9027510-66ff-0131-38cb-3c07545ed162",
        "step_id": "74685ae0-66fd-0131-38cb-3c07545ed162",
        "delivered_at": "2014-03-04 09:10:00",
        "delivered_dose": 0.9
      }
      """

    Then I should return a "201 Ok" response

    ### check that something changed

    Given I receive a GET request to the specified location with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response
    And the body should be a valid '/deliveries/singular' resource representation
    And the 'delivered_at' attribute should equal "2014-03-04 09:10:00"
