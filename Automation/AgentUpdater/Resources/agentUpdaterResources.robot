*** Settings ***
Library    OperatingSystem
*** Variables ***
${path}        C:/FakeProject/Install
${dir_path}    C:/FakeProject/Install/Backup
${stopped_service}     AppMgmt
${running_service}     Appinfo

*** Keywords ***
# Check Running Services
#     ${rc_code}    ${output}    Run And Return Rc And Output  sc query ${running_service} | findstr /i RUNNING
#     Run Keyword If    '${rc_code}' != '0'    Fail    Service is not running!
#     Log To Console    ${output}

#-------------------Test Case 01 - Check Stopped Services-------------------#
Given there is a new application version
    Directory Should Exist    path=${path}
When Request to update application
    Log To Console    New Version of Application
Then The Service must be stopped
    ${rc_code}    ${output}    Run And Return Rc And Output  sc query ${stopped_service} | findstr /i STOPPED
    Run Keyword If    '${rc_code}' != '0'    Fail    Service is not stopped!
    Log To Console    ${output} 
#-------------------Test Case 02 - Check Running Services-------------------#

#-------------------Test Case 03 - Existing Files---------------------------#
Given I'm in the application folder
    Directory Should Exist    path=${path}
When I search for the update file
    ${result}    List Directory    path=${path}
    Log To Console    ${result} 
Then the file should exist
    File Should Exist    path=${path}/teste.txt
