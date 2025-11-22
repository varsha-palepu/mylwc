trigger OpportunityTrigger on Opportunity (before insert, after insert, before update, after update,after delete) {
        if(trigger.isInsert){
        if(trigger.isBefore){
        OpportunityTriggerHandler.updateDescription(trigger.new,Null);
    }
            if(trigger.isAfter){
              //OpportunityTriggerHandler.updateaccountfield(trigger.new,Null);
              //OpportunityTriggerHandler.updatesecmaxopp(trigger.new,Null);
              //OpportunityTriggerHandler.triggeremailtorecowner(trigger.new,Null);
            }   
   }
    if(trigger.isupdate){
        if(trigger.isAfter){
            //OpportunityTriggerHandler.createTask(trigger.new,trigger.oldMap);
           OpportunityTriggerHandler.deletetheteam(Trigger.new);
            OpportunityTriggerhandler.updatetheroles(Trigger.new, trigger.oldMap);
            OpportunityTriggerHandler.upcrtask(Trigger.new,Trigger.OldMap);
            OpportunityTriggerHandler.updateAccountStatus(Trigger.new,Trigger.OldMap);
            OpportunityTriggerHandler.updateaccountfield(trigger.new,Trigger.OldMap); 
            OpportunityTriggerHandler.updatesecmaxopp(trigger.new,Trigger.oldMap);
            OpportunityTriggerHandler.triggeremailtorecowner(trigger.new,Trigger.oldMap);
        }
        if(trigger.isBefore){
            OpportunityTriggerHandler.updateDescription(trigger.new,trigger.oldMap);
           //  OpportunityTriggerHandler.updateOpportunityamt(trigger.new,Trigger.oldMap);
        }
    }
    if(trigger.isDelete){
        if(trigger.isAfter){
            OpportunityTriggerHandler.oppdeleteupdatetask(Trigger.old);
        }
    }

}