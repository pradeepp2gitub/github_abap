@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zi_booking_dmo_m
  as select from zdb_booking_m
  association [1..1] to /dmo/carrier             as _Carrier       on  $projection.CarrierId = _Carrier.carrier_id
  association [0..1] to /DMO/I_Customer          as _Customer      on  $projection.CustomerId = _Customer.CustomerID
  association [1..1] to /DMO/I_Connection        as _Connection    on  $projection.ConnectionId = _Connection.ConnectionID
                                                                   and $projection.CarrierId    = _Connection.AirlineID
  association [1..1] to /DMO/I_Booking_Status_VH as _BookingStatus on  $projection.BookingStatus = _BookingStatus.BookingStatus
  association        to parent zi_travel_dmo_m   as _Travel        on  $projection.TravelId = _Travel.TravelId
  composition [0..*] of zi_booksupl_dmo_m        as _Supplement
{
  key travel_id       as TravelId,
  key booking_id      as BookingId,
      booking_date    as BookingDate,
      customer_id     as CustomerId,
      carrier_id      as CarrierId,
      connection_id   as ConnectionId,
      flight_date     as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price    as FlightPrice,
      currency_code   as CurrencyCode,
      booking_status  as BookingStatus,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      _Carrier,
      _Customer,
      _Connection,
      _BookingStatus,
      _Travel,
      _Supplement

}
