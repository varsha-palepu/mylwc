public class tasktriggerHandler {
    public static void updatePriority(List<Task> task){
        for(Task tk: task){
            tk.Priority='High';
        }
    }
    /*public static void updatetheContact(List<Task> taskList){
   
        Map<Id,Integer> concountMap = new Map<Id, Integer>();
        for(Task tk : taskList){
            if(String.valueof(tk.WhoId).startswith('003')){
                if(concountMap.containskey(tk.WhoId)){
                    Integer countVar =concountMap.get(tk.WhoId) +1;
                    concountMap.put(tk.WhoId,countVar);
                }
                else{
                    concountMap.put(tk.WhoId, 1);
                }
            } 
        }
        List<Contact> contactList= [Select Id,Number_of_Tasks_Associated__c from Contact where Id IN : concountMap.Keyset()];
        for(Contact con : contactList){
            if(con.Number_of_Tasks_Associated__c != null){
                con.Number_of_Tasks_Associated__c =con.Number_of_Tasks_Associated__c + concountMap.get(con.Id);
            }
            else{
                con.Number_of_Tasks_Associated__c =concountMap.get(con.Id);
            }
        }
    }*/
    public static void updatethecheckbox(List<task> taskRecords){
        List<Id> contactIds =new List<Id>();
        for(Task t : taskRecords){
            if(String.valueOf(t.WhoID).startsWith('003')){
                contactIds.add(t.WhoId);
            }
        }
    }
}