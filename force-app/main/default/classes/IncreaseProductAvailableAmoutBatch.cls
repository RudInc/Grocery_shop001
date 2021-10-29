public with sharing class IncreaseProductAvailableAmoutBatch implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('SELECT Id, Available_Amount__c FROM  Product__c');
    }
    
    public void execute(Database.BatchableContext bc, List<Product__c> scope){
       	Map<Id, Product__c> productsMap = new Map<Id, Product__c>(scope);
        Date today = date.today();
        Date todayMinus30 = today.addDays(-30);
        List<AggregateResult> totalAmount = [SELECT Product__c, SUM(Amount__c) 
                                             FROM Line_Item__c 
                                             WHERE Product__c IN :productsMap.keyset() AND CreatedDate >=: todayMinus30 AND CreatedDate <=:today
                                             GROUP BY Product__c];
        for(AggregateResult agg :totalAmount){
            if((decimal)agg.get('expr0') > 10000){
                productsMap.get((id)agg.get('Product__c')).Available_Amount__c += 100;
            }
        }
  		update productsMap.values();
       
    }
    
    public void finish(Database.BatchableContext bc){
         
         AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
                            JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = :bc.getJobId()];
        System.debug(job);

    }
}
