Feature: Tests for the method DELETE

  Background:
    * def urlApi = 'https://api-irso.herokuapp.com'

  @first-demo
  Scenario: Delete customer
    * def new_resource = { nombres: 'leo', apellido: 'ramos', direccion: 'baires 100', cod_postal: '28019', telefono: '123456789'}

    # Create resource
    * url urlApi
    * path 'clientes'
    * request new_resource
    * method post
    * status 201
    * def id = response.id

    # Validate resource
    * url urlApi
    * path 'clientes', id
    * method get
    * status 200
    * set new_resource.id = id
    * match response == new_resource

    # Delete resource
    Given url urlApi
    And path 'clientes', id
    When method delete
    Then status 204

    # Validation not found
    * url urlApi
    * path 'clientes', id
    * method get
    * status 404
    * print response