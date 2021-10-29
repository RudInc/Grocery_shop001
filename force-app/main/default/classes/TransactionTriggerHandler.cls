public with sharing class TransactionTriggerHandler {
    public void onUpdate(List<Transaction__c> trns){
        Set<ID> trnsId= new Set<ID>();
        for(Transaction__c i : trns){
            if(i.Status__c == 'Cancelled') trnsId.add(i.Id);
        }
        List<Line_Item__c> items = [SELECT ID, Quantity__c, Product__c 
                                    FROM Line_Item__c 
                                    WHERE Transaction__c IN :trnsId];
        Set<ID> prodsId= new Set<ID>();
        for(Line_Item__c i : items){
            prodsId.add(i.Product__c);
        }
        List<Product__c> prods = [SELECT ID,Available_Amount__c FROM Product__c WHERE ID IN: prodsId];
        for(Integer i = 0;i < prods.size();i++){
            for(Line_Item__c j : items){
                if(prods[i].ID == j.Product__c){
                    prods[i].Available_Amount__c += j.Quantity__c;
                }
            }
        }
        update prods;
    }
}