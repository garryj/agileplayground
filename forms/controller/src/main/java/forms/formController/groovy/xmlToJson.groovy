package forms.formController.groovy

//xml = "${xml}"

def xml = "<forms><name>test</name><ID>1</ID></forms>"


def parsed = new XmlParser().parseText(xml)


def handle
handle = { node ->
  if( node instanceof String ) {
	  node
  }
  else {
	  [ (node.name()): node.collect( handle ) ]
  }
}


def jsonObject = [ (parsed.name()): parsed.collect { node ->
	[ (node.name()): node.collect( handle ) ]
} ]


def json = new groovy.json.JsonBuilder( jsonObject )


json = json.toString()