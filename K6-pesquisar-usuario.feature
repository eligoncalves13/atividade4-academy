Feature: Encontrar usuários 
    Como uma pessoa qualquer
    Desejo consultar os dados de um usuário
    Para visualizar as informações deste usuário

    Background: Configurção url
        Given url baseUrl
        And path "search"

        #Criar um usuário 
        * def createUser = call read('K2-criar-usuario.feature@CriarUsuario')
        * def nameUser = createUser.response.name
        * def emailUser = createUser.response.email
       
    Scenario: Pesquisar usuário por nome
        And params nameUser
        When method get
        Then status 200
        And match response == read('responseDefault.json')

    Scenario: Pesquisar usuário por email
        And params emailUser
        When method get
        Then status 200
        And match response == read('responseDefault.json')
