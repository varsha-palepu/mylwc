public class TriggerHandler {
    public static void updateRating(List<Account> accList){
        for(Account acc:accList){
            if(acc.Industry != null && acc.Industry=='media'){
                acc.Rating='Hot';
            }
        }   
     }
    public static void updateOpportunity(List<Account> acclist){
        List<Opportunity> oppList=new List<Opportunity>();
        for(Account acc:accList){
            Opportunity opp=new Opportunity();
            opp.Name=acc.name;
            opp.StageName='Prospecting';
            opp.CloseDate=System.Today()+7;
            opp.AccountId=acc.Id;
            oppList.add(opp);
        }
        if(!oppList.isempty()){
            insert oppList;
        }
    }
    public static void updatePhone(List<Account> accList, Map<Id, Account> accoldMap){
        For(Account acc: accList){
            if(acc.Phone != accoldMap.get(acc.Id).Phone){
                acc.Description=' phone old value = '+ accoldMap.get(acc.Id).Phone + 'phone new value = '+ acc.Phone;
            }
        }
    }
    public static void updateRelateContact(List<Account> accList, Map<Id, Account> accoldmap){
        List<Contact> conList = new List<Contact>();
        Map<Id, Account> accMap = new Map<Id, Account>();
        for(Account acc: accList){
            if(acc.Phone != accoldmap.get(acc.Id).phone){
                accMap.put(acc.Id,acc);
            }
        }
        for(Contact con:[Select Id, phone, AccountID from Contact Where AccountID in:accMap.keyset()]){
            if(accMap.containsKey(con.AccountID)){
                con.HomePhone = accMap.get(con.AccountID).phone;
                conList.add(con);
            }
        }
        Update conList;
    }
    public static void updaterelatedcontactaddress(List<Account> accList, Map<Id, Account> accoldMap){
        List<Contact> conlist =new List<Contact>();
        Map<Id, Account> accMap = new Map<Id, Account>();
        for(Account acc: accList){
            if(acc.Billingcity != accoldMap.get(acc.Id).Billingcity && accoldMap != null){
                accMap.put(acc.Id,acc);
            }
        }
        for(Contact con:[Select Id, AccountID from Contact where AccountID in:accMap.keyset()]){
            If(accMap.containsKey(con.AccountID)){
                con.MailingCity =accMap.get(con.AccountId).BillingCity;
            }
            conList.add(con);
        }
        Update conList;
    }
    public static void preventDeletion(List<Account> accList){
        Profile p=[Select Id from Profile where Name='System Administrator'];
        for(Account acc: accList){
            if(UserInfo.getProfileId() != p.Id  ||   acc.Active__c=='Yes'){
                acc.addError('Active accounts cannot be deleted');
            }
        }
    }
    public static void copyBillingtoShipping(List<Account> accList, Map<Id, Account> accoldMap){
        
    }
    public static void updateRelatedOpp(List<Account> accList, Map<Id,Account> accoldMap){
        
        for(Account acc : accList){
            if(acc.Active__c=='No' && accoldMap.get(acc.Id).Active__c=='Yes'){
                
            }
        }
    }
    public static void updateactivities(List<Account> accList,Map<Id,Account> oldMapacc){
        for(Account acc: accList){
            if(acc.Industry == 'Agriculture' && acc.Type == 'Prospect'){
                if(oldMapacc.get(acc.Id).Ownership != acc.Ownership && acc.Ownership =='Private'){
                    acc.addError('OwnerShip cannot be updated to Private');
                }
            }
        }
    }
    public static void updateContactsWebsite(List<Account> accList, Map<Id,Account> oldaccMap){
        Map<Id,String> oldaccMap1 =new Map<Id,String>();
        for(Account acc: accList){
            if(oldaccMap.get(acc.Id).Website != acc.Website){
                oldaccMap1.put(acc.Id,acc.Website);
            }
        }
        if(oldaccMap.Keyset().size() > 0){
            List<Contact> updatecon= new List<Contact>();
            List<Contact> conList = [Select Id, FirstName, Website__c, AccountId from Contact where AccountId In : oldaccMap1.Keyset()];
            for(Contact con : conList){
                con.Website__c= oldaccMap1.get(con.AccountId);
                updatecon.add(con);
            }
            if(updatecon.size() > 0){
                update updatecon;
            }
        }
    }
    public static void closeopps(List<Account> accList, Map<Id,Account> oldMapacc){
        Set<Id> accIds = new Set<Id>();
        for(Account acc : accList){
            if(acc.Close_all_opps__c == true && oldMapacc.get(acc.Id).Close_all_opps__c == False ){
                accIds.add(acc.Id);
            }
        }
        List<Opportunity> oppList = [Select Id, AccountId, Name, stageName from Opportunity where AccountId in : accIds and Probability > 70 and 
                                    stageName != 'Closed Lost'];
        List<Opportunity> opps = new List<Opportunity>();
        for(Opportunity opp: oppList){
            opp.stageName ='Closed Lost';
            opps.add(opp);
        }
        if(!opps.isEmpty()){
            update opps;
        }
    }
    public static void preventduplicateAccount(List<Account> accList){
        Set<string> accname= new Set<string>();
        for(Account acc:accList){
            accname.add(acc.name);
        }
        List<Account> existingacc=[Select Id, name from Account where name In:accname];
        Set<String> existingaccname=new set<String>();
        for(Account acc: existingacc){
            existingaccname.add(acc.name);
        }
        for(Account acc: accList){
            if(existingaccname.contains(acc.name)){
                acc.adderror('Account name already exist please try with a new Account name');
            }
        }
    }
    public static void updatechildrecords(List<Account> accList,Map<Id,Account> oldmapacc){
        Set<Id> accIds = new Set<id>();
        for(Account acc:accList){
            if(acc.Status__c != oldmapacc.get(acc.Id).Status__c && acc.Status__c == 'Inactive'){
                accIds.add(acc.Id);
            }
        }
      List<Opportunity> relopp = new List<Opportunity>();
        for(Opportunity opp:[Select Id,AccountId from Opportunity where AccountId In: accIds]){
            relopp.add(opp);
        }
       List<Contact> relcon = new List<Contact>();
        for(Contact con:[SELECT Do_not_contact__c, Id, AccountId FROM Contact where AccountId In: accIds]){
            relcon.add(con);
        }
        List<Contact> updaterelcon =new List<Contact>();
        if(!accIds.isEmpty()){
            for(Contact con:relcon){
                con.Do_not_contact__c = true;
                updaterelcon.add(con);
            }
            if(!updaterelcon.isEmpty()){
                update updaterelcon;
            }
            if(!relopp.isEmpty()){
                delete relopp;
            }
        }
    }
    public static void createcontact(List<Account> accList,Map<Id,Account> oldaccMap){
       Map<Id,Account> accIds = new Map<Id,Account>();
        List<Contact> conrec = new List<Contact>();
        if(!accList.isEmpty()){
            for(Account acc: accList){
                if(acc.Create_Contact__c == true && oldaccMap.get(acc.Id).Create_Contact__c == false || oldaccMap == null ){
                    accIds.put(acc.Id,acc);
                }
            }
        }
        if(!accList.isEmpty()){
            for(Id acc: accIds.keyset()){
                Contact con =new Contact();
                con.AccountId= acc;
                con.FirstName= 'Test contact';
                con.LastName= accIds.get(acc).Name;
                conrec.add(con);
            }
        }
        if(!conrec.isEmpty()){
            Insert conrec;
        }
    }
}