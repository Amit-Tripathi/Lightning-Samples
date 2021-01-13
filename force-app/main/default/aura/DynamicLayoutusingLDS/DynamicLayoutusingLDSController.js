({
    handleOnAmountChange : function(component, event, helper) {

        var amount= component.find("amount").get("v.value");

        component.set("v.needApprover",amount>100);

    }
})
