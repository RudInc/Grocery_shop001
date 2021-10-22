@isTest
public class getTotalAmountOfTransactionsTest {
    @testSetup static void testSetup(){
        List<Transaction__c> setupTransactions = TestDataFactory.generateTransactions(15,'Active');
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
        insert setupItems;
        
    }
    @IsTest static void emptySet(){
        
        Set<Id> testSet = new Set<Id>();
        Test.startTest();
        Map<Id,Decimal> result = GroceryDAO.getTotalAmountOfTransactions(testSet);    
        System.assertEquals(new Map<Id,Decimal>(), result);   
        Test.stopTest();
            
    }
    @IsTest static void validSet(){
        
        Set<Id> testSet = new Set<Id>();
        for(Transaction__c transId : [SELECT ID FROM Transaction__c LIMIT 5]){
            testSet.add(transId.id);
        }
        List<Transaction__c> listToTest = [SELECT ID, Total_Amount__c FROM Transaction__c WHERE ID IN: testSet];
        Map<ID,Decimal> resToTest = new Map<ID,Decimal>();
        for(Transaction__c trns : listToTest){
            resToTest.put(trns.ID,trns.Total_Amount__c);
        }
        Test.startTest(); 
        Map<Id,Decimal> result = GroceryDAO.getTotalAmountOfTransactions(testSet);
        for(ID testId : testSet){
            System.assertEquals(resToTest.get(testId), result.get(testID));
        }    
        Test.stopTest();
            
    }
    @IsTest static void fullSet(){
        
        Set<Id> testSet = new Set<Id>();
        for(Transaction__c transId : [SELECT ID FROM Transaction__c]){
            testSet.add(transId.id);
        }
        List<Transaction__c> listToTest = [SELECT ID, Total_Amount__c FROM Transaction__c WHERE ID IN: testSet];
        Map<ID,Decimal> resToTest = new Map<ID,Decimal>();
        for(Transaction__c trns : listToTest){
            resToTest.put(trns.ID,trns.Total_Amount__c);
        }
        Test.startTest();
        Map<Id,Decimal> result = GroceryDAO.getTotalAmountOfTransactions(testSet);    
        for(ID testId : testSet){
            System.assertEquals(resToTest.get(testId), result.get(testID));
        }        
        Test.stopTest();
            
    }
}
