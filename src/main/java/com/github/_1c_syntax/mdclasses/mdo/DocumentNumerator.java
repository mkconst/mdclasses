package com.github._1c_syntax.mdclasses.mdo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import com.github._1c_syntax.mdclasses.metadata.additional.MDOType;
import lombok.EqualsAndHashCode;
import lombok.Value;
import lombok.experimental.SuperBuilder;

@Value
@EqualsAndHashCode(callSuper = true)
@JsonDeserialize(builder = DocumentNumerator.DocumentNumeratorBuilderImpl.class)
@SuperBuilder
public class DocumentNumerator extends MDObjectBase {

  public MDOType getType() {
    return MDOType.DOCUMENT_NUMERATOR;
  }

  @JsonPOJOBuilder(withPrefix = "")
  @JsonIgnoreProperties(ignoreUnknown = true)
  static final class DocumentNumeratorBuilderImpl extends DocumentNumerator.DocumentNumeratorBuilder<DocumentNumerator, DocumentNumerator.DocumentNumeratorBuilderImpl> {
  }
}
