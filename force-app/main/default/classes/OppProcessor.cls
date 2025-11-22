public class OppProcessor implements Database.Batchable<sObject>, Database.stateful {
    public integer Totalopprecords = 0;
    public Database.queryLocator start(Database.BatchableContext bc){
        return Database.getquerylocator([Select ID, name from Opportunity]);
    }
    public void execute(Database.BatchableContext bc, List<Opportunity> opps){
        for(Opportunity opp : opps){
            opp.leadsource = 'Web';
        }
        Update opps;
        Totalopprecords = Totalopprecords + opps.size();
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Total records processed' + Totalopprecords);
    }
}