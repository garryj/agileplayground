package forms.cayenne;

import java.util.List;

import org.apache.cayenne.ObjectContext;
import org.apache.cayenne.access.DataContext;
import org.apache.cayenne.exp.Expression;
import org.apache.cayenne.query.SelectQuery;

import forms.cayenne.persistent.Form;
import forms.cayenne.persistent.FormElement;

public class FormDataReserveMethods {
	
	/* Returns the form of given ID */
	public Form getForm(long formID) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<Form> forms;
		Form form;
		
		context = DataContext.createDataContext();
		
		qualifier = Expression.fromString("db:ID = " + formID);
		
		query = new SelectQuery(Form.class, qualifier);
		
		forms = context.performQuery(query);
		
		form = forms.get(0);
		
		return form;
	} // End of get form name
	
	
	/* Returns the name of a form of given ID */
	public String getFormName(long formID) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<Form> forms;
		Form form;
		String name;
		
		context = DataContext.createDataContext();
		
		qualifier = Expression.fromString("db:ID = " + formID);
		
		query = new SelectQuery(Form.class, qualifier);
		
		forms = context.performQuery(query);
		
		form = forms.get(0);
		
		name = form.getName();
		
		return name;
	} // End of get form name
	
	
	/* Sets the name of a form of given ID */
	public String setFormName(long formID, String name) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<Form> forms;
		Form form;
		
		context = DataContext.createDataContext();
		
		qualifier = Expression.fromString("db:ID = " + formID);
		
		query = new SelectQuery(Form.class, qualifier);
		
		forms = context.performQuery(query);
		
		form = forms.get(0);
		
		form.setName(name);
		
		context.commitChanges();
		
		return "Name change successful";
	} // End of set form name
	
	
	/* Creates a form of given name, assigning a unique ID */
	public String createForm(String name) {
		
		ObjectContext context;
		Form form;
		
		context = DataContext.createDataContext();

		form = context.newObject(Form.class);
		
		form.setName(name);
		
		context.commitChanges();

		return "Form has been created";
	} // End of create form
	
	
	/* Creates a form element with no attributes and appends to form */
	public String createFormElement(long formID) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<Form> forms;
		Form form;
		FormElement formElement;
		
		context = DataContext.createDataContext();
		
		// Get main form to add to
		qualifier = Expression.fromString("db:ID = " + formID);
		
		query = new SelectQuery(Form.class, qualifier);
		
		forms = context.performQuery(query);
		
		form = forms.get(0);
		
		
		// Create form element
		formElement = context.newObject(FormElement.class);
		
		formElement.setForm(form);

		return "Form element created";
	} // End create form element (no attributes)

	
	/* Creates a form element with attributes and appends to form */
	public String createFormElement(long formID, int height, int width, String content) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<Form> forms;
		Form form;
		FormElement formElement;
		
		context = DataContext.createDataContext();
		
		// Get main form to add to
		qualifier = Expression.fromString("db:ID = " + formID);
		
		query = new SelectQuery(Form.class, qualifier);
		
		forms = context.performQuery(query);
		
		form = forms.get(0);
		
		
		// Create form element
		formElement = context.newObject(FormElement.class);
		
		formElement.setForm(form);
		
		
		// Set attributes
		formElement.setHeight(50);
		
		formElement.setWidth(150);
		
		formElement.setContent("content");
		
		
		context.commitChanges();

		return "Form element created";
	} // End create form element (with attributes)
	
	
	/* Get the height of a form element of given ID */
	public int getFormElementHeight(long formElementID) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<FormElement> forms;
		FormElement formElement;
		int height;
		
		context = DataContext.createDataContext();
		
		qualifier = Expression.fromString("db:ElementID = " + formElementID);
		
		query = new SelectQuery(FormElement.class, qualifier);
		
		forms = context.performQuery(query);
		
		formElement = forms.get(0);
		
		height = formElement.getHeight();
		
		return height;
	} // End of get form element height
	
	
	/* Set the height of a form element of given ID */
	public String setFormElementHeight(long formElementID, int height) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<FormElement> forms;
		FormElement formElement;
		
		context = DataContext.createDataContext();
		
		qualifier = Expression.fromString("db:ElementID = " + formElementID);
		
		query = new SelectQuery(FormElement.class, qualifier);
		
		forms = context.performQuery(query);
		
		formElement = forms.get(0);
		
		formElement.setHeight(height);
		
		return "Form element height value updated";
	} // End of set form element height
	
	
	/* Get the width of a form element of given ID */
	public int getFormElementWidth(long formElementID) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<FormElement> forms;
		FormElement formElement;
		int width;
		
		context = DataContext.createDataContext();
		
		qualifier = Expression.fromString("db:ElementID = " + formElementID);
		
		query = new SelectQuery(FormElement.class, qualifier);
		
		forms = context.performQuery(query);
		
		formElement = forms.get(0);
		
		width = formElement.getWidth();
		
		return width;
	} // End of get form element width
	
	
	/* Set the width of a form element of given ID */
	public String setFormElementWidth(long formElementID, int width) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<FormElement> forms;
		FormElement formElement;
		
		context = DataContext.createDataContext();
		
		qualifier = Expression.fromString("db:ElementID = " + formElementID);
		
		query = new SelectQuery(FormElement.class, qualifier);
		
		forms = context.performQuery(query);
		
		formElement = forms.get(0);
		
		formElement.setWidth(width);
		
		return "Form element width value updated";
	} // End of set form element width
	
	
	/* Get the content of a form element of given ID */
	public String getFormElementContent(long formElementID) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<FormElement> forms;
		FormElement formElement;
		String content;
		
		context = DataContext.createDataContext();
		
		qualifier = Expression.fromString("db:ElementID = " + formElementID);
		
		query = new SelectQuery(FormElement.class, qualifier);
		
		forms = context.performQuery(query);
		
		formElement = forms.get(0);
		
		content = formElement.getContent();
		
		return content;
	} // End of get form element content
	
	
	/* Set the content of a form element of given ID */
	public String setFormElementContent(long formElementID, String content) {
		
		ObjectContext context;
		Expression qualifier;
		SelectQuery query;
		List<FormElement> forms;
		FormElement formElement;
		
		context = DataContext.createDataContext();
		
		qualifier = Expression.fromString("db:ElementID = " + formElementID);
		
		query = new SelectQuery(FormElement.class, qualifier);
		
		forms = context.performQuery(query);
		
		formElement = forms.get(0);
		
		formElement.setContent(content);
		
		return "Form element content value updated";
	} // End of set form element content
}
