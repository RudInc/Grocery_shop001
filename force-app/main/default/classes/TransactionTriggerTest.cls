@isTest
public class TransactionTriggerTest {
    @TestSetup static void testSetup(){
        List<Transaction__c> setupTransactions = TestDataFactory.generateTransactions(5,'Active');
        List<Product__c> setupProduct = TestDataFactory.generateProducts(3,10,1000);
        Integer daysToAdd = 0;
        insert setupTransactions;
        insert setupProduct;
        List<Line_Item__c> setupItems = new List<Line_item__c>(); 
        for(Product__c prod : setupProduct){
            for(Transaction__c trans : setupTransactions){
                setupItems.addAll(TestDataFactory.generateLineItems(3,5,trans.ID,prod.ID));
            }
        }
    }
    
    @isTest static void validOnUpdateTest(){
        Transaction__c transactionIdToClose = [SELECT ID, Status__c FROM Transaction__c LIMIT 1];
       	List<AggregateResult> itemsToReturn = [SELECT Product__c prodId ,SUM(Quantity__c) TotalAmount
                                               FROM Line_Item__c 
                                               WHERE Transaction__c = :transactionIdToClose.Id
                                               GROUP BY Product__c];
        Map<ID, Decimal> mapAmountToReturn = new Map<Id, Decimal>();
        for(AggregateResult item : itemsToReturn){
            mapAmountToReturn.put(item.get('prodId'),item.get('TotalAmount'));
        }
        insert transactionIdToClose.Status__c='Cancelled';
        
    }
    @isTest static void invalidOnUpdateTest(){
        
    }
}