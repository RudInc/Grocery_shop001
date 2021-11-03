trigger GroceryCustomerTrigger on Grocery_customer__c (before update) {
    GroceryCustomerTriggerHandler handler = new GroceryCustomerTriggerHandler();
    if(Trigger.isUpdate) handler.onUpdate(Trigger.new,Trigger.oldMap);
}