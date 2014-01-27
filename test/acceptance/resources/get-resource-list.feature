Feature: Getting the list of available resources
  In order to help other developers integrating with me
  As the PIPAS persister component
  I want to provide them with the list of available resources

  Scenario: Getting an overview of the available resources
  
    Given I receive a GET request to '/resources/' with the headers:
      | Accept           |
      | application/json |

    Then  I should return a "200 Ok" response

    And the response should have the headers:
      | Content-Type     |
      | application/json |

    And the body should be a json array

    And all objects in this array should have the keys:
      |       uri |
      |  synopsis |
      |     links |

    And the resource URI should be a valid service
    And the resource links should all point valid services

  Scenario: Getting an overview of the available resources in HTML

    Given I receive a GET request to '/resources/' with the headers:
      | Accept    |
      | text/html |

    Then  I should return a "200 Ok" response

    And the response should have the headers:
      | Content-Type            |
      | text/html;charset=utf-8 |
