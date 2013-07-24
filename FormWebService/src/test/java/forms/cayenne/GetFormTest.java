package forms.cayenne;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import forms.cayenne.persistent.Form;

public class GetFormTest {

	private static FormData formData = new FormData();
	private static long ID;
	
	
	@Before
	public void setUp() {
		
		Form form = formData.createForm("Test Case");
		ID = form.getID();
	}
	
	@Test
	public void getForm() {
		
		Form form = formData.getForm(ID);
		assertEquals(form.getID(), ID);
		assertEquals(form.getName(), "Test Case");
	}
	
	@After
	public void tearDown() {
		
		formData.destroyForm(ID);
	}
}
