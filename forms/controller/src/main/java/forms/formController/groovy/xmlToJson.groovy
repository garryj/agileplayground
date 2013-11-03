package forms.formController.groovy

xml = "${xml}"

xml = "<ExampleForm><name>test</name></ExampleForm>"

/*

// Given an XML string
def xml = '''<root>
            |    <node>Tim</node>
            |    <node>Tom</node>
            |</root>'''.stripMargin()

// Parse it
def parsed = new XmlParser().parseText( xml )

// Convert it to a Map containing a List of Maps
def jsonObject = [ (parsed.name()): parsed.collect {
  [ (it.name()): it.text() ]
} ]

// And dump it as Json
def json = new groovy.json.JsonBuilder( jsonObject )

// Check it's what we expected
assert json.toString() == '{"root":[{"node":"Tim"},{"node":"Tom"}]}'

 */



/*

// Given an XML string
def xml = '''<root>
            |    <node>Tim</node>
            |    <node>Tom</node>
            |    <node>
            |      <anotherNode>another</anotherNode>
            |    </node>
            |</root>'''.stripMargin()
*/

// Parse it
def parsed = new XmlParser().parseText( xml )

// Deal with each node:
def handle
handle = { node ->
  if( node instanceof String ) {
      node
  }
  else {
      [ (node.name()): node.collect( handle ) ]
  }
}
// Convert it to a Map containing a List of Maps
def jsonObject = [ (parsed.name()): parsed.collect { node ->
   [ (node.name()): node.collect( handle ) ]
} ]

// And dump it as Json
def jsonBuild = new groovy.json.JsonBuilder( jsonObject )

json = jsonBuild.toString()

//json = '{\"forms\": [{ \"name\":\"FORM1\" , \"ID\":\"1\" }]}'