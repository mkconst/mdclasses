package com.github._1c_syntax.mdclasses.mdo;

import com.github._1c_syntax.mdclasses.metadata.additional.AttributeType;
import com.github._1c_syntax.mdclasses.metadata.additional.MDOType;
import com.github._1c_syntax.mdclasses.metadata.additional.ModuleType;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class InformationRegisterTest extends AbstractMDOTest {
  InformationRegisterTest() {
    super(MDOType.INFORMATION_REGISTER);
  }

  @Override
  @Test
  protected void testEDT() {
    var mdo = getMDObjectEDT("InformationRegisters/РегистрСведений1/РегистрСведений1.mdo");
    checkBaseField(mdo, InformationRegister.class, "РегистрСведений1",
      "184d9d78-9523-4cfa-9542-a7ba72efe4dd");
    checkForms(mdo);
    checkTemplates(mdo);
    checkCommands(mdo);
    checkAttributes(((MDObjectComplex) mdo).getAttributes(), 1, "InformationRegister.РегистрСведений1",
      AttributeType.DIMENSION);
    checkModules(((MDObjectBSL) mdo).getModules(), 1, "InformationRegisters/РегистрСведений1",
      ModuleType.RecordSetModule);

  }

  @Override
  @Test
  protected void testDesigner() {
    var mdo = getMDObjectDesigner("InformationRegisters/РегистрСведений1.xml");
    checkBaseField(mdo, InformationRegister.class, "РегистрСведений1",
      "184d9d78-9523-4cfa-9542-a7ba72efe4dd");
    checkForms(mdo);
    checkTemplates(mdo);
    checkCommands(mdo);
    checkAttributes(((MDObjectComplex) mdo).getAttributes(), 1, "InformationRegister.РегистрСведений1",
      AttributeType.DIMENSION);
    assertThat(((MDObjectBSL) mdo).getModules()).hasSize(0);
  }

}
