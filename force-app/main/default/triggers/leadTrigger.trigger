trigger leadTrigger on Lead (before insert,before update,before delete) {
    if(trigger.isUpdate){
        if(trigger.isBefore){
            leadTriggerHandler.updateLeadstatus(trigger.new,trigger.oldMap);
        }
    }
    if(trigger.isDelete){
        if(trigger.isBefore){
            leadTriggerHandler.beforeDeleterecord(trigger.old);
        }
    }
}