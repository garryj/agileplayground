package forms.formController.groovy

import groovyx.net.http.RESTClient

output = "Hello, ${input}!"
	 
/*service = new RESTClient( 'http://localhost:8080/myapp/myresource/' )
	 
def response = service.get( path : 'test' )
assert response.status == 200

output = response.getData().getText()*/