@javascript
Feature: Review recommenders
  Background:
    Given there are 1 users belong to "校務研究與發展中心"

  Scenario: Admin departments can delete recommenders in review page
    Given there is a user belongs to "校務研究與發展中心" logged in
    And there are 1 "產業界" recommenders belong to "校務研究與發展中心" user

    When I visit "/admin/recommenders"
    And I click "刪除" with confirmation
    Then I can see "產業界名單，共計 0 筆"
    And I can see "已成功刪除該推薦人"

  Scenario: Admin departments can delete recommenders in upload page
    Given there is a user belongs to "校務研究與發展中心" logged in
    And there are 1 pending recommenders belong to "校務研究與發展中心" user
    When I visit "/admin/recommenders/upload"
    And I click "刪除" with confirmation
    Then I can see "已成功刪除該推薦人"

