##1. User Entitlement in LWC Tree Grid.##
  Tree Grid Requires response to be in exact Json format so created a wrapper and in controller used command 
  ```JSON.parse(JSON.stringify(data).split('children').join('_children'))``` to replace children wrapper with _children.
  ./force-app/main/default/lwc/userEntitlementList/userEntitlementList.js