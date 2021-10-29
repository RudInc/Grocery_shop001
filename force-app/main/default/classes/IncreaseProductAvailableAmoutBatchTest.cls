@isTest
public class IncreaseProductAvailableAmoutBatchTest {
    @testSetup static void testSetup(){
        List<sObject> testRecords = new List<sObject>();
        Product__c testProd = new Product__c(Price__c = 1000, Available_Amount__c = 50000);
        testRecords.add(testProd);
        Transaction__c testTransaction= new Transaction__c();
        testRecords.add(testTransaction);
        insert testRecords;
       	List<Line_Item__c> testItems = new List<Line_Item__c>();
        for(Integer i = 0; i < 12; i++){
             testItems.add(new Line_Item__c(Quantity__c = 1000,Product__c = testProd.id, Transaction__c = testTransaction.id)); 
        }
        insert testItems;
        for(Line_Item__c item : testItems){
            Test.setCreatedDate(item.id, Date.newInstance(2021, 10, 25));
        }
        
        
    }
    @isTest static void increaseAvailableAmountTest(){
        test.startTest();
        String jobId = Database.executeBatch(new IncreaseProductAvailableAmoutBatch());
        System.assertEquals(38000, [SELECT Available_Amount__c FROM Product__c WHERE Price__c = 1000].Available_Amount__c);
        system.debug('Expected: 38000 Real: '+[SELECT Available_Amount__c FROM Product__c WHERE Price__c = 1000].Available_Amount__c);
        test.stopTest();
        System.assertEquals(38100, [SELECT Available_Amount__c FROM Product__c WHERE Price__c = 1000].Available_Amount__c);
        system.debug('Expected: 38100 Real: '+[SELECT Available_Amount__c FROM Product__c WHERE Price__c = 1000].Available_Amount__c);
    }

}