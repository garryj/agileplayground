package forms.cayenne.persistent.auto;

import forms.cayenne.persistent.FormElement;

/**
 * Class _TextArea was generated by Cayenne.
 * It is probably a good idea to avoid changing this class manually,
 * since it may be overwritten next time code is regenerated.
 * If you need to make any customizations, please use subclass.
 */
public abstract class _TextArea extends FormElement {

    public static final String COLS_PROPERTY = "cols";
    public static final String CONTENT_PROPERTY = "content";
    public static final String ROWS_PROPERTY = "rows";

    public static final String ELEMENT_ID_PK_COLUMN = "ElementID";

    public void setCols(Integer cols) {
        writeProperty("cols", cols);
    }
    public Integer getCols() {
        return (Integer)readProperty("cols");
    }

    public void setContent(String content) {
        writeProperty("content", content);
    }
    public String getContent() {
        return (String)readProperty("content");
    }

    public void setRows(Integer rows) {
        writeProperty("rows", rows);
    }
    public Integer getRows() {
        return (Integer)readProperty("rows");
    }

}
