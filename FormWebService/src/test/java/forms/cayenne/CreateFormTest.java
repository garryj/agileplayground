package forms.cayenne;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import forms.cayenne.persistent.Form;

public class CreateFormTest {

	private static FormData formData = new FormData();
	private static long ID;
	
	
	/*@Before
	public void setUp() {
		
		Form form = formData.createForm("Test Case");
		ID = form.getID();
	}*/
	
	@Test
	public void createForm() {
		
		Form form = formData.createForm("test");
		ID = form.getID();
		
		assertEquals(form.getName(), "test");
	}
	
	@After
	public void tearDown() {
		
		formData.destroyForm(ID);
	}
}
