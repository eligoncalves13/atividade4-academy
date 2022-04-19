Feature: Remover usuários 
    Como uma pessoa qualquer
    Desejo remover um usuário
    Para que suas informações não estejam mais registradas
    
    Background: Configuração url
        Given url baseUrl
        And path "users"

    Scenario: Remover usuário com sucesso 
        #Criar usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def idUser = createUser.response.id
        
        And path idUser
        When method delete
        Then status 204

    Scenario: Não deve ser possível remover usuário com indenficador inválido
        And path "identificador-inválido"
        When method delete
        Then status 400

    Scenario: Comportamento igual a remover usuário com sucesso mesmo com identificador não localizado
        And path java.util.UUID.randomUUID()
        When method delete
        Then status 204

    