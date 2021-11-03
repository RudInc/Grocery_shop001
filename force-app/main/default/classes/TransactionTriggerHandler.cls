public with sharing class TransactionTriggerHandler {
    public void onUpdate(List<Transaction__c> trns,Map<ID, Transaction__c> oldTransactionsMap){
        Set<ID> cancelledTrnsId= new Set<ID>();
        List<Transaction__c> closedTransactions= new List<Transaction__c>();
        for(Transaction__c i : trns){
            if(i.Status__c == 'Cancelled' && oldTransactionsMap.get(i.id).Status__c != 'Cancelled'){
                cancelledTrnsId.add(i.Id);
            }
            if(i.Status__c == 'Closed' && i.Grocery_Customer__c != NULL && oldTransactionsMap.get(i.id).Status__c != 'Closed'){
                closedTransactions.add(i);
            }
        }
        List<Line_Item__c> items = [SELECT ID, Quantity__c, Product__c 
                                    FROM Line_Item__c 
                                    WHERE Transaction__c IN :cancelledTrnsId];
        Set<ID> prodsId= new Set<ID>();
        for(Line_Item__c i : items){
            prodsId.add(i.Product__c);
        }
        List<Product__c> prodsToUpdate = [SELECT ID,Available_Amount__c FROM Product__c WHERE ID IN: prodsId];
        for(Integer i = 0;i < prodsToUpdate.size();i++){
            for(Line_Item__c item : items){
                if(prodsToUpdate[i].ID == item.Product__c){
                    prodsToUpdate[i].Available_Amount__c += item.Quantity__c;
                }
            }
        }
        Set<ID> customersId = new Set<ID>();
        for(Transaction__c closedTrn: closedTransactions){
            customersId.add(closedTrn.Grocery_Customer__c);
        }
        Map<Id,Grocery_Customer__c> customersToUpdate = new Map<Id,Grocery_Customer__c>([SELECT id,Total_Amount__c FROM Grocery_Customer__c WHERE ID IN: customersId]); 
        for(Transaction__c customerTrns : closedTransactions){
            customersToUpdate.get(customerTrns.Grocery_Customer__c).Total_Amount__c += customerTrns.Total_Amount__c;
        }
        List<SObject> result = new List<SObject>();
        result.addAll(prodsToUpdate);
        result.addAll(customersToUpdate.values());
        update result;
    }
}