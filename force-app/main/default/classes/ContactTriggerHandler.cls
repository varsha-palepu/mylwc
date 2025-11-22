public class ContactTriggerHandler {
    public static void dontcreateContact(List<Contact> con){
        for(Contact c: con){
            if(c.AccountId == null){
                c.addError('Parent info is required');
            }
        }
    }
    public static void updateparentAccount(List<Contact> conList, Map<Id,Contact> OldMapcon){
        List<Id> accountIdstoinform = new List<Id>();
        for(Contact con : conList){
            if(con.email != oldMapcon.get(con.Id).email && con.phone != oldMapcon.get(con.phone).Phone){
                accountIdstoinform.add(con.Id);
            }
        }
        
    }
    public static void duplicatecontact(List<Contact> conList){
        List<Contact> existingcon = [Select Id,LastName,Phone,Email from Contact limit 50000];
        for(Contact con : conList){
            for(Contact con1 : existingcon){
                if(con.LastName == con1.Lastname && con.Phone == con1.Phone && con.Email == con1.Email){
                    con.addError('Duplicate contact found');
                }
            }
        }
    }
    public static void dontcreateextraContact(List<Contact> conList){
        Set<Id> accIds = new set<Id>();
        for(Contact con: conList){
            if(!conList.isEmpty()){
            accIds.add(con.AccountId);
            }
        }
        Map<Id,Integer> countcontact = new Map<Id,Integer>();
        List<AggregateResult> agrList = [Select AccountId, Count(Id) countId from Contact where AccountId 
                                          In : accIds group by AccountId];
        for(Aggregateresult agr :agrList){
            countcontact.put((Id)agr.get('AccountId'),(Integer)agr.get('countId'));
        }
        for(Contact con : conList){
            if(!conList.isEmpty()){
                if(con.AccountId != null && countcontact.get(con.AccountId) > 2){
                    con.adderror('you cannot create more than 2 contact for the account');
                }
            }
        }
	 }
    public static void createnewopp(List<Contact> conlist){
        Set<Id> accIds= new Set<Id>();
        List<Account> acclistupdate = new List<Account>();
        List<Opportunity> newopplist= new List<Opportunity>();
        if(!conlist.isempty()){
            for(Contact con:conlist){
                accIds.add(con.AccountId);
            }
        }
        
        List<Account> Accountlist = [Select Id,description from Account where ID In:accIds];
        if(!accIds.isempty()){
        Map<Id,Opportunity> accamount = new Map<Id,Opportunity>(); 
        List<Opportunity> opplist=[Select Id,AccountId, Amount from Opportunity where AccountId In:accIds];
        if(!opplist.isempty()){
            for(opportunity opp: opplist){
                if(accamount.containsKey(opp.AccountId)){
                    Decimal oppamt = accamount.get(opp.AccountId).Amount;
                    system.debug('###' + oppamt);
                    //accamount.put(opp.AccountId,opp);
                }
                else{
                    accamount.put(opp.AccountId,opp);
                }
            }
             for(Account acc:Accountlist){
            if(accamount.containsKey(acc.Id)){
                acc.Description='Total opp amount '+ accamount.get(acc.Id).Amount;
                acclistupdate.add(acc);
            }
        	}
            if(!acclistupdate.isempty()){
                update acclistupdate;
            }
        }
        }
        else{
            for(Account acc:Accountlist){
                Opportunity opp = new Opportunity();
                opp.AccountId= acc.Id;
                opp.Amount=1000;
                opp.name='test'+ acc.name;
                newopplist.add(opp);
            }
        }
        if(!newopplist.isempty()){
            insert newopplist;
        }
    }
    public static void updateallrelcontactphone(List<Contact> conlist,Map<Id,Contact> oldconmap){
       Map<Id,Contact> conmaplist = new Map<Id,Contact>();
        List<Contact> updaterelcontact = new List<Contact>();
        List<Account> updaterelaccount = new List<Account>();
        if(!conlist.isempty()){
            for(Contact con:conlist){
                if(con.AccountId != null && (con.Phone != oldconmap.get(con.Id).Phone)){
                    conmaplist.put(con.AccountId, con);
                }
            }
        }
        List<Contact> allconlist = [Select Id,AccountId,Name,Phone from Contact where Id In:conmaplist.keyset()];
        if(!conlist.isempty()){
            for(Contact con: conlist){
                if(conmaplist.containsKey(con.AccountId) && con.phone != conmaplist.get(con.AccountId).Phone){
                    con.Phone=conmaplist.get(con.AccountId).Phone;
                    updaterelcontact.add(con);
                }
            }
            for(Id ids:conmaplist.keyset()){
                Account acc= new Account();
                acc.Id = ids;
                acc.Phone= conmaplist.get(ids).Phone;
                updaterelaccount.add(acc);
            }
            if(!updaterelcontact.isempty()){
                Update updaterelcontact;
            }
            if(!updaterelaccount.isempty()){
                update updaterelaccount;
            }
        }
    }
}