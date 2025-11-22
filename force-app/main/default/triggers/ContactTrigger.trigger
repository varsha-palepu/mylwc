trigger ContactTrigger on Contact (before insert,After insert, After Delete, After Undelete,After Update) {
    if(trigger.isInsert){
        if(trigger.isBefore){
            ContactTriggerhandler.dontcreateContact(Trigger.new);
            ContactTriggerhandler.duplicatecontact(Trigger.new);
            ContactTriggerhandler.dontcreateextraContact(trigger.new);
        }
        if(trigger.isAfter){
            ContactTriggerhandler.createnewopp(Trigger.new);
        }
    }
    if(trigger.isUpdate){
        if(trigger.isBefore){
             ContactTriggerhandler.dontcreateextraContact(trigger.new);
        }
        if(trigger.isAfter){
          //  ContactTriggerhandler.updateparentAccount(Trigger.new, Trigger.oldMap);
         // ContactTriggerhandler.updateParentAccountsdescription(Trigger.new,Trigger.oldMap);
         ContactTriggerhandler.updateallrelcontactphone(Trigger.new,Trigger.oldMap);
        }
    }
}