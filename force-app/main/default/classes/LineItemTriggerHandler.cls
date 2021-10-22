public with sharing class LineItemTriggerHandler {
    //Each Line Item should decrease the Product's Available Amount. Prevent values less than 0.
    public void onInsert(List<Line_Item__c> newItems) {
        Set<ID> prodsId= new Set<ID>();
        for(Line_Item__c i : newItems){
            prodsId.add(i.Product__c);
        }
        List<Product__c> products = [SELECT ID, Available_Amount__c FROM Product__c WHERE ID IN: prodsId];
        
        for(Product__c prods : products){
            for(Line_Item__c items : newItems){
                if(items.Product__c == prods.ID){
                    if(prods.Available_Amount__c-items.Quantity__c>=0){
                    	prods.Available_Amount__c =prods.Available_Amount__c-items.Quantity__c;
                    } else{
                        items.Quantity__c.addError('Quantity of line item cannot be greater than product amount');
                    }
                }
          
            }
        }
        update products;
    }
    public void onUpdate(List<Line_Item__c> newItems,Map<ID, Line_Item__c> oldItemsMap) {
        Set<ID> prodsId= new Set<ID>();
        for(Line_Item__c items : newItems){
            prodsId.add(items.Product__c);
        }
        List<Product__c> products = [SELECT ID, Available_Amount__c FROM Product__c WHERE ID IN: prodsId];
		
        for(Product__c prods : products){
            for(Line_Item__c items : newItems){
                if(items.Product__c == prods.ID){
                    if(prods.Available_Amount__c-items.Quantity__c-oldItemsMap.get(items.ID).Quantity__c >= 0){
                        prods.Available_Amount__c = prods.Available_Amount__c-items.Quantity__c+oldItemsMap.get(items.ID).Quantity__c ;
    
                    } else{
                        items.Quantity__c.addError('Quantity of line item cannot be greater than product amount');
                    }
                }
          
            }
        }
        update products;
    }
}
