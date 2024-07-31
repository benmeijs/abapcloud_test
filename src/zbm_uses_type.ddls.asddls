@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gebruik van een CDS simple type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zbm_uses_type 
with parameters i_type : ztype
as select from  I_AddressGroup
{
 key AddressGroup,
 /* Associations */
 _Text
}
