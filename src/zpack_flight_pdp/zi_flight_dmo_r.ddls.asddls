@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FLight Information'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity ZI_FLIGHT_DMO_R
  as select from /dmo/flight as flight
  association [1] to ZI_CARRIER_DMO_R as _Carrier on $projection.CarrierId = _Carrier.CarrierId
{
      @UI.identification: [{position: 10 }]
      @UI.lineItem: [{ position: 10,  cssDefault.width: '20%' }]
      @ObjectModel.text.association: '_Carrier'
  key carrier_id     as CarrierId,
      @UI.lineItem: [{ position: 20,  cssDefault.width: '20%' }]
  key connection_id  as ConnectionId,
      @UI.lineItem: [{ position: 30,  cssDefault.width: '20%' }]
  key flight_date    as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.lineItem: [{ position: 40,  cssDefault.width: '20%' }]
      price          as Price,
      @UI.lineItem: [{ position: 50,  cssDefault.width: '20%' }]
      currency_code  as CurrencyCode,
      @UI.lineItem: [{ position: 60,  cssDefault.width: '20%' }]
      @Search.defaultSearchElement: true
      plane_type_id  as PlaneTypeId,
      @UI.lineItem: [{ position: 70,  cssDefault.width: '20%' }]
      seats_max      as SeatsMax,
      @UI.lineItem: [{ position: 80,  cssDefault.width: '20%' }]
      seats_occupied as SeatsOccupied,
      _Carrier

}
