@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_BOOKING_DMO_M
  as projection on zi_booking_dmo_m
{
  key TravelId,
  key BookingId,
      BookingDate,
      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      _Customer.LastName as CustomerName,
      @ObjectModel.text.element: [ 'CarrierName' ]
      CarrierId,
      _Carrier.name      as CarrierName,
      ConnectionId,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      BookingStatus,
      LastChangedAt,
      /* Associations */
      _BookingStatus,
      _Carrier,
      _Connection,
      _Customer,
      _Supplement : redirected to composition child ZC_BOOKSUPL_DMO_M,
      _Travel     : redirected to parent zc_travel_dmo_m
}
