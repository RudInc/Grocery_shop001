({
    onInit : function(component, event, helper) {
        helper.setColumns(component);
        
    },
    clickSearch : function(component, event, helper){
        helper.searchProduct(component);
    }
})
