@api
Feature: Courses as Student
  In order to participate in a course
  As a student
  I should be able to read course texts and responses and write responses

  Background:
    Given "course" content:
      | title         |
      | Course Alpha  |
      | Course Beta   |
    And "response" content:
      | title       | author    | body              |
      | Response A  | Student A | Student B smells  |
      | Response B  | Student B | Student A stinks  |
    # Note: the assignment of content to a course has to come after it's been created
    And response "Response A" is content for course "Course Alpha"
    And response "Response B" is content for course "Course Beta"
    And a "Student" user named "Student A" exists
    And "Student A" is enrolled in the "Course Alpha" course
    And a "Student" user named "Student B" exists
    And "Student B" is enrolled in the "Course Beta" course

  Scenario Outline:
    Given I am logged in as "Student A"
    When I go to the "course" node named "Course Alpha"
    Then I should see "Course Alpha" in the "Page Title" region
    And I should see "Course Alpha" in the "Course Selected" region
    And I should see <link> in the "Main Menu" region

    Examples:
    | link    |
    | Explore |
    | Create  |
    | Connect |
    | Reflect |
    | Account |
    | Help    |

   Scenario Outline:
     Given I am logged in as "Student A"
     When I go to the "course" node named "Course Beta"
     Then I should see "Course Beta" in the "Page Title"
     And I should not see <link> in the "Main Menu" region
     And I should see "About" in the "Main Menu"

     Examples:
       | link    |
       | Explore |
       | Create  |
       | Connect |
       | Reflect |
       | Account |
       | Help    |

    Scenario:
      Given I am logged in as "Student A"
      When I am on "/responses"
      Then I should see "Responses" in the "Page Title"
      And I should see "Response A" in the "View" region

    Scenario:
      Given I am logged in as "Student B"
      When I go to the "response" node titled "Response A"
      Then I should see "Access Denied"
