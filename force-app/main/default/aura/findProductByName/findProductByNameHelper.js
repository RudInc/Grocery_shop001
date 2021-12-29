({
    setColumns : function(component) {
        component.set("v.columns", [
            {label:'Id', fieldName: 'Id', type: 'text'},
            {label:'Name', fieldName: 'Name', type:'text'},
            {label:'Available Amount', fieldName: 'Available_Amount__c', type:'number'},
            {label:'Price', fieldName: 'Price__c', type: 'number'}
        ]);
    },
    searchProduct : function(component){
        let action = component.get("c.getProductsByName");
        console.log(component.get("v.productName"));
        action.setParams({productName: '%'+component.get("v.productName")+'%'});
        action.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                console.log(response.getReturnValue());
                component.set("v.products",response.getReturnValue());
            }
            else{
                console.log("Failed with state: " + state);
            }
         });
        $A.enqueueAction(action);
    }
})
