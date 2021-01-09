public with sharing class EntitlementCompareController {
    public EntitlementCompareController() {

    }

    @AuraEnabled(cacheable=true)

    public static List<wrapUsers> getActiveUsers(){
        List<wrapUsers> returnuserOptions= new List<wrapUsers>();

        for(User u: [select id, Name,profileId from User where isActive=true]){

            wrapUsers wU= new wrapUsers(u.Name, u.id);

            returnuserOptions.add(wU);

        }

        return returnuserOptions;
    }

    @AuraEnabled(cacheable=true)
    public static List<wrapEntitlements> getUserEntitlements(string id){
        system.debug('Id='+id);
        List<wrapEntitlements> setupAccess= new List<wrapEntitlements>();

        List<wrapinnerEntitlement> setUpEntities= new List<wrapinnerEntitlement>();
        
        set<string> collectEntityIds= new Set<string>();
        try {

            String profileId=[Select Id, ProfileId from user where id=:id limit 1].ProfileId;

            profileId=[Select Id from PermissionSet where ProfileId=:profileId limit 1].Id;

            for(SetupEntityAccess access:[SELECT Id, ParentId, Parent.Name, SetupEntityId,SetupEntityType
                                            FROM SetupEntityAccess where ParentId =:profileId ]){

                                                collectEntityIds.add(access.SetupEntityId);

            }

            system.debug('collectEntityIds='+collectEntityIds);

            for(apexClass a:[Select Name from ApexClass where id in:collectEntityIds]){

                setUpEntities.add(new wrapinnerEntitlement(a.Name));
            }
            system.debug('setUpEntities='+setUpEntities);

            wrapEntitlements setupAccessapex= new wrapEntitlements('ApexClass',setUpEntities);

            system.debug('setupAccessapex='+setupAccessapex);

            setupAccess.add(setupAccessapex);

            /*setupAccess= [SELECT Id, ParentId, Parent.Name, SetupEntityId
                                                    FROM SetupEntityAccess
                                                    WHERE SetupEntityType='ApexClass' and ParentId=:profileId];*/
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return setupAccess;
    }




    // wrapper class to write users in proper format
    public class wrapUsers{
        @AuraEnabled
        public string label {get;set;}

        @AuraEnabled
        public string value {get;set;}

        public wrapUsers(string label,string value){

            this.label=label;

            this.value=value;

        }
    
    }
    //wrapUsers End


     public class wrapEntitlements{

        @AuraEnabled
        public string name {get;set;}
        @AuraEnabled
        public List<wrapinnerEntitlement> children {get;set;}

        public wrapEntitlements(string name,List<wrapinnerEntitlement> children){

            this.name=name;

            this.children=children;

        }
    } 

    public class wrapinnerEntitlement{
        @AuraEnabled
        public string name {get;set;}

        public wrapinnerEntitlement(string name){

            this.name=name;
        }

    }

    
}
