public with sharing class ProductController {
    @AuraEnabled
    public static List<AggregateResult> getTopProductsOfCustomer(Id customerID) {
        return GroceryDAO.getTopProductsOfCustomer(customerID);
    }
    @AuraEnabled
    public static List<Product__c> getProductsByName(String productName){
        return GroceryDAO.getProductsByName(productName);
    }
}
