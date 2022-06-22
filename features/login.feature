@login
Feature: Login
  Background:
    When I open landing page

  Scenario: Login with department user
    Given there are some users belong to "營建工程系"
      | email                    | password |
      | tu6685@mail.ntust.edu.tw | 12345678 |
    When I fill "user" form
      | field    | value                    |
      | email    | tu6685@mail.ntust.edu.tw |
      | password | 12345678                 |
    And I click "Log in"
    Then I can see "成功登入了。"
    And I can see "登入單位：營建工程系"
