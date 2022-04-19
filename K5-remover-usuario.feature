Feature: Remover usuários 
    Como uma pessoa qualquer
    Desejo remover um usuário
    Para que suas informações não estejam mais registradas
    
    Background: Configurar base url
        Given url baseUrl
        And path "users"

    Scenario: Remover usuário com sucesso 
        #Criar um usuário 
        * def createUser = call read('hook.feature@CriarUsuario')
        * def idUser = createUser.response.id
        
        And path idUser
        When method delete
        Then status 204

    Scenario: Não deve ser possível deletar usuário com indenficador inválido
        # And path java.util.UUID.randomUUID()
        And path 1
        When method delete
        Then status 400

    