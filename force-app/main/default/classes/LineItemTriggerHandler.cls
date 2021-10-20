public with sharing class LineItemTriggerHandler {
    //Each Line Item should decrease the Product's Available Amount. Prevent values less than 0.
    public void onInsert(List<Line_Item__c> newItems) {
        Set<ID> prodsId= new Set<ID>();
        for(Line_Item__c i : newItems){
            prodsId.add(i.Product__c);
        }
        List<Product__c> prods = [SELECT ID, Available_Amount__c FROM Product__c WHERE ID IN: prodsId];
        List<Product__c> newProds = new List<Product__c>();
        for(Product__c i : prods){
            for(Line_Item__c j : newItems){
                if(j.Product__c == i.ID){
                    if(i.Available_Amount__c-j.Quantity__c>=0){
                    	newProds.add(new Product__c(ID = i.ID, Available_Amount__c = i.Available_Amount__c-j.Quantity__c));
                    } else{
                        j.Quantity__c.addError('Quantity of line item cannot be greater than product amount');
                    }
                }
          
            }
        }
        update newProds;
    }
    public void onUpdate(List<Line_Item__c> newItems,Map<ID, Line_Item__c> oldItemsMap) {
        Set<ID> prodsId= new Set<ID>();
        for(Line_Item__c i : newItems){
            prodsId.add(i.Product__c);
        }
        List<Product__c> prods = [SELECT ID, Available_Amount__c FROM Product__c WHERE ID IN: prodsId];
		List<Product__c> newProds = new List<Product__c>();
        for(Product__c i : prods){
            for(Line_Item__c j : newItems){
                if(j.Product__c == i.ID){
                    if(i.Available_Amount__c-j.Quantity__c+oldItemsMap.get(j.ID).Quantity__c >= 0){
                        newProds.add(new Product__c(ID = i.ID, Available_Amount__c= i.Available_Amount__c-j.Quantity__c+oldItemsMap.get(j.ID).Quantity__c));
    
                    } else{
                        j.Quantity__c.addError('Quantity of line item cannot be greater than product amount');
                    }
                }
          
            }
        }
        update newProds;
    }
}
