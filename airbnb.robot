*** Settings ***

Library  SeleniumLibrary
Library  ../../utility/utility.py  WITH NAME  utility
Variables  ../../objects/airbnb-search-criteria-objects.py

Resource  ap-commons.robot


*** Keywords ***
Input Location
    [Arguments]  ${location}
    Input Text  ${Location_Fld}  ${location}


Select Location From List
    PRESS KEYS  ${Location_Fld}  ENTER


Select Check-In Date From Calender
    ${check_in_date}  add days to current date  7
    ${checkin_date_loc}  CheckIn Date Locator  ${check_in_date}
    Click Element  ${checkin_date_loc}

Select Check-Out Date From Calender
    ${check_out_date}  add days to current date  14
    ${checkout_date_loc}  CheckOut Date Locator  ${check_out_date}
    Click Element  ${checkout_date_loc}

Click Add Guests Button
    Click Element  ${Guests_Btn}

Add Adults
    [Arguments]  ${total_adults}
    ${total_adults}  Evaluate    ${total_adults}+1
    Wait Until Element is Visible  ${adultsIncrease_Btn}
    FOR    ${INDEX}    IN RANGE    1    ${total_adults}
      Click Element  ${adultsIncrease_Btn}
    END

Add Children
    [Arguments]  ${total_children}
    ${total_children}  Evaluate    ${total_children}+1
    FOR    ${INDEX}    IN RANGE    1    ${total_children}
      Click Element  ${childsIncrease_Btn}
    END
    Click Element  ${Guests_Btn}

Click Search Button
    Click Element  ${airbnb_logo}
    Click Element  ${search_Btn}

Check If Searched Location Is
    [Arguments]  ${location}
    Wait Until Element Is Visible  ${number_of_records}  20
    ${searched_loction}  Get Text  ${search_result_location}
    Should Be Equal  ${searched_loction}  ${location}

Check If Location Is Searched As Per Given Date
    Wait Until Element Is Visible  ${number_of_records}  20
    ${searched_date}  Get Text  ${search_result_date}
    Should Be Equal  ${searched_date}  Jan 28 – Feb 4

Check If Number of Searched Guests Are
    [Arguments]  ${number_of_guests}
    Wait Until Element Is Visible  ${number_of_records}  20
    ${searched_guests}  Get Text  ${search_result_guests}
    ${total_guests}  Catenate  ${number_of_guests} guests
    Should Be Equal  ${searched_guests}  ${total_guests}

Check If Guest Count In Each Search Result Is Not Less Than
    [Arguments]  ${total_guests}
    Wait Until Element Is Visible  ${number_of_records}  20
    ${count}  Get Element Count  ${number_of_records}
    FOR    ${INDEX}    IN RANGE    1    ${count}
       ${gust_list_item_loc}  Get List Item  ${INDEX}
       ${guest_list_item}  Get Text  ${gust_list_item_loc}
       ${number_of_guest}  text split  ${guest_list_item}
       Should Be True  ${number_of_guest} >= ${total_guests}
    END



CheckIn Date Locator
    [Arguments]  ${date}
    ${checkin_date_locator}  Catenate  xpath://div[@data-testid='datepicker-day-${date}']
    [return]  ${checkin_date_locator}

CheckOut Date Locator
    [Arguments]  ${date}
    ${checkout_date_locator}  Catenate  xpath://div[@data-testid='datepicker-day-${date}']
    [return]  ${checkout_date_locator}

Get List Item
    [Arguments]  ${index}
    ${list_item_loc}  Catenate  xpath:(//a/parent::div//div[contains(text(),'guests')])[${index}]
    [return]  ${list_item_loc}