package forms.cayenne;

import forms.cayenne.persistent.Form;

/**
 * Main class.
 *
 */
public class Main {

    public static void main(String[] args) {

    	FormData formData = new FormData();
    	Form form = formData.getForm(400);
    	System.out.println(form.getID()); // output
    }
}