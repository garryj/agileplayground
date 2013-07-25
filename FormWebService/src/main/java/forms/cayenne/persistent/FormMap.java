package forms.cayenne.persistent;

import forms.cayenne.persistent.auto._FormMap;

public class FormMap extends _FormMap {

    private static FormMap instance;

    private FormMap() {}

    public static FormMap getInstance() {
        if(instance == null) {
            instance = new FormMap();
        }

        return instance;
    }
}
