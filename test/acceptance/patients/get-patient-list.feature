Feature: List of registered patients
  In order to let other components know about registered patients
  As the PIPAS persister
  I want to provide them with the list of patients

  Background:
    Given the situation is the one described in the 'initial-state' dataset

  Scenario: Getting the list of patients on the RESTful interface

    Given I receive a GET request to '/patients/' with the following headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the response should have the following headers:
      | Content-Type     |
      | application/json |

    And the body should be a json array

    And all objects in this array should have the following keys:
      | key          |
      |   patient_id |
      |   first_name |
      |    last_name |
      |       gender |
