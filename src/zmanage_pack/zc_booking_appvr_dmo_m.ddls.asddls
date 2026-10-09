@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Appvr projection View'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@UI.headerInfo: {
    typeName: 'Booking',
    typeNamePlural: 'Bookings',
    title: { type: #STANDARD, label: 'Booking', value: 'BookingId' }
 }
define view entity zc_booking_Appvr_dmo_m
  as projection on zi_booking_dmo_m
{
      @UI.facet: [{id: 'Booking', type: #IDENTIFICATION_REFERENCE, position: 10, purpose: #STANDARD, label: 'Booking' },
                  {id: 'BookingSupplement', type: #LINEITEM_REFERENCE, position: 20, purpose: #STANDARD, label: 'Booking Supplement', targetElement: '_Supplement' }  ]
      @Search.defaultSearchElement: true
  key TravelId,
      @UI.lineItem: [{position: 10}]
      @UI.identification: [{position: 10}]
      @Search.defaultSearchElement: true
  key BookingId,
      @UI.lineItem: [{position: 10}]
      @UI.identification: [{position: 10}]
      @Search.defaultSearchElement: true
      BookingDate,
      @ObjectModel.text.element: [ 'CustomerName' ]
      @UI.lineItem: [{position: 30}]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{entity: { name: '/DMO/I_Customer', element: 'CustomerID'} }]
      CustomerId,
      _Customer.LastName as CustomerName,
      @ObjectModel.text.element: [ 'CarrierName' ]
      @UI.lineItem: [{position: 40}]
      @UI.identification: [{position: 40}]
      CarrierId,
      _Carrier.name      as CarrierName,
      @UI.lineItem: [{position: 50}]
      @UI.identification: [{position: 50}]
      @Consumption.valueHelpDefinition: [{entity: { name: '/DMO/I_Carrier', element: 'AirlineID'},
                                    additionalBinding: [
                                                        { element: 'AirlineID', localElement: 'CarrierId' },
                                                        { element: 'CurrencyCode', localElement: 'CurrencyCode' }
                                                       ]
                                                    }]
      ConnectionId,
      @UI.lineItem: [{position: 60}]
      @UI.identification: [{position: 60}]
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.lineItem: [{position: 70}]
      @UI.identification: [{position: 70}]
      FlightPrice,
      CurrencyCode,
      @UI.lineItem: [{position: 80}]
      @UI.identification: [{position: 80}]
      BookingStatus,
      LastChangedAt,
      /* Associations */
      _BookingStatus,
      _Carrier,
      _Connection,
      _Customer,
      _Supplement,
      _Travel : redirected to parent zc_travel_Appvr_dmo_m
}
