Feature: Getting formal documentation about a specific resource
  In order to help other developers integrating with me
  As the PIPAS persister component
  I want to provide them with a service for obtaining documentation about specific resources

  Scenario: Getting documentation about a specific resource in json

    Given I receive a GET request to '/resources/scheduling/problem' with the headers:
      | Accept             |
      |   application/json |

    Then  I should return a "200 Ok" response

    And the response should have the headers:
      | Content-Type                   |
      | application/json;charset=utf-8 |

    And the body should be a json object having the keys:
      |         uri |
      |    synopsis |
      | description |
      |     remarks |
      |      schema |
      |    services |

  Scenario: Getting documentation about a specific resource in plain text

    Given I receive a GET request to '/resources/scheduling/problem' with the headers:
      | Accept       |
      |   text/plain |

    Then I should return a "200 Ok" response

    And the response should have the headers:
      | Content-Type             |
      | text/plain;charset=utf-8 |

  Scenario: Getting documentation about a unknown resource

    Given I receive a GET request to '/resources/no/such/one'

    Then  I should return a "404 Not Found" response
