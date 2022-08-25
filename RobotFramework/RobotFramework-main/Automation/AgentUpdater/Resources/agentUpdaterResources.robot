*** Settings ***
Library    OperatingSystem

*** Variables ***
${path}        C:/FakeProject/Install
${bkp_path}    C:/FakeProject/Install/Backup
${stopped_service}     AppMgmt
${running_service}     Appinfo

*** Keywords ***
#-------------------Test Case 01 - Check Stopped Services-------------------#
Given there is a new application version
    Directory Should Exist    path=${path}
When request to update application
    Log To Console    New Version of Application
Then the service must be stopped
    ${rc_code}    ${output}    Run And Return Rc And Output  sc query ${stopped_service} | findstr /i STOPPED
    Run Keyword If    '${rc_code}' != '0'    Fail    Service is not stopped!
    Log To Console    ${output} 
#-------------------Test Case 02 - Check Running Services-------------------#
When the agent updater finishs the installation
    Log To Console    Application updated!
Then the Service must be started
    ${rc_code}    ${output}    Run And Return Rc And Output  sc query ${running_service} | findstr /i RUNNING
    Run Keyword If    '${rc_code}' != '0'    Fail    Service is not running!
    Log To Console    ${output}
#-------------------Test Case 03 - Existing Files---------------------------#
Given I'm in the application folder
    Directory Should Exist    path=${path}
When I search for the update file
    ${result}    List Directory    path=${path}
    # ${new_Result}    Convert To String    ${result}
    Log To Console    ${result}
    # Set Suite Variable    ${new_Result}
    Set Suite Variable    ${result}
Then the file should exist
    File Should Exist    path=${path}/teste.txt

#-------------------Test Case 04 - Backup folder exists---------------------------#
When I search for backup folder
    ${result}    List Directories In Directory    path=${path}
    Log To Console    ${result}

Then the folder should exist
    Directory Should Exist    path=${bkp_path}    

  #-------------------Test Case 05 - Backup folder exists---------------------------#  
Given I'm in the backup folder
    Directory Should Exist    path=${bkp_path}
When I check if the backup folder is empty
    Directory Should Not Be Empty     path=${bkp_path}
Then the folder must not be empty
    ${result2}    List Directory     path=${bkp_path}
    # ${new_Result2}     Convert To String    ${result2}
    Log To Console    ${result2}
    # Set Suite Variable    ${new_Result2}
     Set Suite Variable    ${result2}

#-------------------Test Case 06 - Backup folder content validation---------------------------#
When I compare the backup folder with the previous archive folder
    ${final_result}    Should Be Equal      ${result}     ${result2}
    ${compare_list}        Create List    ${result}     ${result2}
    Set Test Variable    ${compare_list}
Then Both folders must have the same content
    Log To Console       ${compare_list}
