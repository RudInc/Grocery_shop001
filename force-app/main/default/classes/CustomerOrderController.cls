public with sharing class CustomerOrderController {
    @AuraEnabled
    public static void createTransaction(String lineItems , String paymentType, ID customerID){

        GroceryServices.createTransaction(paymentType, null, customerID);
    }
}
