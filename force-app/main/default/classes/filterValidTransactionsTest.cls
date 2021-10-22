@isTest@isTest
public class filterValidTransactionsTest{
    @testSetup static void testSetup() {
        Integer transactinsNum = 20;
        insert TestDataFactory.generateTransactions(transactinsNum,'Active');
        insert TestDataFactory.generateTransactions(transactinsNum,'Closed');
	}
    @isTest static void validTransactions(){
        Integer transactinsNum = 20;
        List<Transaction__c> testTransactions1 = GroceryServices.filterValidTransactions([SELECT Status__c FROM Transaction__c]);
        for(Transaction__c trans: GroceryServices.filterValidTransactions(testTransactions1)){
            System.assertEquals('Active', trans.Status__c);
        }
    }
    @isTest static void invalidTransactions(){
        Integer transactinsNum = 20;
        List<Transaction__c> testTransactions2 = GroceryServices.filterValidTransactions([SELECT Status__c FROM Transaction__c]);
        for(Transaction__c trans : GroceryServices.filterValidTransactions(testTransactions2)){
            System.assertEquals('Closed', trans.Status__c);
        }
    }
    @isTest static void transactions(){
        for(Transaction__c trans : GroceryServices.filterValidTransactions()){
            System.assertEquals('Closed', trans.Status__c);
        }
    }
}