@javascript
Feature: Share new recommender link

  Scenario: Users can share new recommender link
    Given there is a user belongs to "營建工程系" logged in
    When I visit "/admin/recommenders/share"
    Then I can see new recommender link
