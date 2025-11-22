public class ApexScenarios {
    public static void Apex1(){
        List<Account> acclist = new List<Account>();
        acclist=[Select Id,name,(Select Id from Contacts) from Account where Phone != null];
        if(!acclist.isempty()){
            for(Account acc: acclist){
                   System.debug(acc.name +' has '+ acc.Contacts.size() +' contacts related');
            }
        }
    }
    public static void Apex2(){
        List<Account> acclist1=[Select Id,name,(select Id,Amount from Opportunities) from Account where Phone!=null];
        if(!acclist1.isempty()){
            for(Account acc: acclist1){
                decimal total=0;
                for(Opportunity opp:acc.Opportunities){
                    if(opp.amount != null){
                    total= total+ opp.amount;
                }
            }
            System.debug(acc.name + total);
        }
    }
}
    public static void apex3(){
        List<Opportunity> oppList=[Select Id, StageName from opportunity where CreatedDate = THIS_YEAR];
        for(Opportunity opp: oppList){
            if(opp.StageName == 'Closed Won'){
                opp.Description= 'Opportunity is closed won';
            }
            else if(opp.StageName == 'Closed lost'){
                opp.Description= 'Opportunity is closed lost';
            }
            else
            {
                 opp.Description= 'Opportunity is open';
            }
        }
        update oppList;
    }
    public static void apex4(){
        List<Contact> conList=[Select Id,Name from Contact where CreatedDate > LAST_WEEK];
    }
}