({
    setColumns : function(component) {
        component.set("v.columns", [
            {label:'Id', fieldName: 'Id', type: 'text'},
            {label:'Last Name', fieldName: 'Name', type:'text'},
            {label:'First Name', fieldName: 'FirstName__c', type:'text'},
            {label:'Bonus', fieldName: 'Bonus__c', type: 'number'}
        ]);
    },
    searchCustomer : function(component){
        let action = component.get("c.getCustomerByName");
        console.log(component.get("v.customerName"));
        action.setParams({customerName: '%'+component.get("v.customerName")+'%'});
        action.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                console.log(response.getReturnValue());
                component.set("v.customers",response.getReturnValue());
            }
            else{
                console.log("Failed with state: " + state);
            }
         });
        $A.enqueueAction(action);
    }
})
