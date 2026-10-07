@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking supply projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_BOOKSUPL_DMO_M
  as projection on zi_booksupl_dmo_m
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZC_BOOKING_DMO_M,
      _Supplement,
      _Travel:redirected to zc_travel_dmo_m
}
