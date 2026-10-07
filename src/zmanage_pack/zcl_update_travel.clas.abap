CLASS zcl_update_travel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_update_travel IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " delete existing entries in the database table
    DELETE FROM zdb_travel_m.
    DELETE FROM zdb_booking_m.
    DELETE FROM zdb_booksupl_m.
    COMMIT WORK.

    " insert travel demo data
    INSERT zdb_travel_m FROM (
        SELECT *
          FROM /dmo/travel_m
      ).
    COMMIT WORK.

    " insert booking demo data
    INSERT zdb_booking_m FROM (
        SELECT *
          FROM /dmo/booking_m

      ).
    COMMIT WORK.

    INSERT zdb_booksupl_m FROM (
        SELECT *
          FROM /dmo/booksuppl_m

      ).
    COMMIT WORK.

    out->write( 'Travel and booking demo data inserted.' ).

  ENDMETHOD.
ENDCLASS.
