Feature: Criar usuários 
    Como uma pessoa qualquer
    Desejo registrar informações de usuário
    Para poder manipular estas informações livremente
    
    Background: Configuração url
        Given url baseUrl
        And path "users"
        * def payload = read('requestDefault.json')

    Scenario: Criar usuário com sucesso
        And request payload
        When method post
        Then status 201
        And match response == read('responseDefault.json')

    Scenario: Não deve ser possível criar usuário sem nome e email
        And request { }
        When method post
        Then status 400

    Scenario: Não deve ser possível criar usuário sem nome
        And request { email: "'elida' + java.util.UUID.randomUUID() + '@example.com'" }
        When method post
        Then status 400
    
    Scenario: Não deve ser possível criar usuário sem email
        And request { name: "Élida Beatriz" }
        When method post
        Then status 400

    Scenario: Não deve ser possível criar usuário com email inválido
        And request { email: "'elida' + java.util.UUID.randomUUID()" }
        When method post
        Then status 400 

    Scenario: Não deve ser possível criar usuário com email já utilizado
        #Criar usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
    
        And request {name: "Élida", email:"#(createUser.response.email)"}
        When method post
        Then status 422
        And match response == { error: "User already exists." }

    Scenario: Não deve ser possível criar nome com mais de 100 caracteres
        And request { name: "Red Wacky League Antlez Broke the Stereo Neon Tide Bring Back Honesty Coalition Feedback Hand of Aces", email: "'red' + java.util.UUID.randomUUID() + '@example.com'"}
        When method post
        Then status 400
    
    Scenario: Não deve ser possível criar email com mais de 60 caracteres
        And request { name: "Red Wacky", email: "redleagueantlezbrokestereoneontidebringbackhonesty@example.com"}
        When method post
        Then status 400


    
        


    