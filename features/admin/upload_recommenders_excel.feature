@javascript
Feature: Upload recommenders excel

  Scenario: User can upload recommenders excel
    Given there is a user belongs to "營建工程系" logged in
    When I visit "/admin/recommenders/upload"
    Then I can see "※請依照指定檔案格式上傳，表格檔案請點選【填報表格檔案】進行下載"
    When I attach "recommender-test.xlsx" in "excel"
    And I click "匯入 Excel"
    Then I can see "成功匯入 2 筆"
    And I can see "待修正 2 筆"
    And I can ensure "營建工程系" user has 4 recommenders
