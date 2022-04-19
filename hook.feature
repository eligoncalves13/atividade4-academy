Feature: Hook

@CriarUsuario
Scenario: Criar usuário 
    * def payload = read('requestDefault.json')
    Given url baseUrl
    And path "users"
    And request payload
    When method post
    Then status 201

@ignore
@RemoverUsuario
Scenario: Remover usuário 
    Given url baseUrl
    And path "users"
    And path idUser
    When method delete
    Then status 204