Feature: Accessible Changelog
  In order to help other developers integrate with me
  As the Pipas Persister component
  I want to provide a Changelog online

  Scenario: Getting the changelog

    Given I receive a GET request to '/doc/changelog'

    Then  I should return a "200 Ok" response

    And the response should have the headers:
      | Content-Type            |
      | text/html;charset=utf-8 |
