public class ApexTriggers {
    public static void createOpp(List<Account> accList){
        List<Opportunity> oppList=new List<Opportunity>();
        for(Account acc: accList){
            Opportunity opp=new Opportunity();
            opp.Name=acc.Name;
            opp.CloseDate=System.Today();
            opp.StageName= 'Prospecting';
            opp.AccountId=acc.Id;
            acc.AnnualRevenue=100000;
            oppList.add(opp);
        }
        Insert oppList;
    }
}