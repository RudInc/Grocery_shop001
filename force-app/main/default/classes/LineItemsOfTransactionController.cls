public with sharing class LineItemsOfTransactionController {
    public List<Line_Item__c> LineItemsOfTransaction(Id transactionId) {
        return GroceryDAO.getLineItemsByTransaction(transactionId);
    }
}
