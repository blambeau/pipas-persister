Feature: Serving the service planning
  In order for the GUI to display information about the planning
  As the PIPAS persister
  I want to provide it with the planning information

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Responding to a request to the service planning

    Given I receive a GET request to '/service/planning' with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the response should have the headers:
      | Content-Type     | Last-Modified                 | Cache-Control           |
      | application/json | Wed, 01 Jan 2014 12:15:00 GMT | public, must-revalidate |

    And the body should be a json object having the keys:
      |   current_time |
      |  last_modified |
      | last_scheduled |
      |     treatments |

