public class CaseTriggerHandler {
    public static void updatecase(List<Case> caseList){
        List<Account> acclist=new List<Account>();
        for(Case c: caseList){
            if(c.accountID != null){
                Account acc=new Account();
                acc.Id=c.AccountId;
                
            }
        }
    }
    public static void updateCaseprio(List<Case> caseList){
        for(Case cs: caseList){
            if(cs.Origin == 'Phone'){
                cs.Priority = 'High';
            }else
            {
                cs.Priority = 'Low';
            }
        }
    }
    public static void updateCasenumber(List<Case> caseList){
        Set<Id> accIds= new Set<Id>();
        for(Case c: caseList){
            if(!caseList.isEmpty()){
                accIds.add(c.AccountId);
            }
        }
        Map<Id,Account> accMap= new Map<Id,Account>([Select Id,Last_case_inserted__c from Account Where Id In:accIds]);
        Map<Id,Account> newacc = new Map<Id,Account>();
        for(Case c: caseList){
            if(accMap.containsKey(c.AccountId)){
                Account acc= accMap.get(c.AccountId);
                if(acc.Last_case_inserted__c != c.CaseNumber){
                    acc.Last_case_inserted__c = c.CaseNumber;
                    newacc.put(acc.Id,acc);
                }
            }
        }
        if(!newacc.isEmpty()){
            update newacc.values();
        }
    }
    public static void followuptask(List<Case> caselist,Map<Id,Case> oldcasemap){
        Set<Id> accIds = new Set<Id>();
        Map<Id,Id>conaccmap = new Map<Id,Id>();
        List<Task> tasklist = new List<Task>();
        if(!caselist.isempty()){
            for(Case cs:caselist){
                if(cs.Create_Task__c== true && oldcasemap != null && oldcasemap.get(cs.Id).Create_Task__c == false){
                    accIds.add(cs.AccountId);
                }
            }
        }
        if(!accIds.isempty()){
             List<Contact> conlist =[Select Id,AccountId,Primary_contact__c from Contact where AccountId IN:accIds and Primary_contact__c=true];
            for(Contact con:conlist){
                conaccmap.put(con.AccountId,con.Id);
            }
        }
        for(Case cs: caselist){
            if(cs.Create_Task__c==true && conaccmap.containsKey(cs.AccountId)){
                Task ts = new Task();
                ts.Subject='Follow up through trigger';
                ts.WhoId=conaccmap.get(cs.AccountId);
                ts.Status='Not Started';
                ts.Priority='Normal';
                tasklist.add(ts);
            }
        }
        if(!tasklist.isempty()){
            insert tasklist;
        }
    }
    public static void linkcasewithcontact(List<Case> caselist){
        Set<String> storeemail = new Set<String>();
        Map<String,Contact> conmap = new Map<String,Contact>();
        Map<string,Id> emailtocontact = new Map<string,Id>();
        List<Contact> newconlist = new List<Contact>();
        if(!caselist.isempty()){
            for(Case cs : caselist){
                if(cs.Supplied_email__c!= null){
                    storeemail.add(cs.Supplied_email__c);
                }
            }
        }
        List<Contact> conlist=[Select Id, Name,email from contact where email In:storeemail];
        for(Contact con: conlist){
            conmap.put(con.email,con);
        }
        for(Case cs : caselist){
            if(conmap.containsKey(cs.Supplied_email__c)){
              Contact existingcontact = conmap.get(cs.Supplied_email__c);
              //updatecase.add(cs);
              emailtocontact.put(existingcontact.Email,existingcontact.Id);
            }
            else{
                Contact con = new Contact();
                con.FirstName='test'+ cs.CaseNumber;
                con.LastName='test last' + cs.CaseNumber;
                con.Email=cs.Supplied_email__c;
                newconlist.add(con);
            }
        }
        if(!newconlist.isempty()){
            insert newconlist;
            for(Contact con: newconlist){
                if(conmap.containsKey(con.email)){
                    emailtocontact.put(con.Email,con.Id);
                }
            }
        }
        for(Case cs:caselist){
            if(emailtocontact.containsKey(cs.Supplied_email__c)){
                cs.ContactId = emailtocontact.get(cs.Supplied_email__c);
            }
        }
    }
}