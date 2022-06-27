@landing_page
Feature: Landing Page

  Scenario: The visitor can see some information
    Given there are a user belongs to "營建工程系" logged in
    When I visit "/admin"
    Then I can see "登入單位：營建工程系"
    And I can see "登出"
    And I can see "名冊填報"
    And I can see "檢視名冊"
    And I can see "產生問卷連結"
    And I can see "名單匯入"
    And I can see "名單匯出"
