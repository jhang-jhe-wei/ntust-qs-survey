@javascript
Feature: Review recommenders

  Scenario: The department users can review recommenders who belong to them
    Given there is a user belongs to "營建工程系" logged in
    Given there are 5 學術界 recommenders belong to "營建工程系" user
    Given there are 3 產業界 recommenders belong to "營建工程系" user
    When I visit "/admin/recommenders"
    Then I can see "單位：營建工程系"
    And I can see "學術界名單，共計 5 筆"
    And I can see "產業界名單，共計 3 筆"

