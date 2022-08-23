*** Settings ***
Documentation    This suite tests the agent updater features
Resource         ../Resources/agentUpdaterResources.robot    #indica onde os testes serão implementados

*** Test Cases ***
Test Case 01 - Check Stopped Services
    [Documentation]    This test verifies if the services were correctly stopped
    [Tags]             services    stopped 
    Given there is a new application version
    When request to update application
    Then the service must be stopped

Test Case 02 - Check Running Services
    [Documentation]    This test verifies if the services were correctly stopped
    [Tags]             services 
    Given there is a new application version
    When the agent updater finishs the installation
    Then the Service must be started

Test Case 03 - Existing Files
    [Documentation]    This test verifies if the files were correct saved in its path
    [Tags]             files
    Given I'm in the application folder
    When I search for the update file 
    Then the file should exist