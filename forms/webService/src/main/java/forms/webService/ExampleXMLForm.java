package forms.webService;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
 
@XmlRootElement(name = "ExampleForm")
public class ExampleXMLForm {
 
	String name;
	String name2;
	long ID;
 
	@XmlElement
	public String getName() {
		return name;
	}
 
	public void setName(String name) {
		this.name = name;
	}
 
	@XmlAttribute
	public long getID() {
		return ID;
	}
 
	public void setID(long formID) {
		this.ID = formID;
	}
}