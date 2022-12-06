@javascript
Feature: Review recommenders
  Background:
    Given there are 1 users belong to "校務研究與發展中心"
    Given there are 1 "產業界" recommenders belong to "校務研究與發展中心" user

  Scenario: The user belongs to admin departments can delete recommenders
    Given there is a user belongs to "校務研究與發展中心" logged in
    When I visit "/admin/recommenders"
    And I click "刪除" with confirmation
    Then I can see "產業界名單，共計 0 筆"
    And I can see "已成功刪除該推薦人"
