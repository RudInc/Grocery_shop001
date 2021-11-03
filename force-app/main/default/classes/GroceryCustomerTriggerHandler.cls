public with sharing class GroceryCustomerTriggerHandler {
    public void onUpdate(List<Grocery_Customer__c> newCustomers, Map<ID, Grocery_Customer__c> oldCustomersMap) {
        for(Grocery_Customer__c customer : newCustomers){
            customer.Bonus__c += (customer.Total_Amount__c - oldCustomersMap.get(customer.id).Total_Amount__c)*0.05;
        }
        update newCustomers;
    }
}
