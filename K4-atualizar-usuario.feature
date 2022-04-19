Feature: Atualizar usuários 
    Como uma pessoa qualquer
    Desejo atualizar as informações de determinado usuário
    Para ter o registro de suas informações atualizadas
    
    Background: Configuração url
        Given  url baseUrl
        And path "users"
        * def payloadUpdate = read('requestUpdate.json')

    Scenario: Atualizar usuário com sucesso 
        #Criar um usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def idUser = createUser.response.id

        And path idUser
        And request payloadUpdate
        When method put
        Then status 200
        And match response == {id: "#(response.id)", name: "#(response.name)", email: "#(response.email)", createdAt: "#(response.createdAt)", updatedAt: "#(response.updatedAt)"}

    Scenario: Não deve ser possível atualizar usuário com identificador inválido
        And path java.util.UUID.randomUUID()
        And request payloadUpdate
        When method put
        Then status 404

    Scenario: Não deve ser possível atualizar usuários sem nome e email
        #Criar um usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def idUser = createUser.response.id

        And path idUser        
        And request { }
        When method put
        Then status 400

    Scenario: Não deve ser possível atualizar usuários sem nome
        #Criar um usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def idUser = createUser.response.id

        And path idUser 
        And request { email: "#('john' + java.util.UUID.randomUUID() + '@example.com')" }
        When method put
        Then status 400
    
    Scenario: Não deve ser possível criar usuários sem email
        #Criar um usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def idUser = createUser.response.id

        And path idUser 
        And request { name: "John Wick" }
        When method put
        Then status 400

    Scenario: Não deve ser possível atualizar usuários com email inválido
        #Criar um usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def idUser = createUser.response.id

        And path idUser 
        And request { name: "John Wick" email: "#('john' + java.util.UUID.randomUUID()" }
        When method put
        Then status 422 
        And match response == { error: "E-mail already in use." }

    Scenario: Não deve ser possível atualizar nome com mais de 100 caracteres
        #Criar um usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def idUser = createUser.response.id

        And path idUser 
        And request { name: "John Wacky League Antlez Broke the Stereo Neon Tide Bring Back Honesty Coalition Feedback Hand of Aces", email: "#('john' + java.util.UUID.randomUUID()"}
        When method post
        Then status 400
    
    Scenario: Não deve ser possível atualizar email com mais de 60 caracteres
        #Criar um usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def idUser = createUser.response.id

        And path idUser 
        And request { name: "John Wacky", email: "johnleagueantlezbrokestereoneontidebringbackhonestyaces@mail.com"}
        When method post
        Then status 400

    