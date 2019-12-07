

package com.github._1c_syntax.mdclasses.jabx.original;

import com.fasterxml.jackson.annotation.JsonProperty;


public enum TypeCategories {

  @JsonProperty("TabularSectionRow")
  TABULAR_SECTION_ROW("TabularSectionRow"),
  @JsonProperty("Object")
  OBJECT("Object"),
  @JsonProperty("Ref")
  REF("Ref"),
  @JsonProperty("Selection")
  SELECTION("Selection"),
  @JsonProperty("List")
  LIST("List"),
  @JsonProperty("Manager")
  MANAGER("Manager"),
  @JsonProperty("ValueManager")
  VALUE_MANAGER("ValueManager"),
  @JsonProperty("RecordManager")
  RECORD_MANAGER("RecordManager"),
  @JsonProperty("RecordSet")
  RECORD_SET("RecordSet"),
  @JsonProperty("RecordKey")
  RECORD_KEY("RecordKey"),
  @JsonProperty("Characteristic")
  CHARACTERISTIC("Characteristic"),
  @JsonProperty("ExtDimensions")
  EXT_DIMENSIONS("ExtDimensions"),
  @JsonProperty("ExtDimensionTypesRow")
  EXT_DIMENSION_TYPES_ROW("ExtDimensionTypesRow"),
  @JsonProperty("DisplacingCalculationTypes")
  DISPLACING_CALCULATION_TYPES("DisplacingCalculationTypes"),
  @JsonProperty("DisplacingCalculationTypesRow")
  DISPLACING_CALCULATION_TYPES_ROW("DisplacingCalculationTypesRow"),
  @JsonProperty("BaseCalculationTypes")
  BASE_CALCULATION_TYPES("BaseCalculationTypes"),
  @JsonProperty("BaseCalculationTypesRow")
  BASE_CALCULATION_TYPES_ROW("BaseCalculationTypesRow"),
  @JsonProperty("LeadingCalculationTypes")
  LEADING_CALCULATION_TYPES("LeadingCalculationTypes"),
  @JsonProperty("LeadingCalculationTypesRow")
  LEADING_CALCULATION_TYPES_ROW("LeadingCalculationTypesRow"),
  @JsonProperty("Recalcs")
  RECALCS("Recalcs"),
  @JsonProperty("RoutePointRef")
  ROUTE_POINT_REF("RoutePointRef"),
  @JsonProperty("TablesManager")
  TABLES_MANAGER("TablesManager"),
  @JsonProperty("Record")
  RECORD("Record"),
  @JsonProperty("TabularSection")
  TABULAR_SECTION("TabularSection"),
  @JsonProperty("ExtDimensionTypes")
  EXT_DIMENSION_TYPES("ExtDimensionTypes"),
  @JsonProperty("CubesManager")
  CUBES_MANAGER("CubesManager"),
  @JsonProperty("DimensionTables")
  DIMENSION_TABLES("DimensionTables"),
  @JsonProperty("DefinedType")
  DEFINED_TYPE("DefinedType");
  private final String value;

  TypeCategories(String v) {
    value = v;
  }

  public String value() {
    return value;
  }

  public static TypeCategories fromValue(String v) {
    for (TypeCategories c : TypeCategories.values()) {
      if (c.value.equals(v)) {
        return c;
      }
    }
    throw new IllegalArgumentException(v);
  }

}
