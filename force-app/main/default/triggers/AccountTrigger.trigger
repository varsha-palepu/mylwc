trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete) {
    if(trigger.isInsert){
        //TriggerHandler.updaterelatedcontactaddress(trigger.new, null);
       if(trigger.isBefore){
      	//TriggerHandler.updateRating(Trigger.new); 
        TriggerHandler.copyBillingtoShipping(Trigger.new,null);
        TriggerHandler.preventduplicateAccount(Trigger.new);
      }
        else if(trigger.isAfter){
            TriggerHandler.updateOpportunity(Trigger.new); 
            TriggerHandler.createcontact(Trigger.new,null);
        }
      //   if(trigger.isAfter){
        //    ApexTriggers.createOpp(Trigger.new);
        //}
    }
    if(trigger.isUpdate){
        if(trigger.isBefore){
        TriggerHandler.updatePhone(trigger.new,trigger.oldMap);
    }
        if(trigger.isAfter){
            TriggerHandler.updaterelatedcontactaddress(trigger.new, trigger.oldMap);
            //TriggerHandler.updateopportunitystage(trigger.new, trigger.oldMap);
            TriggerHandler.closeopps(trigger.new,trigger.oldMap);
            TriggerHandler.updatechildrecords(trigger.new,trigger.oldMap);
            TriggerHandler.createcontact(Trigger.new,Trigger.oldMap);
        }
   }
    if(trigger.isDelete){
        if(trigger.isBefore){
            TriggerHandler.preventDeletion(trigger.old);
        }
    }
    if(trigger.isUpdate){
        if(trigger.isBefore){
            TriggerHandler.copyBillingtoShipping(Trigger.new, Trigger.oldMap);
            TriggerHandler.updateactivities(Trigger.new,Trigger.oldMap);
        }
        if(trigger.isAfter){
            TriggerHandler.updateRelatedOpp(Trigger.new, Trigger.oldMap);
            TriggerHandler.updateContactsWebsite(Trigger.new, Trigger.oldMap);
        }
    }
}