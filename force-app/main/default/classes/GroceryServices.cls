public class GroceryServices{
    /*
    Method filterValidTransactions returns Active and Closed transactions from a list of Transaction__c
    Input parameter: (List<Transaction__c> transactions)
    Result: (List<Transaction__c> transactions) - transactions with Active and Closed Status
     */
    public static List<Transaction__c> filterValidTransactions(List<Transaction__c> transactions) {
        if(transactions.isEmpty())
        {
            return new List<Transaction__c>();
        } 
        List<Transaction__c> validTrs = new List<Transaction__c>();
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
    /*
    Create method calculateTotalAmount in GroceryServices class which returns total amount for all specified Line Items
    Input parameter: (List<Line_Item__c> lineItems)
    Result: Integer amount - total amount for all specified Line Items
     */
    public static Integer calculateTotalAmount()
    {	
        Line_Item__c[] items = [SELECT Amount__c FROM Line_Item__c];
        Decimal  res = 0;
        for(Line_Item__c i : items){
        res += i.Amount__c;
        }
        return (Integer)res;
    }
    public static Integer calculateTotalAmount(List<Line_Item__c> items){
        Decimal  res = 0;
        for(Line_Item__c i : items){
        res += i.Amount__c;
        }
        return (Integer)res;
    }
}
