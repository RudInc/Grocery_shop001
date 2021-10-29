@isTest
public class CreateLineItemTest {
    
    @TestSetup static void testSetup(){
        insert TestDataFactory.generateTransactions(3,'Active');
        insert TestDataFactory.generateProducts(5,5,5);
    }
    @isTest static void createValidLineItemTest() {
        List<Transaction__c> testTransaction = [SELECT ID FROM Transaction__c];
        List<Product__c> testProd = [SELECT ID FROM Product__c ];
        List<Database.SaveResult> result = new List<Database.SaveResult>();
        for(Transaction__c trans :testTransaction){
            for(Product__c prod :testProd){
                result.add(GroceryServices.createLineItem(trans.ID, prod.ID, 10));
            }
        }
        for (Database.SaveResult res : result) {
            System.assert(res.isSuccess());
        }
    }
    @isTest static void createInvalidLineItemTest() {
        List<Transaction__c> testTransaction = [SELECT ID FROM Transaction__c];
        List<Product__c> testProd = [SELECT ID FROM Product__c ];
        List<Database.SaveResult> result = new List<Database.SaveResult>();
        for(Transaction__c trans :testTransaction){
            for(Product__c prod :testProd){
                result.add(GroceryServices.createLineItem(trans.ID, prod.ID, 0));
            }
        }
        for (Database.SaveResult res : result) {
            System.assert(!res.isSuccess());
        }
    }
}
