@Metadata.allowExtensions: true
@Search.searchable: true
@EndUserText.label: 'Projection View for ZR_TTGROCERY'
@Metadata.ignorePropagatedAnnotations: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_TTGROCERY
  provider contract transactional_query
  as projection on ZR_TTGROCERY
  association [1..1] to ZR_TTGROCERY as _BaseEntity on $projection.ID = _BaseEntity.ID
{
  key ID,
  @Search.defaultSearchElement: true
  Product,
  @Search.defaultSearchElement: true
  Category,
  @Search.defaultSearchElement: true
  Brand,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  Price,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  Currency,
  Quantity,
  Purchasedate,
  Expirationdate,
  Expired,
  Rating,
  Note,
  @Semantics: {
    user.createdBy: true
  }
  Createdby,
  Createdat,
  @Semantics: {
    user.lastChangedBy: true
  }
  Lastchangedby,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  Lastchangedat,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  Locallastchanged,
  _BaseEntity
}
