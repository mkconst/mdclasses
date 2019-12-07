package com.github._1c_syntax.mdclasses;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.github._1c_syntax.mdclasses.jabx.original.MetaDataObject;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;

import static org.assertj.core.api.Assertions.assertThat;

class JABXOriginTest {

  private String basePath = "src/test/resources/metadata/original";

  @Test
  void testLoadConfiguration() {

    MetaDataObject MDObject = null;
    File XML = new File(basePath, "Configuration.xml");

    MetaDataObject mdObject = null;

    XmlMapper xmlMapper = new XmlMapper();
    xmlMapper.configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);

    try {
      MDObject = xmlMapper.readValue(XML, MetaDataObject.class);
    } catch (IOException e) {
      e.printStackTrace();
    }

    assertThat(MDObject).isNotNull();
    assertThat(MDObject.getConfiguration()).isNotNull();

  }

}
