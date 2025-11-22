trigger caseTrigger on Case (before insert,After insert,after update) {
    if(trigger.isInsert && trigger.isBefore){
        CaseTriggerHandler.updateCaseprio(trigger.new);
        CaseTriggerHandler.linkcasewithcontact(Trigger.new);
    }
    if(trigger.isInsert && trigger.isAfter){
        CaseTriggerHandler.updateCasenumber(trigger.new);
         CasetriggerHandler.followuptask(trigger.new,null);
    }
    if(trigger.isAfter && trigger.IsUpdate){
        CasetriggerHandler.followuptask(trigger.new,trigger.oldmap);
    }
}