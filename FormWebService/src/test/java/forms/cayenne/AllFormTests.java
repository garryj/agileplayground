package forms.cayenne;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

@RunWith(Suite.class)
@SuiteClasses({ CreateFormTest.class, DestroyFormTest.class, GetFormTest.class,
		UpdateFormTest.class })
public class AllFormTests {

}
