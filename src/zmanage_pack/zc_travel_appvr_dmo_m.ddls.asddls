@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Appvr Projection view'
@Search.searchable: true
@UI.headerInfo: {
    typeName: 'Travel',
    typeNamePlural: 'Travels',
    title: {
        type: #STANDARD,
        label: 'Travel',
        value: 'TravelId'

        }
    }
define root view entity zc_travel_Appvr_dmo_m
  provider contract transactional_query
  as projection on zi_travel_dmo_m

{
      @UI.facet: [{id: 'Travel', type: #IDENTIFICATION_REFERENCE, position: 10, purpose: #STANDARD, label: 'Travel' },
                  {id: 'Booking', type: #LINEITEM_REFERENCE, position: 20, purpose: #STANDARD, label: 'Booking', targetElement: '_Booking' }  ]
      @UI.lineItem: [{position: 10 }, { type: #FOR_ACTION, dataAction: 'copyTravel', label: 'Copy Travel' }]
      @Search.defaultSearchElement: true
      @UI.identification: [{position: 10 }]
  key TravelId,
//      @ObjectModel.text.element: [ 'AgencyName' ]
      @UI.lineItem: [{position: 20 }]
      @UI.selectionField: [{position: 10 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{entity: { name: '/DMO/I_Agency',element: 'AgencyID'} }]
      @UI.identification: [{position: 20 }]
      AgencyId,

//      @ObjectModel.text.element: [ 'CustomerName' ]
      @UI.lineItem: [{position: 20 }]
      @UI.selectionField: [{position: 10 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{entity: { name: '/DMO/I_Agency',element: 'AgencyID'} }]
      @UI.identification: [{position: 20 }]
      CustomerId,
      @UI.identification: [{position: 40 }]
      BeginDate,
      @UI.lineItem: [{position: 50 }]
      @UI.identification: [{position: 10 }]
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{position: 50 }]
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.lineItem: [{position: 60 }]
      TotalPrice,
      @Consumption.valueHelpDefinition: [{entity: { name: 'I_Currency',element: 'Currency'} }]
      CurrencyCode,
      @UI.lineItem: [{position: 61 }]
      @UI.identification: [{position: 51 }]
      Description,
      @ObjectModel.text.element: [ 'OverallStatusText' ]
      @UI.lineItem: [{position: 70 }, {type: #FOR_ACTION, dataAction: 'acceptTravel', label: 'Accept Travel'},
                                      {type: #FOR_ACTION, dataAction: 'rejectTravel', label: 'Reject Travel'}
             ]
      @UI.selectionField: [{position: 30 }]
      @Search.defaultSearchElement: true
      @UI.identification: [{position: 60 }]
      @Consumption.valueHelpDefinition: [{entity: { name: '/DMO/I_Overall_Status_VH',element: 'OverallStatus'} }]
      @UI.textArrangement: #TEXT_ONLY
      OverallStatus,
      _Status._Text.Text as OverallStatusText : localized,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking : redirected to composition child zc_booking_Appvr_dmo_m,
      _Currency,
      _Customer,
      _Status
}
