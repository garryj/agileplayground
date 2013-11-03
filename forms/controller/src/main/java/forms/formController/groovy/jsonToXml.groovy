package forms.formController.groovy

import groovy.Json.JsonSlurper

def forms = slurper.parseText('[{"forms":{"1":{"ID":1, "Name":"form"}, {"2":{"ID":2, "Name":"form"}}}]')

def mapForms = [:]

for (Object o : forms) {
	
	for (Object i : (HashMap) o) {
		
		for (e in i) {
			
			println e.key " = " e.value
		}
	}
}