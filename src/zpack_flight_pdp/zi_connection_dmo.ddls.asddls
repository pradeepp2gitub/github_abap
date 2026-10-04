@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Connection'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections'
}
@Search.searchable: true
define view entity ZI_CONNECTION_DMO
  as select from /dmo/connection as Connection
  association [1..*] to ZI_FLIGHT_DMO_R  as _Flight  on  $projection.ConnectionId = _Flight.ConnectionId
                                                     and $projection.CarrierId    = _Flight.CarrierId
  association [1]    to ZI_CARRIER_DMO_R as _Carrier on  $projection.CarrierId = _Carrier.CarrierId

{
      @UI.facet: [{ id: 'Connection', position: 10, label: 'Connection Details', type:#IDENTIFICATION_REFERENCE, purpose: #STANDARD },
                  { id: 'zflight', position: 20, label: 'FLight Details',
                  type:#LINEITEM_REFERENCE, purpose: #STANDARD,
                  targetElement: '_Flight'
                  }]

      @UI.lineItem: [{ position: 10, cssDefault.width: '20%', label: 'Airline' }]
      @UI.identification: [{position: 10 }]
      @ObjectModel.text.association: '_Carrier'
      @Search.defaultSearchElement: true
  key carrier_id      as CarrierId,
      @UI.lineItem: [{ position: 20,  cssDefault.width: '20%' }]
      @UI.identification: [{position: 20 }]
      @Search.defaultSearchElement: true
  key connection_id   as ConnectionId,
      @UI.lineItem: [{ position: 30, cssDefault.width: '20%'   }]
      @UI.selectionField: [{position: 10 }]
      @UI.identification: [{position: 30 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_AIRPORT_DMO_VH',
              element: 'AirportId' } }]
      airport_from_id as AirportFromId,
      @UI.lineItem: [{ position: 40, cssDefault.width: '20%'   }]
      @UI.selectionField: [{position: 20 }]
      @UI.identification: [{position: 40 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_AIRPORT_DMO_VH',
        element: 'AirportId' } }]
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position: 50, cssDefault.width: '20%'   }]
      @EndUserText.label: 'Departure Time'
      @Search.defaultSearchElement: true
      departure_time  as DepartureTime,
      @UI.lineItem: [{ position: 60, cssDefault.width: '20%'   }]
      @EndUserText.label: 'Arrival Time'
      arrival_time    as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @UI.lineItem: [{ position: 70, cssDefault.width: '20%'   }]
      distance        as Distance,
      distance_unit   as DistanceUnit,
      @Search.defaultSearchElement: true
      _Flight,
      @Search.defaultSearchElement: true
      _Carrier
}
