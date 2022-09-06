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

Test Case 04 - Check if Backup Folder exists
    [Documentation]    This test verifies if the backup folder exists
    [Tags]             files
    Given I'm in the application folder
    When I search for backup folder
    Then the folder should exist

Test Case 05 - Backup folder must not be empty
    [Documentation]    This test verifies the content of the backup folder
    [Tags]             files
    Given I'm in the backup folder
    When I check if the backup folder is empty
    Then the folder must not be empty

Test Case 06 - Backup folder content validation
    [Documentation]    This test verifies the content of the backup folder
    [Tags]             files
    Given I'm in the backup folder
    When I compare the backup folder with the previous archive folder
    Then Both folders must have the same content