@isTest
public class deleteLineItemTest {
    @testSetup static void testSetup(){
        insert new Transaction__c();
        insert new Product__c(Available_Amount__c = 10000);
        insert new Line_Item__c(Transaction__c = [SELECT ID FROM Transaction__c].ID, Product__c =[SELECT ID FROM Product__c].ID, Quantity__c = 10);
        
    }
    @isTest static void deleteLineItemTest(){
        ID testID = [SELECT id FROM Line_Item__c].id;
        GroceryServices.deleteLineItem(testID);
        System.assertEquals(new List<Line_Item__c>(), [SELECT id FROM Line_Item__c]);
    }
}