trigger TransactionTrigger on Transaction__c (before update) {
    TransactionTriggerHandler handler = new TransactionTriggerHandler();
    if(Trigger.isUpdate) handler.onUpdate(Trigger.New,Trigger.oldMap);
    
}