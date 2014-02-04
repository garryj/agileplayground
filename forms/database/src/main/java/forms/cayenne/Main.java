package forms.cayenne;

import forms.cayenne.persistent.Form;

/**
 * Main class.
 *
 */
public class Main {

    public static void main(String[] args) {

    	FormData formData = new FormData();
    	
    	Form form = formData.getForm(460);
    	
    	formData.createFormElement(460, "testElement", "I", 300, 600, "testContent");
    	
    	
    	System.out.println(form.getID()); // output
    	
    	System.out.println(form.getFormElement().size());
    }
}