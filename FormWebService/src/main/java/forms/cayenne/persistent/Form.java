package forms.cayenne.persistent;

import forms.cayenne.persistent.auto._Form;

public class Form extends _Form {

	public long getID() {
		return (Long) ((getObjectId() != null && !getObjectId().isTemporary())
				? getObjectId().getIdSnapshot().get(ID_PK_COLUMN)
						: null);
	}
}