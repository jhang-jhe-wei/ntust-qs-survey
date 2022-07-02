@javascript
Feature: Download recommenders template excel

  Scenario: User can see download template excel link
    Given there is a user belongs to "營建工程系" logged in
    When I visit "/admin/recommenders/upload"
    Then I can see "填報表格檔案(Excel)"
