public with sharing class customerController {
    @AuraEnabled
    public static List<Grocery_Customer__c> getCustomerByName(String customerName) {
        return GroceryDAO.getCustomerByName(customerName);
    }
}
