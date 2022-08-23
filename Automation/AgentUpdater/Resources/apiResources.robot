*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${URL_API}    https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}    id=15
...           title=Book 15
...           pageCount=1500


*** Keywords ***
#Test Case 01 - API Get Request
Given an API endpoint
    Create Session    fakeAPI    ${URL_API}
When I send a GET request to the API
    ${ANSWER}    GET On Session    fakeAPI    Books
    Log          ${ANSWER.text}
    Set Test Variable    ${ANSWER}
Then it should return a 200 status code
    [Arguments]         ${STATUSCODE_wanted}
    Should Be Equal As Strings    ${ANSWER.status_code}    ${STATUSCODE_wanted}    
And a list with "${BOOKS_QT}" results
    Length Should Be    ${ANSWER.json()}    ${BOOKS_QT}

#Test Case 02 - API Get Request With ID
When I send a GET request to the API with the ID "${ID_BOOK}"
    ${ANSWER}    GET On Session    fakeAPI    Books/${ID_BOOK}
    Log          ${ANSWER.text}
    Set Test Variable    ${ANSWER}
And only the book I requested
    Dictionary Should Contain Item    ${ANSWER.json()}    id            ${BOOK_15.id}
    Dictionary Should Contain Item    ${ANSWER.json()}    title         ${BOOK_15.title}
    Dictionary Should Contain Item    ${ANSWER.json()}    pageCount     ${BOOK_15.pageCount}
    Should Not Be Empty               ${ANSWER.json()["description"]}
    Should Not Be Empty               ${ANSWER.json()["excerpt"]}
    Should Not Be Empty               ${ANSWER.json()["publishDate"]}

    

    