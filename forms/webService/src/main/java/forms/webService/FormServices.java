package forms.webService;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import forms.cayenne.FormData;
 
@Path("Forms")
public class FormServices {
	
	private static FormData formData = new FormData();
 
	@GET
	@Path("/{formID}")
	@Produces(MediaType.APPLICATION_XML)
	public ExampleXMLForm getForm(@PathParam("formID") long formID) {
		
		//Form form = formData.getForm(formID);
 
		ExampleXMLForm form = new ExampleXMLForm();
		form.setName("test");
		form.setID(formID);
 
		return form;
	}
	
	
	@GET
	@Path("/clientTest")
	@Produces(MediaType.APPLICATION_XML)
	public ExampleXMLForm clientTest() {
		
		//Form form = formData.getForm(formID);
 
		ExampleXMLForm form = new ExampleXMLForm();
		form.setName("test");
		form.setID(1);
 
		return form;
	}
}