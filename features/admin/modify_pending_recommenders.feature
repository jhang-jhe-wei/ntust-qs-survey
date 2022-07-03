@javascript
Feature: Modify pending recommenders
  Background:
    Given there is a user belongs to "營建工程系" logged in

  Scenario: User can see pending recommenders count
    Given there are 5 pending recommenders belong to "營建工程系" user
    When I visit "/admin/recommenders/upload"
    Then I can see "目前有 5 筆資料需要修正後才可存入"
