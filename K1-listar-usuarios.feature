Feature: Listar usuários 
    Como uma pessoa qualquer
    Desejo consultar todos os usuários cadastrados
    Para ter as informações de todos os usuários

    Background: Configuração url
        Given url baseUrl
        And path "users"

    Scenario: Listar usuários cadastrados
        When method get
        Then status 200
        Then match response == "#array"
        And match each response == read('responseFormat.json')



    