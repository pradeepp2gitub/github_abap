@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZTTGROCERY'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_TTGROCERY
  as select from ZTT_GROCERY as Grocery
{
  key id as ID,
  product as Product,
  category as Category,
  brand as Brand,
  @Semantics.amount.currencyCode: 'Currency'
  price as Price,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
  quantity as Quantity,
  purchasedate as Purchasedate,
  expirationdate as Expirationdate,
  expired as Expired,
  rating as Rating,
  note as Note,
  @Semantics.user.createdBy: true
  createdby as Createdby,
  createdat as Createdat,
  @Semantics.user.lastChangedBy: true
  lastchangedby as Lastchangedby,
  @Semantics.systemDateTime.lastChangedAt: true
  lastchangedat as Lastchangedat,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchanged as Locallastchanged
}
