trigger LineItemTrigger on LineItemDTO (before insert, before update) {
    //Each Line Item should decrease the Product's Available Amount. Prevent values less than 0.
    LineItemTriggerHandler handler = new LineItemTriggerHandler();
    if(Trigger.isInsert) handler.onInsert(Trigger.New);
    if(Trigger.isUpdate) handler.onUpdate(Trigger.New,Trigger.oldMap);
}