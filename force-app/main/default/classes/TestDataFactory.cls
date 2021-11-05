@isTest
public with sharing class TestDataFactory {
    public static List<Transaction__c> generateTransactions(Integer num, String status) {
        if(num < 1 || status  !='Active'||status !='Closed'||status !='Archived'||status !='Cancelled'){
            return new List<Transaction__c>();
        }
        List<Transaction__c> transactions = new List<Transaction__c>();
        for(Integer i = 0; i <num; i++){
            transactions.add(new Transaction__c(Name ='Test ' + i,Status__c = status));
        }
        return transactions;
    }
    public static List<Line_Item__c> generateLineItems(Integer num, Integer quantity, ID transactionId, ID productId){
        if(quantity<1||num<1){return new List<Line_Item__c>();}
        List<Line_Item__c> items = new List<Line_item__c>();
        for(Integer i = 0; i<num; i++){
            items.add(new Line_Item__c(Name = 'Test '+ i, Quantity__c = quantity, Amount__c = quantity, Transaction__c = transactionId, Product__c = productId));
            system.debug(items[i]);
        }
        return items;
    }
    public static List<Product__c> generateProducts(Integer num, Integer price, Integer amount){
        if(num<1){return new List<Product__c>();}
        List<Product__c> products = new List<Product__c>();
        for(Integer i = 0; i<num; i++){
            products.add(new Product__c(Name = 'Test '+ i,Price__c = price, Available_Amount__c = amount, Code__c = ''+i));
        }
        return products;
    }
 
}