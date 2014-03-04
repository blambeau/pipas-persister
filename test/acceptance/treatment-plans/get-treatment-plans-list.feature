Feature: List of treatment plans
  In order to let other components know about treatment plans
  As the PIPAS persister
  I want to provide them with the list of treatment plans

  Background:
    Given the situation is the one described in the 'initial-state' dataset

  Scenario: Getting the list of treatment plans on the RESTful interface

    Given I receive a GET request to '/treatment-plans/' with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the response should have the headers:
      | Content-Type     |
      | application/json |

    And the body should be a valid '/treatment-plans/' resource representation
