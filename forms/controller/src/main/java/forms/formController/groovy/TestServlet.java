package forms.formController.groovy;

import groovy.lang.Binding;
import groovy.util.GroovyScriptEngine;
import groovy.util.ResourceException;
import groovy.util.ScriptException;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**TODO
	 * Path only temporary - must be relative
	 */
	private static final String[] groovyRoots = new String[] { "../../Users/Tom/Desktop/repo/forms/controller/src/main/java/forms/formController/groovy/" };
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Enable CORS
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
		//Response Body
		PrintWriter out = response.getWriter();
		
		//Retrieve Resource
		Object retrievedXML = retrieveXML();
        
		//Respond With Appropriate Content Type
		List<String> accept = Arrays.asList(request.getHeader("accept").split("\\s*,\\s*"));
		
		if(accept.contains("application/json")) { // JSON Response Body
			
			response.setContentType("application/json");

			out.print(xmlToJson(retrievedXML));
		}
		else { // XML Response Body
			
			response.setContentType("application/xml");
			
			out.print(retrievedXML);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/*Map<String, String[]> map = request.getParameterMap();
		
		Set set = map.entrySet();
		
		Iterator it = set.iterator();
		
        while (it.hasNext()) {
        	
            Map.Entry<String, String[]> entry = (Entry<String, String[]>) it.next();
            String paramName = entry.getKey();

            String[] paramValues = entry.getValue();
            if (paramValues.length == 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() == 0)
                    System.out.println("No Value");
                else
                	System.out.println(paramValue);
            } else {
                for (int i = 0; i < paramValues.length; i++) {
                    System.out.println(paramValues[i]);
                }
            }
        }*/
        
        //request.getInputStream().read()
		
		
		//Enable CORS
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
		
		//Response Body
		PrintWriter out = response.getWriter();		
		
		//Retrieve Resource
		Object retrievedXML = retrieveXML();
        
		//Respond With Appropriate Content Type
		List<String> accept = Arrays.asList(request.getHeader("accept").split("\\s*,\\s*"));
		
		if(accept.contains("application/json")) { // JSON Response Body
			
			response.setContentType("application/json");

			out.print(xmlToJson(retrievedXML));
		}
		else { // XML Response Body
			
			response.setContentType("application/xml");
			
			out.print(retrievedXML);
		}
	}
	
	/*Retrieve XML From Web Service*/
	private Object retrieveXML() throws IOException {
		
		GroovyScriptEngine retrieveEngine = new GroovyScriptEngine(groovyRoots);
		Binding retrieveEngineBinding = new Binding();
		
		try {
			retrieveEngine.run("retrieve.groovy", retrieveEngineBinding);
		}
		catch (ResourceException | ScriptException e) {
			e.printStackTrace();
		}
		
		return retrieveEngineBinding.getVariable("resourceXML");
	}
	
	
	/*Convert XML To JSON*/
	private Object xmlToJson(Object xml) throws IOException {

		GroovyScriptEngine convertEngine = new GroovyScriptEngine(groovyRoots);
		Binding convertEngineBinding = new Binding();
		convertEngineBinding.setVariable("xml", xml);
		
		try {
			convertEngine.run("xmlToJson.groovy", convertEngineBinding);
		}
		catch (ResourceException | ScriptException e) {
			e.printStackTrace();
		}

		return convertEngineBinding.getVariable("json");
	}
}
