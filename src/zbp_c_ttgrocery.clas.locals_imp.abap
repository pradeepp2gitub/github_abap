CLASS lhc_grocery DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS checkExpirationDate FOR MODIFY
      keys FOR ACTION Grocery~checkExpirationDate.

ENDCLASS.

CLASS lhc_grocery IMPLEMENTATION.

  METHOD checkExpirationDate.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

