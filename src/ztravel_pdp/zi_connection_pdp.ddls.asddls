@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel connection pdp'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections'
}
@Search.searchable: true
define view entity ZI_CONNECTION_PDP
  as select from /dmo/connection as connection
  association [1..*] to ZI_FLIGHT_PDP_R  as _Flight  on  $projection.CarrierId    = _Flight.CarrierId
                                                     and $projection.ConnectionId = _Flight.ConnectionId
  association [1]    to ZI_CARRIER_PDP_R as _Airline on  $projection.CarrierId = _Airline.CarrierId
{

      @UI.facet: [{ id: 'Connection', purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE, position: 10, label: 'Connection Details' },
      { id: 'Flight', purpose: #STANDARD, type: #LINEITEM_REFERENCE, position: 20, label: 'Flights', targetElement: '_Flight'  }]
      @UI.lineItem: [{ position: 10, label: 'Airline'  }]
      @UI.identification: [{ position: 10, label: 'Airline' }]
      @ObjectModel.text.association: '_Airline'
      @Search.defaultSearchElement: true
  key carrier_id      as CarrierId,
      @UI.lineItem: [{ position: 20  }]
      @UI.identification: [{ position: 20 }]
      @Search.defaultSearchElement: true
  key connection_id   as ConnectionId,
      @UI.lineItem: [{ position: 30  }]
      @UI.selectionField: [{ position: 10}]
      @UI.identification: [{ position: 30 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: {
                        name: 'ZI_AIRPORT_PDP_VH',
                        element: 'AirportId'
      } }]
      @EndUserText.label: 'Departure Airport ID'
      airport_from_id as AirportFromId,
      @UI.lineItem: [{ position: 40  }]
      @UI.selectionField: [{ position: 20}]
      @UI.identification: [{ position: 40 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: {
                  name: 'ZI_AIRPORT_PDP_VH',
                  element: 'AirportId'
      } }]
      @EndUserText.label: 'Destination Airport ID'
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position: 60, label: 'Departure time'  }]
      @UI.identification: [{ position: 50 }]
      @Search.defaultSearchElement: true
      departure_time  as DepartureTime,
      @UI.lineItem: [{ position: 60, label: 'Arrival time'  }]
      @UI.identification: [{ position: 60 }]
      arrival_time    as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @UI.identification: [{ position: 70 }]
      distance        as Distance,
      distance_unit   as DistanceUnit,
      //Assocation table definations
      @Search.defaultSearchElement: true
      _Flight,
      @Search.defaultSearchElement: true
      _Airline
}
