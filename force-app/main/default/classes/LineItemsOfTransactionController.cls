public with sharing class LineItemsOfTransactionController {
    @AuraEnabled
    public static List<Line_Item__c> getLineItemsByTransaction(Id transactionId) {
        return GroceryDAO.getLineItemsByTransaction(transactionId);
    }
}
