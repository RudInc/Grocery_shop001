@RestResource(urlMapping='/Product/*')
global with sharing class  ProductWebServices {
    @HttpGet
    webservice static List<Product__c> getProductsWithHighestPrice() {
       
        return [SELECT Name, Price__c, Available_Amount__c FROM Product__c ORDER BY Price__c DESC LIMIT 5];
    }
}
