public class PositiontriggerHandler {
    public static void updatetask(List<Position__c> popList){
        List<Task> taskList=new List<Task>();
        for(Position__c pos:popList){
            Task tk=new Task();
            tk.Subject='call';
            tk.ActivityDate= System.today() + 7;
            tk.WhatId= pos.Id;
            tk.OwnerId=Userinfo.getUserId();
            tk.Status='Not Started';
            taskList.add(tk);
        }
        Insert taskList;
    }
    public static void updatePosition(List<Position__c> popList){
        for(Position__c pop : popList){
            if(pop.Status__c == 'New Position'){
                if(pop.Open_Date__c == Null){
                    pop.Open_Date__c =System.today();
                }
                if(pop.Max_pay__c == null && pop.Min_pay__c == null){
                    pop.Max_pay__c=15000;
                    pop.Min_pay__c=10000;
                }
            }
        }
    }
    
}