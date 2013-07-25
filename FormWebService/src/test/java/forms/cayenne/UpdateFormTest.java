package forms.cayenne;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import forms.cayenne.persistent.Form;

public class UpdateFormTest {

	private static FormData formData = new FormData();
	private static long ID;
	
	
	@Before
	public void setUp() {
		
		Form form = formData.createForm("Test Case");
		ID = form.getID();
	}
	
	@Test
	public void updateForm() {
		
		formData.updateForm(ID, "Updated Test Case");
		
		assertEquals(formData.getForm(ID).getName(), "Updated Test Case");
	}
	
	@After
	public void tearDown() {
		
		formData.destroyForm(ID);
	}
}
