Feature: Posting a treatment
  In order to let the GUI posting information about treatments
  As the PIPAS persister
  I want to provide him with a service

  Background:
    Given the situation is the one described in the 'operation-tests/add-treatment' dataset

  Scenario: Posting a treatment info

    Given I receive a POST request to '/treatments/' with the headers:
      | Content-Type     |
      | application/json |

    And the request has the body:
      """
      {
        "diagnosis_date": "2014-03-01",
        "earliest_start_date": "2014-03-03",
        "latest_start_date": "2014-03-07",
        "patient": {
          "first_name": "John",
          "last_name":  "Doe",
          "gender":     "M"
        },
        "tplan_id": "bae04d10-66fb-0131-38cb-3c07545ed162"
      }
      """

    Then I should return a "201 Ok" response

    ### check that something changed

    Given I receive a GET request to the specified location with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response
    And the body should be a valid '/treatments/singular' resource representation
