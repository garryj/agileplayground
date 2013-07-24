package org.forms.formService.cayenne.persistent.auto;

import java.util.List;

import org.apache.cayenne.CayenneDataObject;
import org.forms.formService.cayenne.persistent.FormElement;
import org.forms.formService.cayenne.persistent.Input;
import org.forms.formService.cayenne.persistent.TextArea;

/**
 * Class _Form was generated by Cayenne.
 * It is probably a good idea to avoid changing this class manually,
 * since it may be overwritten next time code is regenerated.
 * If you need to make any customizations, please use subclass.
 */
public abstract class _Form extends CayenneDataObject {

    public static final String NAME_PROPERTY = "name";
    public static final String FORM_ELEMENT_PROPERTY = "formElement";
    public static final String FORM_ELEMENT1_PROPERTY = "formElement1";
    public static final String FORM_ELEMENT2_PROPERTY = "formElement2";

    public static final String ID_PK_COLUMN = "ID";

    public void setName(String name) {
        writeProperty("name", name);
    }
    public String getName() {
        return (String)readProperty("name");
    }

    public void addToFormElement(FormElement obj) {
        addToManyTarget("formElement", obj, true);
    }
    public void removeFromFormElement(FormElement obj) {
        removeToManyTarget("formElement", obj, true);
    }
    @SuppressWarnings("unchecked")
    public List<FormElement> getFormElement() {
        return (List<FormElement>)readProperty("formElement");
    }


    public void addToFormElement1(Input obj) {
        addToManyTarget("formElement1", obj, true);
    }
    public void removeFromFormElement1(Input obj) {
        removeToManyTarget("formElement1", obj, true);
    }
    @SuppressWarnings("unchecked")
    public List<Input> getFormElement1() {
        return (List<Input>)readProperty("formElement1");
    }


    public void addToFormElement2(TextArea obj) {
        addToManyTarget("formElement2", obj, true);
    }
    public void removeFromFormElement2(TextArea obj) {
        removeToManyTarget("formElement2", obj, true);
    }
    @SuppressWarnings("unchecked")
    public List<TextArea> getFormElement2() {
        return (List<TextArea>)readProperty("formElement2");
    }


}
