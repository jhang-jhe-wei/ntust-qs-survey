@javascript
Feature: Review recommenders
  Background:
    Given there are 1 users belong to "營建工程系"
    Given there are 1 users belong to "機械工程系"
    Given there are 5 "學術界" recommenders belong to "營建工程系" user
    Given there are 4 "學術界" recommenders belong to "機械工程系" user
    Given there are 3 "產業界" recommenders belong to "營建工程系" user
    Given there are 3 "產業界" recommenders belong to "機械工程系" user

  Scenario: The department users can review recommenders who belong to them
    Given there is a user belongs to "營建工程系" logged in
    When I visit "/admin/recommenders"
    Then I can see "department_id" select as "營建工程系"
    And I can see "學術界名單，共計 5 筆"
    And I can see "產業界名單，共計 3 筆"

  Scenario: The college users can review all recommenders who belong to their departments
    Given there is a user belongs to "工程學院" logged in
    When I visit "/admin/recommenders"
    Then I can see "department_id" select as "工程學院"
    And I can see "學術界名單，共計 9 筆"
    And I can see "產業界名單，共計 6 筆"

  Scenario: The college users can review department recommenders
    Given there is a user belongs to "工程學院" logged in
    When I visit "/admin/recommenders"
    And I select "department_id" as "營建工程系"
    Then I can see "department_id" select as "營建工程系"
    And I can see "學術界名單，共計 5 筆"
    And I can see "產業界名單，共計 3 筆"
