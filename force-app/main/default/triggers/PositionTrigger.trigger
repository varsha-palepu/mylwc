trigger PositionTrigger on Position__c (before insert,after insert) {
    if(trigger.isInsert){
        if(trigger.isBefore){
            PositiontriggerHandler.updatePosition(Trigger.new);
        }
        else if(trigger.isAfter){
         PositiontriggerHandler.updatetask(Trigger.new);   
        }
    }
}