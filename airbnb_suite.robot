*** Settings ***
Resource  ../resources/robot files/ap-commons.robot
Resource  ../resources/robot files/browser.robot
Resource  ../resources/robot files/airbnb.robot


Suite Setup  Open Browser
Test Teardown  Take Screenshot If Test Fail


*** Test Cases ***
Check That Area Is Being Searched As Per Given Location
    Input Location  Rome, Italy
    Select Location From List
    Select Check-In Date From Calender
    Select Check-Out Date From Calender
    Click Add Guests Button
    Add Adults  3
    Add Children  2
    Click Search Button
    Check If Searched Location Is  Rome

Check That Area Is Being Searched As Per Given Date
    Check If Location Is Searched As Per Given Date

Check That Area Is Being Searched As Per Given Number Of Guests
    Check If Number of Searched Guests Are  5

Check That Guest Count In Each Search Row Is According To Added Guests
    Check If Guest Count In Each Search Result Is Not Less Than  5

