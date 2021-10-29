public class GroceryServices{
    /*
    Method filterValidTransactions returns Active and Closed transactions from a list of Transaction__c
    Input parameter: (List<Transaction__c> transactions)
    Result: (List<Transaction__c> transactions) - transactions with Active and Closed Status
     */
    public static List<Transaction__c> filterValidTransactions(List<Transaction__c> transactions) {
        if(transactions.isEmpty())
        {
            return new List<Transaction__C>();
        }
        List<Transaction__c> validTrs = new List<Transaction__c>() ;
        for(Transaction__c trs : transactions){
            if(trs.Status__c == 'Active' || trs.Status__c == 'Closed') validTrs.add(trs);
        }
        return validTrs;
    }
    public static List<Transaction__c> filterValidTransactions(){
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
        if(items.isEmpty())
        {
            return 0;
        }
        Decimal  res = 0;
        for(Line_Item__c i : items){
            res += i.Amount__c;
        }
        return (Integer)res;
    }
     /* 
     createLineItem	Database.SaveResult	Id transactionId, Id productId, Integer amount.	create line item record
    */
    public static Database.SaveResult createLineItem(Id transactionId, Id productId, Integer quantity) {
        return Database.insert(new Line_item__c(Quantity__c = quantity,Transaction__c = transactionId,Product__c = productId),false);
    }
    /*     
    createTransaction	Database.SaveResult	String paymentType	create transaction record
    */
    public static Database.SaveResult createTransaction(String paymentType){
        return Database.insert(new Transaction__c(Payment_Type__c = paymentType),false);
    }
      /*
    createTransaction	Database.SaveResult	String paymentType, List<LineItemDTO>	
    create transaction and line items with single call. As input parameter helper class is used. 
    */
    
    public static Database.SaveResult[] createTransaction(String paymentType, List<LineItemDTO> items){
        
        Transaction__c transToAdd= new Transaction__c(Status__c = 'Active',Payment_Type__c = paymentType);
        insert(transToAdd);
        List<Line_item__c> lineItemToAdd = new List<Line_item__c>(); 
        for(LineItemDTO lineItems : items){
            lineItemToAdd.add(new Line_item__c(Amount__c = 0,Quantity__c = lineItems.quantity, Transaction__c = transToAdd.id, Product__c = lineItems.productId));
        }
       // insert(transToAdd);
        return Database.insert(lineItemToAdd,false);
    }
     /*
    cancelTransaction	void	Id transactionId	Set Status__c to Cancelled
    */
    public static void cancelTransaction(ID transactionId){
        Transaction__c trs = [SELECT Status__c FROM Transaction__c WHERE ID = :transactionId];
        trs.Status__c = 'Closed';
        update trs;
        return;
    }
    /*
    deleteLineItem	void Id lineItemId	delete line item by ID
    */
    public static void deleteLineItem(ID lineItemId){
        try{
        	delete [SELECT ID FROM Line_Item__c WHERE ID = :lineItemId];
        } catch (DmlException e){
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        return;
    }
}