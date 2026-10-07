CLASS lhc_zi_travel_dmo_m DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zi_travel_dmo_m RESULT result.


    METHODS earlynumbering_create FOR NUMBERING
       entities FOR CREATE zi_travel_dmo_m.

**    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
**      REQUEST requested_authorizations FOR zi_travel_dmo_m RESULT result.

ENDCLASS.

CLASS lhc_zi_travel_dmo_m IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

*  METHOD get_global_authorizations.
*  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA(lt_entities)  = entities.



    DELETE  lt_entities WHERE TravelId IS NOT INITIAL.
    TRY.
        TYPES: ty_packed_dec TYPE p LENGTH 8 DECIMALS 3.
        " Call number range object to get next sequential ID
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr       = '01'
            object            = '/DMO/TRV_M'
            quantity          = CONV #( Lines( lt_entities ) )
          IMPORTING
            number            = DATA(lv_number)
            returncode        = DATA(lv_returncode)
            returned_quantity = DATA(lv_qty).

      CATCH cx_number_ranges INTO DATA(lo_error).

        LOOP AT lt_entities INTO DATA(ls_entities).
          APPEND VALUE #( %cid = ls_entities-%cid
                         %key =  CORRESPONDING #( ls_entities-%key ) )
                         TO failed-zi_booking_dmo_m.
          APPEND VALUE #( %cid = ls_entities-%cid
                         %key =  CORRESPONDING #( ls_entities-%key )
                         %msg = lo_error )
                         TO reported-zi_booking_dmo_m.
        ENDLOOP.
    ENDTRY.

    ASSERT lv_qty = Lines( lt_entities ).

    DATA: lt_travel_dmo_m TYPE TABLE FOR MAPPED EARLY zi_travel_dmo_m,
          ls_travel_dmo_m LIKE LINE OF lt_travel_dmo_m.

    DATA(lv_curr_num) = CONV ty_packed_dec( lv_number - lv_qty ).



    LOOP AT lt_entities INTO ls_entities.
      lv_curr_num = lv_curr_num + 1.
      ls_travel_dmo_m = VALUE #( %cid = ls_entities-%cid TravelId = lv_curr_num ).
      APPEND ls_travel_dmo_m TO mapped-zi_travel_dmo_m.

    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
