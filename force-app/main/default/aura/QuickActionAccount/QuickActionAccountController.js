({
    //init event fires before onload so for defaulting values both should work.
    init : function(component, event, helper) {

        component.find("account").set("v.value",component.get("v.recordId"));

    },
    // On Success event Refresh the View and close the quick action modal
    handleOnSuccess: function(component, event, helper){

        $A.get('e.force:refreshView').fire();
        $A.get("e.force:closeQuickAction").fire();


    }
})
