# Issues

* Terraform: zone_redundant will replace premium namespaces in availability zone regions
  * https://github.com/hashicorp/terraform-provider-azurerm/issues/18756
* EH: Had 220 partitions on 2 PU. Scaled down to 1PU. BUG: No error happened here. Deleted & recreated topic w/ same partition count - got the expected error
* Terraform: no relationship from event hub -> namespace. Can end up in a scenario where EH namespace gets recreated, but Event Hubs are not also recreated
