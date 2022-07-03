@javascript
Feature: Modify pending recommenders
  Background:
    Given there is a user belongs to "營建工程系" logged in

  Scenario: User can see pending recommenders count
    Given there are 5 pending recommenders belong to "營建工程系" user
    When I visit "/admin/recommenders/upload"
    Then I can see "目前有 5 筆資料需要修正後才可存入"

  Scenario: User can modify pending recommenders
    Given there are 1 pending recommenders belong to "營建工程系" user
    When I visit "/admin/recommenders/upload"
    And I click "修改"
    And I select "recommender_category" as "產業界"
    And I fill "recommender" form
      | field          | value                     |
      | provider_name  | 王小明                    |
      | provider_email | abc@gmail.com             |
      | title          | Dr.                       |
      | first_name     | Yo-Ming                   |
      | last_name      | Hsieh                     |
      | email          | ymhsieh@mail.ntust.edu.tw |
      | job_title      | Manager                   |
    And I fill "company" with "ACER"
    And I select "recommender_industry_id" as "Engineering"
    And I select "country" as "Taiwan"
    And I click "名單提交"
    Then I can see "已更新推薦者"
    And I can see "目前無待修正的資料"
