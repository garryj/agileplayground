package forms.cayenne;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import forms.cayenne.persistent.Form;

public class DestroyFormTest {

	private static FormData formData = new FormData();
	private static long ID;
	
	
	@Before
	public void setUp() {
		
		Form form = formData.createForm("Test Case");
		ID = form.getID();
	}
	
	@Test
	public void destroyForm() {
		
		assertEquals(formData.destroyForm(ID), "Destroyed");
	}

}
