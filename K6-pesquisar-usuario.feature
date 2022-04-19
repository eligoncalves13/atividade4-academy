Feature: Encontrar usuários 
    Como uma pessoa qualquer
    Desejo consultar os dados de um usuário
    Para visualizar as informações deste usuário

    Background: Configurção url
        Given url baseUrl
        And path "search"

        #Criar um usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def nameUser = createUser.response.name
        * def emailUser = createUser.response.email
       
    Scenario: Pesquisar usuário por nome
        And param value = nameUser
        When method get
        Then status 200
        And match response == "#array"
        And match each response contains read('responseFormat.json')
        
    Scenario: Pesquisar usuário por email
        And param value = emailUser
        When method get
        Then status 200
        And match response == "#array"
        And match each response contains read('responseFormat.json')