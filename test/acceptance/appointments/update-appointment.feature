Feature: Updating an appointment
  In order to let the GUI update appointments
  As the PIPAS persister
  I want to provide him with an update service

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Fixing an appointment date

    Given I receive a PUT request to '/appointments/e5f1ba70-671d-0131-38d1-3c07545ed162' with the headers:
      | Content-Type     |
      | application/json |

    And the request has the body:
      """
      {
        "fixed": true
      }
      """

    Then I should return a "200 Ok" response

    ### check that something changed

    Given I receive a GET request to '/appointments/e5f1ba70-671d-0131-38d1-3c07545ed162' with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the 'fixed' attribute should be true

  Scenario: Changing the date of an appointment

    Given I receive a PUT request to '/appointments/e5f1ba70-671d-0131-38d1-3c07545ed162' with the headers:
      | Content-Type     |
      | application/json |

    And the request has the body:
      """
      {
        "scheduled_at": "2014-03-04T12:34"
      }
      """

    Then I should return a "200 Ok" response

    ### check that something changed

    Given I receive a GET request to '/appointments/e5f1ba70-671d-0131-38d1-3c07545ed162' with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the 'scheduled_at' attribute should equal "2014-03-04T12:34"
