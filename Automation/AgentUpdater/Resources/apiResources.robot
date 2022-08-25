*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${URL_API}        https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}        id=15
...               title=Book 15
...               pageCount=1500
&{BOOK_POST}      id=18975
...               title=Teste
...               description=API Testing
...               pageCount=300
...               excerpt=Test Book
&{BOOK_PUT}       title=PUT Request
...               description=API Testing PUT Request



*** Keywords ***
#Test Case 01 - API Get Request
Given an API endpoint
    Create Session    fakeAPI    ${URL_API}
When I send a GET request to the API
    ${ANSWER_GET}    GET On Session    fakeAPI    Books
    Log          ${ANSWER_GET.text}
    Set Test Variable    ${ANSWER_GET}
Then it should return a 200 status code
    [Arguments]         ${STATUSCODE_wanted}
    Should Be Equal As Strings    ${ANSWER_GET.status_code}    ${STATUSCODE_wanted}    
And a list with "${BOOKS_QT}" results
    Length Should Be    ${ANSWER_GET.json()}    ${BOOKS_QT}

#Test Case 02 - API Get Request With ID
When I send a GET request to the API with the ID "${ID_BOOK}"
    ${ANSWER_GET}    GET On Session    fakeAPI    Books/${ID_BOOK}
    Log          ${ANSWER_GET.text}
    Set Test Variable    ${ANSWER_GET}
And only the book I requested
    Dictionary Should Contain Item    ${ANSWER_GET.json()}    id            ${BOOK_15.id}
    Dictionary Should Contain Item    ${ANSWER_GET.json()}    title         ${BOOK_15.title}
    Dictionary Should Contain Item    ${ANSWER_GET.json()}    pageCount     ${BOOK_15.pageCount}
    Should Not Be Empty               ${ANSWER_GET.json()["description"]}
    Should Not Be Empty               ${ANSWER_GET.json()["excerpt"]}
    Should Not Be Empty               ${ANSWER_GET.json()["publishDate"]}

#Test Case 03 - API Post Request
When I send a POST request
    ${HEADERS}        Create Dictionary    content-type=application/json 
    ${ANSWER_POST}    POST On Session      fakeAPI    Books
    ...                                    data={"id":18975,"title": "Teste","description": "API Testing","pageCount": 300,"excerpt": "Test Book","publishDate": "2022-08-24T19:01:46.150Z"}
    ...                                    headers=${HEADERS}
    Log          ${ANSWER_POST.text}
    Set Test Variable    ${ANSWER_POST}    
Then the book should be registered
    Dictionary Should Contain Item    ${ANSWER_POST.json()}    id               ${BOOK_POST.id}
    Dictionary Should Contain Item    ${ANSWER_POST.json()}    title            ${BOOK_POST.title}
    Dictionary Should Contain Item    ${ANSWER_POST.json()}    description      ${BOOK_POST.description}
    Dictionary Should Contain Item    ${ANSWER_POST.json()}    pageCount        ${BOOK_POST.pageCount}
    Dictionary Should Contain Item    ${ANSWER_POST.json()}    excerpt          ${BOOK_POST.excerpt}
    Should Not Be Empty               ${ANSWER_POST.json()["publishDate"]}
And POST should return a 200 status code
    [Arguments]         ${STATUSCODE_wanted}
    Should Be Equal As Strings    ${ANSWER_POST.status_code}    ${STATUSCODE_wanted}

#Test Case 04 - API Put Request
When I send a PUT request to the API with the ID "${ID_BOOK}"
    ${HEADERS}        Create Dictionary    content-type=application/json
    ${ANSWER_PUT}     PUT On Session       fakeAPI    Books/${ID_BOOK}
    ...                                    data={"id":18975,"title": "PUT Request","description": "API Testing PUT Request","pageCount": 300,"excerpt": "Test Book","publishDate": "2022-08-25T19:01:46.150Z"}
    ...                                    headers=${HEADERS}
    Log          ${ANSWER_PUT.text}
    Set Test Variable    ${ANSWER_PUT} 
Then the book should be updated
    Dictionary Should Contain Item    ${ANSWER_PUT.json()}    title            ${BOOK_PUT.title}
    Dictionary Should Contain Item    ${ANSWER_PUT.json()}    description      ${BOOK_PUT.description}
And PUT should return a 200 status code
    [Arguments]         ${STATUSCODE_wanted}
    Should Be Equal As Strings    ${ANSWER_PUT.status_code}    ${STATUSCODE_wanted}

#Test Case 05 - API Delete Request
When I send a DELETE request to the API with the ID "${ID_BOOK}"
    ${ANSWER_DEL}    DELETE On Session    fakeAPI    Books/${ID_BOOK}
    Set Test Variable    ${ANSWER_DEL}
Then the book "${ID_BOOK}" should be deleted
    Should Be Empty    ${ANSWER_DEL.content}
And DELETE should return a 200 status code
    [Arguments]         ${STATUSCODE_wanted}
    Should Be Equal As Strings    ${ANSWER_DEL.status_code}    ${STATUSCODE_wanted}