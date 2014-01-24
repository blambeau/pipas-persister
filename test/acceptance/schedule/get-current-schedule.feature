Feature: Getting the current schedule
  In order to compute/improve the current schedule
  As the scheduler component
  I want to obtain the current schedule from the persister

  Scenario: Getting the schedule on the RESTful interface

    Given I make a GET request to '/schedule' with the following headers:
      | Accept           |
      | application/json |

    Then I should receive a "200 Ok" response
    And the response should have the following headers:
      | Content-Type     |
      | application/json |

    And the body should be a json object having the following keys:
      | key        |
      |    service |
      | treatments |
