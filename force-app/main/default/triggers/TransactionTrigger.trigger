trigger TransactionTrigger on Transaction__c (before update) {
    TransactionTriggerHandler handler = new TransactionTriggerHandler();
    if(Trigger.isUpdate) handler.returnProducts(Trigger.New);
    if(Trigger.isDelete) handler.returnProducts(Trigger.New);
}