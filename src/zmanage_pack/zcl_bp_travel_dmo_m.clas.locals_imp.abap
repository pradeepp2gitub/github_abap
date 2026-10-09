CLASS lhc_zi_travel_dmo_m DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zi_travel_dmo_m RESULT result.

    METHODS accepttravel FOR MODIFY
       keys FOR ACTION zi_travel_dmo_m~accepttravel RESULT result.

    METHODS copytravel FOR MODIFY
       keys FOR ACTION zi_travel_dmo_m~copytravel.

    METHODS recalctotalprice FOR MODIFY
       keys FOR ACTION zi_travel_dmo_m~recalctotalprice.

    METHODS rejecttravel FOR MODIFY
       keys FOR ACTION zi_travel_dmo_m~rejecttravel RESULT result.


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

  METHOD acceptTravel.

    MODIFY ENTITIES OF zi_travel_dmo_m IN LOCAL MODE
            ENTITY zi_travel_dmo_m
            UPDATE FIELDS ( OverallStatus )
            WITH VALUE #( FOR ls_keys IN keys ( %tky = ls_keys-%tky OverallStatus = 'A' ) ).

    READ ENTITIES OF zi_travel_dmo_m IN LOCAL MODE
    ENTITY zi_travel_dmo_m
    ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(it_result).

    result = VALUE #( FOR ls_result IN it_result ( %tky = ls_result-%tky
                            %param = ls_result  ) ).

  ENDMETHOD.

  METHOD copyTravel.

    DATA: it_travel         TYPE TABLE FOR CREATE zi_travel_dmo_m,
          it_booking_cba    TYPE TABLE FOR CREATE zi_travel_dmo_m\_booking,          " " create by association
          it_supplement_cba TYPE TABLE FOR CREATE zi_booking_dmo_m\_Supplement.  " create by association



    READ TABLE keys ASSIGNING FIELD-SYMBOL(<ls_without_cid>) WITH KEY %cid = ' '.
    ASSERT <ls_without_cid> IS NOT ASSIGNED.

    READ ENTITIES OF zi_travel_dmo_m IN LOCAL MODE                    " Read entities of root entity Travel
        ENTITY zi_travel_dmo_m
        ALL FIELDS WITH CORRESPONDING #( keys )    " Read first entity  Travel for all key fields
        RESULT DATA(it_travel_result)                                     " result in new i_tab
        FAILED DATA(it_failed).                                           " failed in new i_tab

    READ ENTITIES OF zi_travel_dmo_m IN LOCAL MODE                    " Read entities of root entity Travel
        ENTITY zi_travel_dmo_m BY \_Booking
        ALL FIELDS WITH CORRESPONDING #( it_travel_result )    " Read second entity Booking for all key fields
        RESULT DATA(it_booking_result) .

    READ ENTITIES OF zi_travel_dmo_m IN LOCAL MODE                    " Read entities of root entity Travel
        ENTITY zi_booking_dmo_m BY \_Supplement
        ALL FIELDS WITH CORRESPONDING #( it_booking_result )    " Read third entity Supplement for all key fields
        RESULT DATA(it_supplement_result) .


    LOOP AT it_travel_result ASSIGNING FIELD-SYMBOL(<ls_travel_r>).

      APPEND INITIAL LINE TO it_travel ASSIGNING FIELD-SYMBOL(<ls_travel>).
      <ls_travel>-%cid = keys[ KEY entity TravelId = <ls_travel_r>-TravelId ]-%cid.
      <ls_travel>-%data = CORRESPONDING #( <ls_travel_r> EXCEPT TravelId ).

      APPEND VALUE #( %cid_ref = <ls_travel>-%cid ) TO it_booking_cba ASSIGNING FIELD-SYMBOL(<it_booking>).

      LOOP AT it_booking_result ASSIGNING FIELD-SYMBOL(<ls_booking_r>) USING KEY entity
                       WHERE TravelId = <ls_travel_r>-TravelId.

        APPEND VALUE #(  %cid = <ls_travel>-%cid && <ls_booking_r>-BookingId
                         %data = CORRESPONDING #( <ls_booking_r> EXCEPT TravelId ) )
                          TO <it_booking>-%target ASSIGNING FIELD-SYMBOL(<ls_booking_new>).

        APPEND VALUE #(  %cid_ref = <ls_booking_new>-%cid )
                        TO it_supplement_cba ASSIGNING FIELD-SYMBOL(<ls_suppl>)      .

        LOOP AT it_supplement_result ASSIGNING FIELD-SYMBOL(<ls_supplement_r>) USING KEY entity
                                                 WHERE TravelId = <ls_travel_r>-TravelId
                                                    AND BookingId =  <ls_booking_r>-BookingId.

          APPEND VALUE #( %cid = <ls_travel>-%cid && <ls_booking_r>-BookingId &&  <ls_supplement_r>-BookingSupplementId
                       %data = CORRESPONDING #( <ls_supplement_r> EXCEPT TravelId BookingId ) )
                       TO  <ls_suppl>-%target .

        ENDLOOP.

      ENDLOOP.

    ENDLOOP.

    MODIFY ENTITIES OF zi_travel_dmo_m IN LOCAL MODE
     ENTITY zi_travel_dmo_m
     CREATE FIELDS ( AgencyId CustomerId BeginDate EndDate BookingFee TotalPrice CurrencyCode OverallStatus Description )
     WITH it_travel ENTITY zi_travel_dmo_m
     CREATE BY \_Booking
     FIELDS ( BookingId BookingDate CustomerId CarrierId ConnectionId FlightDate FlightPrice CurrencyCode BookingStatus  )
     WITH it_booking_cba ENTITY zi_booking_dmo_m
     CREATE BY \_Supplement
     FIELDS ( BookingSupplementId SupplementId Price CurrencyCode )
     WITH it_supplement_cba MAPPED DATA(it_mapped).

    mapped-zi_travel_dmo_m = it_mapped-zi_travel_dmo_m.

  ENDMETHOD.

  METHOD reCalcTotalPrice.
  ENDMETHOD.

  METHOD rejectTravel.

    MODIFY ENTITIES OF zi_travel_dmo_m IN LOCAL MODE
          ENTITY zi_travel_dmo_m
          UPDATE FIELDS ( OverallStatus )
          WITH VALUE #( FOR ls_keys IN keys ( %tky = ls_keys-%tky OverallStatus = 'X' ) ).

    READ ENTITIES OF zi_travel_dmo_m IN LOCAL MODE
    ENTITY zi_travel_dmo_m
    ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(it_result).

    result = VALUE #( FOR ls_result IN it_result ( %tky = ls_result-%tky
                            %param = ls_result  ) ).

  ENDMETHOD.

ENDCLASS.
