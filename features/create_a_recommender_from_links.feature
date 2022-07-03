@javascript
Feature: Create a recommender from the link

  Scenario: The user create a academic recommender from the link
    Given there are 1 users belong to "營建工程系"
    When I open the new recommender link from "營建工程系" user
    Then I can see "填寫名冊前請先閱讀以下說明，謝謝您"
    And I can see "營建工程系"
    When I select "recommender_category" as "學術界"
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
    And I can ensure "營建工程系" user has these attributes recommender
      | field          | value                                            |
      | provider_name  | 王小明                                           |
      | provider_email | abc@gmail.com                                    |
      | title          | Dr.                                              |
      | first_name     | Yo-Ming                                          |
      | last_name      | Hsieh                                            |
      | email          | ymhsieh@mail.ntust.edu.tw                        |
      | job_title      | Professor                                        |
      | department     | Department of Civil and Construction Engineering |
      | category       | 學術界                                           |
    And I can ensure "營建工程系" user has the recommender whose "institution" is "臺灣科技大學"

  Scenario: The user create a Industry recommender from the link
    Given there are 1 users belong to "機械工程系"
    When I open the new recommender link from "機械工程系" user
    Then I can see "填寫名冊前請先閱讀以下說明，謝謝您"
    And I can see "機械工程系"
    When I select "recommender_category" as "產業界"
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
    And I can ensure "機械工程系" user has these attributes recommender
      | field          | value                     |
      | provider_name  | 王小明                    |
      | provider_email | abc@gmail.com             |
      | title          | Dr.                       |
      | first_name     | Yo-Ming                   |
      | last_name      | Hsieh                     |
      | email          | ymhsieh@mail.ntust.edu.tw |
      | job_title      | Manager                   |
      | category       | 產業界                    |
    And I can ensure "機械工程系" user has the recommender whose "institution" is "ACER"
    And I can ensure "機械工程系" user has the recommender whose "industry" is "Engineering"


