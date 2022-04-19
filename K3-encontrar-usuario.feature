Feature: Encontrar usuários 
    Como uma pessoa qualquer
    Desejo consultar os dados de um usuário
    Para visualizar as informações deste usuário

    Background: Configuração url
        Given url baseUrl
        And path "users"

    Scenario: Encontrar usuário com sucesso 
        #Criar um usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def idUser = createUser.response.id
       
        And path idUser
        When method get
        Then status 200
        And match response == read('responseDefault.json')

    Scenario: Não deve ser possível encontrar usuário com identificador inválido
        And path java.util.UUID.randomUUID()
        When method get
        Then status 404