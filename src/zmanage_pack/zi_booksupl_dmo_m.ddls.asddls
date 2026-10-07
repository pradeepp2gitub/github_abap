@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'booking supply'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_booksupl_dmo_m
  as select from zdb_booksupl_m
  association [1..1] to /DMO/I_Supplement       as _Supplement on  $projection.SupplementId = _Supplement.SupplementID

  association [1..1] to zi_travel_dmo_m         as _Travel     on  $projection.TravelId = _Travel.TravelId
  association        to parent zi_booking_dmo_m as _Booking    on  $projection.TravelId  = _Booking.TravelId
                                                               and $projection.BookingId = _Booking.BookingId
{
  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      _Supplement,
      _Booking,
      _Travel

}
