*** Settings ***
Resource    login.resource
Resource    randomicos.resource

*** Keywords ***
#Post
Criar dados da company
  ${palavra_aleatoria}  Generate Random String  length=20  chars=[LETTERS]
  Set Suite Variable    ${COMPANY_NOME}  ${palavra_aleatoria}
  ${numero_randomico}  Generate Random String  length=14  chars=[NUMBERS]
  Set Suite Variable    ${CNPJ_RAMDOM}    ${numero_randomico}
  Set Suite Variable    ${EMAIL_RAMDOM}    ${palavra_aleatoria}@qacoders.com.br
  Set Suite Variable    ${RAZÃO SOCIAL}  ${company_nome}
  Set Suite Variable    ${CONTATO-RESPONSAVEL}  ${palavra_aleatoria} R${palavra_aleatoria}
  Set Suite Variable    ${NUMERO_TELEFONE}  +(55)${numero_randomico}
  Set Suite Variable    ${DESCRICAO}  ${palavra_aleatoria}
  Set Suite Variable    ${LOGRADOURO}  ${palavra_aleatoria} '
  ${numero}     Generate Random String  length=10  chars=[NUMBERS]
  Set Suite Variable    ${NUMERO_COMPANY}  ${numero}


Cadastrar company
    ${address}  Create Dictionary  zipCode=04777001
     ...  city=São Paulo
     ...  state=SP
     ...  district=Rua das Flores
     ...  street=Avenida Interlagos
     ...  number=50
     ...  complement=de 4503 ao fim - lado ímpar
     ...  country=Brasil
     
     ${listAddress}  Create List    ${address}
     ${body}  Create Dictionary  corporateName=${COMPANY_NOME}
     ...  registerCompany=${CNPJ_RAMDOM}
     ...  mail=${EMAIL_RAMDOM}
     ...  matriz=Testeprimeiro
     ...  responsibleContact=Marcio
     ...  telephone=99999999999999
     ...  serviceDescription=Testes
     ...  address=${listAddress}
     Log  {body}
     ${resposta}    POST On Session    alias=develop    url=/api/company    json=${body}  
     Log    ${resposta.json()}
     Set Suite Variable    ${id_company}       ${resposta.json()["newCompany"]["_id"]}
    

Falha cadastro de company sem nome
    ${address}  Create Dictionary  zipCode=04777001
     ...  city=São Paulo
     ...  state=SP
     ...  district=Rua das Flores
     ...  street=Avenida Interlagos
     ...  number=50
     ...  complement=de 4503 ao fim - lado ímpar
     ...  country=Brasil
     
     ${listAddress}  Create List    ${address}
     ${body}  Create Dictionary  corporateName=
     ...  registerCompany=${CNPJ_RAMDOM}
     ...  mail=${EMAIL_RAMDOM}
     ...  matriz=Testeprimeiro
     ...  responsibleContact=Marcio
     ...  telephone=99999999999999
     ...  serviceDescription=Testes
     ...  address=${listAddress}
     Log  {body}
     ${resposta}    POST On Session    alias=develop    url=/api/company    json=${body}    expected_status=400
     Log    ${resposta.json()}
     Should Be Equal As Strings    O campo 'Nome da empresa' é obrigatório.    ${resposta.json()["error"][0]}
    

#GET
Listar company
  ${resposta}  GET ON Session  alias=develop  url=/api/company
  Log  ${resposta.json()}
Consultar company
  ${resposta}  GET ON Session  alias=develop  url=/api/company/${id_company}
  Log  ${resposta.json()}

#Put     
Atualizar status
  ${body}  Create Dictionary  status=false  
  ${resposta}  PUT On Session  alias=develop  url=/api/company/status/${id_company}  json=${body} 

Editar cadastro da company
    ${corporate_Name}=     Gerar Nome Empresa
    ${register_Company}=   Gerar Numero 14 Digitos
    ${matriz}=  Gerar Valor Alfanumerico 14 caracteres
  ${body}  Create Dictionary
  ...    corporateName=${corporate_Name}
  ...    registerCompany=${register_Company}
  ...    mail=testrontest@test.com
  ...    matriz=${matriz}
  ...    responsibleContact=MarcioRonBugado
  ...    telephone=01234567891234
  ...    serviceDescription=TestesRonBugado
  ${resposta}  PUT On Session  alias=develop  url=/api/company/${id_company}  json=${body}
  Log  ${resposta} 

Editar endereço da company
  ${address}  Create Dictionary  zipCode=04777001
  ...  city=São Paulo
  ...  state=SP
  ...  district=Rua das Flores
  ...  street=Avenida Interlagos
  ...  number=50
  ...  complement=de 4503 ao fim - lado ímpar
  ...  country=Brasil 
  ${listAddress}  Create List  ${address}
  ${body}  Create Dictionary  address=${listAddress}

  ${resposta}  PUT On Session  alias=develop  url=/api/company/address/${id_company}  json=${body}
  Log  ${resposta} 

#DLelete 
Deletar company
  ${resposta}  DELETE On Session  alias=develop  url=/api/company/${id_company}   
  Log  ${resposta.json()}