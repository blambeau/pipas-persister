Feature: Content negociation
  In order to support various scenarios, such as production vs.debugging
  As the PIPAS persister
  I want to support HTTP content negociation

  Scenario: Using application/json in production

    Given I receive a GET request to '/patients/' with the following headers:
      | Accept           |
      | application/json |

    Then I should return a "200 Ok" response

    And the response should have the following headers:
      | Content-Type     |
      | application/json |

  Scenario: Using text/plain in debugging and demonstrations

    Given I receive a GET request to '/patients/' with the following headers:
      | Accept       |
      |   text/plain |

    Then I should return a "200 Ok" response

    And the response should have the following headers:
      | Content-Type    |
      |      text/plain |

