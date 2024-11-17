*** Settings ***

Library    RequestsLibrary
Library    String 
Library    Collections

Documentation    Keywords para criar dados randomicos para utilização em Testes


*** Keywords ***
Gerar Nome Empresa
    ${random_string}=    Generate Random String    10    [LOWER][NUMBERS]
    ${nome_empresa}=     Set Variable    RonCompany ${random_string} Ltda
    RETURN    ${nome_empresa}

Gerar Numero 14 Digitos
    ${random_number}=    Generate Random String    14    [NUMBERS]
    RETURN    ${random_number}

Gerar Valor Alfanumerico 14 caracteres
    ${random_string}=    Generate Random String    14    [LOWER][NUMBERS]
    RETURN    ${random_string}