package forms.formController.groovy

import groovyx.net.http.RESTClient
import groovy.util.slurpersupport.GPathResult

output = "Hello, ${input}!" // For testing


/*
service = new RESTClient( 'http://localhost:8080/formWebService/Forms/' )

def response = service.get( path : '2/' )
assert response.status == 200

assert (response.data instanceof GPathResult) // parse response body using XML Slurper

output = response.data.name // Get name value from xml
*/