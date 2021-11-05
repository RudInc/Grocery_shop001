@isTest
public class CalculateTotalAmountTest {
    @testSetup static void testSetup(){
        /*Transaction__c setupTransaction = new Transaction__c(Status__c ='Active',Payment_Type__c='Visa');
        Product__c setupProduct = new Product__c(Price__c =20);
        insert setupTransaction;
        insert setupProduct;
        insert TestDataFactory.generateLineItems(20,20,setupTransaction.id,setupProduct.id);*/
    }
    @isTest static void calculateTotalAmountTest(){
        Integer num = 20;
        Transaction__c setupTransaction = new Transaction__c(Status__c ='Active',Payment_Type__c='Visa');
        Product__c setupProduct = new Product__c(Price__c =20);
        insert setupTransaction;
        insert setupProduct;
        
        Integer testTotalAmount = GroceryServices.calculateTotalAmount(TestDataFactory.generateLineItems(20,20,setupTransaction.id,setupProduct.id));
        System.assertEquals(20*20, testTotalAmount);
    }
    @isTest static void calculateTotalAmountOfEmptyList(){
        Integer testTotalAmount = GroceryServices.calculateTotalAmount(new List<Line_Item__c>());
        System.assertEquals(0, testTotalAmount);
    }
}