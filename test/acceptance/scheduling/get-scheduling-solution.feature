Feature: Serving the scheduling solution
  In order for components to know the current scheduling solution
  As the PIPAS persister
  I want to provide them with a service to get it

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Responding to a request to the scheduling solution

    Given I receive a GET request to '/scheduling/solution' with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the response should have the headers:
      | Content-Type     | Last-Modified                 | ETag                                       | Cache-Control           |
      | application/json | Wed, 01 Jan 2014 12:15:00 GMT | "6bedc894aa7b017297607a541cf18b6bef9b3c8d" | public, must-revalidate |

    And the body should be a json object having the keys:
      |    problem_key |
      |        service |
      |     treatments |
      |  last_modified |
      | last_scheduled |


