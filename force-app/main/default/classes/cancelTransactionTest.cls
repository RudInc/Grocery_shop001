@isTest
public class CancelTransactionTest {
    @testSetup static void setupTest(){
        Transaction__c testTransaction = new Transaction__c(Status__c = 'Active');
        insert testTransaction;
    }
    @isTest static void cancelTransactionTest(){
        ID testId = [SELECT ID FROM Transaction__c].Id;
        GroceryServices.cancelTransaction(testId);
        Transaction__c result = [SELECT Status__c FROM Transaction__c];
        System.assertEquals('Closed', result.Status__c);
    }
}