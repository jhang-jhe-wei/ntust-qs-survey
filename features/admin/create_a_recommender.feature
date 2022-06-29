@javascript
Feature: Create a recommender

  Scenario: The user can create a "學術界" recommender
    Given there is a user belongs to "營建工程系" logged in
    When I visit "/admin/recommenders/new"
    Then I can see "填寫名冊前請先閱讀以下說明，謝謝您"
    When I select "category" as "學術界"
    Then I can not see "Industry(產業類別)"
    And I can not see "Company Name(公司名稱)"
    And I can not see "Country(所屬國家)"
    When I fill "recommender" form
      | field          | value                                            |
      | provider_name  | 王小明                                           |
      | provider_email | abc@gmail.com                                    |
      | title          | Dr.                                              |
      | first_name     | Yo-Ming                                          |
      | last_name      | Hsieh                                            |
      | email          | ymhsieh@mail.ntust.edu.tw                        |
      | job_title       | Professor                                        |
      | department     | Department of Civil and Construction Engineering |
    And I select "recommender_institution_id" as "臺灣科技大學"
    And I click "名單提交"
    Then I can see "推薦者已建立"
    And I can ensure the recommender has these attributes
      | field          | value                                            |
      | provider_name  | 王小明                                           |
      | provider_email | abc@gmail.com                                    |
      | title          | Dr.                                              |
      | first_name     | Yo-Ming                                          |
      | last_name      | Hsieh                                            |
      | email          | ymhsieh@mail.ntust.edu.tw                        |
      | job_title      | Professor                                        |
      | department     | Department of Civil and Construction Engineering |
    And I can ensure the recommender's "institution" is "臺灣科技大學"
    And I can ensure the recommender's "industry" is "Academic"


  Scenario: The user can create a "產業界" recommender
    Given there is a user belongs to "營建工程系" logged in
    When I visit "/admin/recommenders/new"
    Then I can see "填寫名冊前請先閱讀以下說明，謝謝您"
    When I select "category" as "產業界"
    Then I can not see "Department(所屬系所/單位名)"
    When I fill "recommender" form
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
    Then I can see "推薦者已建立"
    And I can ensure the recommender has these attributes
      | field          | value                     |
      | provider_name  | 王小明                    |
      | provider_email | abc@gmail.com             |
      | title          | Dr.                       |
      | first_name     | Yo-Ming                   |
      | last_name      | Hsieh                     |
      | email          | ymhsieh@mail.ntust.edu.tw |
      | job_title      | Manager                   |
    And I can ensure the recommender's "institution" is "ACER"
    And I can ensure the recommender's "industry" is "Engineering"

