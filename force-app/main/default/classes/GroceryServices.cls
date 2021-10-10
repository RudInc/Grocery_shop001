public class GroceryServices{
    /*
    Method filterValidTransactions returns Active and Closed transactions from a list of Transaction__c
    Input parameter: (List<Transaction__c> transactions)
    Result: (List<Transaction__c> transactions) - transactions with Active and Closed Status
     */
    public static List<Transaction__c> filterValidTransactions(List<Transaction__c> transactions) {
        List<Transaction__c> validTrs;
        for(Transaction__c trs : transactions){
            if(trs.Status__c == 'Active' || trs.Status__c == 'Closed') validTrs.add(trs);
        }
        return validTrs;
    }
    public static List<Transaction__c> filterValidTransactions() {
        return [SELECT ID,Status__c
                FROM Transaction__c 
                WHERE Status__c LIKE 'Active' OR Status__c LIKE'Closed'];
    }
}
