CLASS z_class_pdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun_out.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS z_class_pdp IMPLEMENTATION.

  METHOD if_oo_adt_classrun_out~get.
         output = 'This is real app' .

  ENDMETHOD.


  METHOD if_oo_adt_classrun_out~write.
            output->write( output ).
  ENDMETHOD.


ENDCLASS.
