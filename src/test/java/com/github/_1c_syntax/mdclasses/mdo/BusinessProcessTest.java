package com.github._1c_syntax.mdclasses.mdo;

import com.github._1c_syntax.mdclasses.metadata.additional.AttributeType;
import com.github._1c_syntax.mdclasses.metadata.additional.MDOType;
import com.github._1c_syntax.mdclasses.metadata.additional.ModuleType;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class BusinessProcessTest extends AbstractMDOTest {
  BusinessProcessTest() {
    super(MDOType.BUSINESS_PROCESS);
  }

  @Override
  @Test
  protected void testEDT() {
    var mdo = getMDObjectEDT("BusinessProcesses/БизнесПроцесс1/БизнесПроцесс1.mdo");
    checkBaseField(mdo, BusinessProcess.class, "БизнесПроцесс1",
      "560a32ca-028d-4b88-b6f2-6b7212bf31f8");
    checkForms(mdo);
    checkTemplates(mdo);
    checkCommands(mdo);
    assertThat(((MDObjectComplex) mdo).getAttributes()).hasSize(0);
    checkModules(((MDObjectBSL) mdo).getModules(), 1, "BusinessProcesses/БизнесПроцесс1",
      ModuleType.ObjectModule);

  }

  @Override
  @Test
  protected void testDesigner() {
    var mdo = getMDObjectDesigner("BusinessProcesses/БизнесПроцесс1.xml");
    checkBaseField(mdo, BusinessProcess.class, "БизнесПроцесс1",
      "560a32ca-028d-4b88-b6f2-6b7212bf31f8");
    checkForms(mdo);
    checkTemplates(mdo);
    checkCommands(mdo);
    assertThat(((MDObjectComplex) mdo).getAttributes()).hasSize(0);
    checkModules(((MDObjectBSL) mdo).getModules(), 0, "0", ModuleType.Unknown);
  }

}
