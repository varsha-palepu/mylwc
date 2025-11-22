public class OpportunityTriggerHandler {
   /* public static void createTask(List<Opportunity> oppList, Map<Id, Opportunity> oldoppMap){
        List<Task> tasklist=new List<Task>();
        for(Opportunity opp: oppList){
            if(opp.StageName != oldoppMap.get(opp.id).StageName){
                Task tsk =new Task();
                tsk.WhatId = opp.Id;
                tsk.Subject= 'Demo';
                tsk.Priority = 'Normal';
                tsk.Status ='Not Started';
                tsk.OwnerId = opp.OwnerID;
                taskList.add(tsk);
            }
        }
        Insert taskList;
    }*/
    public static void updateDescription(List<Opportunity> oppList, Map<Id, Opportunity> oldoppMap){
        for(Opportunity opp: oppList){
            if(( oldoppMap == null) || (opp.StageName != oldoppMap.get(opp.Id).StageName)){
                if(opp.stagename=='Closed Won'){
                    opp.Description='Opportunity is closed Won';
                }else if(opp.StageName=='Closed Lost'){
                    opp.Description='Opportunity is Closed Lost';
                }else{
                    opp.Description='Opportunity is Open';
                }
            }
        }
    }
  /* public static void updateOpportunityamt(List<Opportunity> oppList, Map<Id, Opportunity> oldoppMap){
        for(Opportunity opp: oppList){
            if(opp.StageName != oldoppMap.get(opp.id).StageName){
                opp.Amount= (opp.Probability * opp.ExpectedRevenue);
            }
        }
    }*/
    public static void deletetheteam(List<Opportunity> oppList){
        List<Id> ListOfIds = new List<Id>();
        List<OpportunityTeamMember> deleteMemberList = new List<OpportunityTeamMember>();
        for(Opportunity opp: oppList){
            ListOfIds.add(opp.Id);
        }
        List<OpportunityTeamMember> team = [Select Id,OpportunityId from OpportunityTeamMember where OpportunityID IN : ListOfIds];
        for(Opportunity opp : oppList){
            if(opp.StageName == 'Closed Lost'){
                for(OpportunityTeamMember t : team){
                if(t.OpportunityId == opp.ID){
                    deleteMemberList.add(t);
                }
            }
        }
        }
        if(!deleteMemberList.isEmpty()){
            delete deleteMemberList;
        }
    }
    public static void updatetheroles(List<Opportunity> oppList, Map<Id,Opportunity> OldMapopp){
        List<OpportunityTeammember> oppMemList = new List<OpportunityTeamMember>();
        List<User> opportunists = [Select Id, UserRole.Name from User where isActive = true AND UserRole.Name='Opportunists'];
        for(Opportunity opp : oppList){
            if(opp.StageName == 'Needs Analysis' && OldMapopp.get(opp.id).StageName != opp.StageName){
                for(User userRec : opportunists){
                OpportunityTeamMember oppMember = new OpportunityTeamMember();
                oppMember.OpportunityId = opp.Id;
                oppMember.OpportunityAccessLevel = 'Edit';
                oppMember.UserId = userRec.Id;
                oppMemList.add(oppMember);
                }
              
            }
        }
        if(!oppMemList.isEmpty()){
            insert oppMemList;
        }
    }
    public static void oppdeleteupdatetask(List<Opportunity> oppList){
        Set<Id> accrecordIds = new Set<Id>();
        Map<Id,Id> oppvsaccountmap = new Map<Id,Id>();
        Map<Id,Id> accIdvsowner = new Map<Id,Id>();
        for(Opportunity opp : oppList){
            accrecordIds.add(opp.AccountId);
            oppvsaccountmap.put(opp.Id,opp.AccountId);
        }
        List<Account> accrecords =[Select Id, OwnerId from Account where Id In : accrecordIds];
        for(Account acc: accrecords){
            accIdvsowner.put(acc.Id,acc.OwnerId);
        }
        List<Task> tasklist = new List<Task>();
        for(Opportunity opp: oppList){
                Task tk =new Task();
                tk.Subject= 'Task created after the opportunity has been deleted';
                tk.Priority = 'Normal';
                tk.Status ='Not Started';
                tk.OwnerId = accIdvsowner.get(oppvsaccountmap.get(opp.Id));
                tasklist.add(tk);
            }
        if(!tasklist.isEmpty()){
            insert tasklist;
        }
    }
    public static void upcrtask(List<Opportunity> opplist, Map<Id,Opportunity> OldMapopp){
        Set<Id> oppIds = new Set<Id>();
        for(Opportunity opp:oppList){
            if(opp.StageName != OldMapopp.get(opp.Id).StageName)
            oppIds.add(opp.Id);
        }
        List<Task> task1 = [Select Id,WhatId,Priority,Status,OwnerId,Description from Task where WhatId IN: oppIds];    
            if(!task1.isempty()){
                //task1.Description = 'updated from opportunity stagename update';
            }
    	}
    public static void updateAccountStatus(List<Opportunity> oppList, Map<Id,Opportunity> OldMapopp){
        Set<Id> oppIds = new Set<Id>();
        if(!oppList.isEmpty()){
            for(Opportunity opp : oppList){
                if(opp.StageName != OldMapopp.get(opp.Id).StageName && (opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost')){
                    oppIds.add(opp.Id);
                }
            }    
        }
         Map<Id,Opportunity> accMap = new Map<Id,Opportunity>([Select Account.Id,Account.Account_status__c from Opportunity where Id IN :oppIds]);
    }
    public static void updateaccountfield(List<Opportunity> oppList,Map<Id,Opportunity> oldmapopp){
       Set<Id> accIds = new set<Id>(); 
        List<Account> acctoupdate = new List<Account>();
       for(Opportunity opp: oppList){
            if(!oppList.isEmpty() && (opp.Amount != oldmapopp.get(opp.Id).Amount)){
                accIds.add(opp.AccountId);
            }
        }
        Map<Id,Decimal> maxamountacc = new Map<Id,Decimal>();
        if(!accIds.isEmpty()){
            List<Opportunity> opplist1 =[Select Id,AccountId,Amount,IsClosed from Opportunity where AccountId In: accIds
                                  and IsClosed = true];
            for(Opportunity opp: opplist1){
                Decimal maxamount = maxamountacc.get(opp.AccountId);
                if(maxamount == null || opp.Amount > maxamount){
                    maxamountacc.put(opp.AccountId,opp.Amount);
                }
            }
        }
            for(Id accountid : accIds){
                Decimal maxaccoppamount = maxamountacc.get(accountid);
                Account acc = new Account();
                acc.Id=accountid;
                acc.max_closed_opp_amount__c = maxaccoppamount;
                acctoupdate.add(acc);
            }
        if(!acctoupdate.isEmpty()){
            update acctoupdate;
        }
        }
    public static void updatesecmaxopp(List<Opportunity> oppList,Map<Id,Opportunity> Oldmapopp){
        Set<Id> accIds = new Set<Id>();
        List<Account> newacclist = new List<Account>();
        for(Opportunity opp:oppList){
            if(!opplist.isEmpty() && (opp.AccountId != null && opp.AccountId != Oldmapopp.get(opp.Id).AccountId)){
                accIds.add(opp.AccountId);
            }
        }
        List<Opportunity> secamtopp = new List<Opportunity>();
        for(Opportunity opp:[Select Id,Name,Amount from Opportunity where AccountId In: accIds order by Amount Desc Limit 2]){
            secamtopp.add(opp);
        }
        List<Account> accList = [Select Id, Description from Account where Id IN:accIds];
        for(Account acc: accList){
            acc.Description = 'Second opp amount :'+ secamtopp[1].amount;
            newacclist.add(acc);
        }
        if(!newacclist.isempty()){
            update newacclist;
        }
    }
    
    public static void triggeremailtorecowner(List<Opportunity> opplist, Map<Id,Opportunity> oldmapopp){   
        Set<Id> ownerIds = new Set<Id>();
        List<Messaging.SingleEmailMessage> emaillist = new List<Messaging.SingleEmailMessage>();
        for(Opportunity opp: opplist){
              if(opp.Amount != null && opp.Amount != oldmapopp.get(opp.Id).Amount && opp.Amount > 10000){
                  ownerIds.add(opp.OwnerId);
              }
            }
        if(!ownerIds.isempty()){
            Map<Id,User> ownermap = new Map<Id,User>([Select Id,Name from User where ID In:ownerIds]);
            for(Opportunity opp: opplist){
                Messaging.SingleEmailMessage msg =new Messaging.SingleEmailMessage();
                msg.setToAddresses(new List<String>{opp.OwnerId});
                String name = ownermap.containsKey(opp.OwnerId)? ownermap.get(opp.OwnerId).Name : '';
                msg.setSubject('Opportunity Amount details exceeding');
                msg.setPlaintextBody('Dear' + name +',\n\n'+
                                    'The Opportunity' + opp.Name +'is exceeding the 10000 limit');
                emaillist.add(msg);
            }
        }
        if(!emaillist.isempty()){
            Messaging.sendEmail(emaillist);
        }
    }
 }