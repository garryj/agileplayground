package forms.formController.groovy

import groovyx.net.http.RESTClient


service = new RESTClient( 'http://localhost:8080/formWebService/Forms/' )

response = service.get( path : '460/' ) // returns HTTPResponseDecorator

resourceXML = response.data

