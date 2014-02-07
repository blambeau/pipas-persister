Feature: Serving the scheduling problem
  In order for the Scheduler to to compute the optimal schedule
  As the PIPAS persister
  I want to provide it with the scheduling problem

  Background:
    Given the situation is the one described in the 'mid-state' dataset

  Scenario: Responding to a request to the scheduling problem

    Given I receive a GET request to '/scheduling/problem' with the headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the response should have the headers:
      | Content-Type     | Last-Modified                 | ETag                                       | Cache-Control           |
      | application/json | Wed, 01 Jan 2014 12:15:00 GMT | "c9f0e57c4301b7286ff3ed1b6dc112cb0ff56ffb" | public, must-revalidate |

    And the body should be a valid '/scheduling/problem' resource representation

  Scenario: Responding when If-None-Match is specified and not modified

    Given I receive a GET request to '/scheduling/problem' with the headers:
      | Accept           |                             If-None-Match |
      | application/json | "c9f0e57c4301b7286ff3ed1b6dc112cb0ff56ffb"|

    Then I should return a "304 Not Modified" response

  Scenario: Responding when If-Modified-Since is specified and not modified

    Given I receive a GET request to '/scheduling/problem' with the headers:
      | Accept           | If-Modified-Since             |
      | application/json | Wed, 01 Jan 2014 12:15:00 GMT |

    Then I should return a "304 Not Modified" response

  Scenario: Responding when If-Modified-Since is specified and modified

    Given I receive a GET request to '/scheduling/problem' with the headers:
      | Accept           | If-Modified-Since             |
      | application/json | Wed, 01 Jan 2014 12:14:00 GMT |

    Then I should return a "200 Ok" response

  Scenario: Responding when If-None-Match is specified and modified

    Given I receive a GET request to '/scheduling/problem' with the headers:
      | Accept           | If-None-Match |
      | application/json |         "foo" |

    Then I should return a "200 Ok" response
