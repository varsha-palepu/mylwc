public class BatchApexdemo implements Database.Batchable<sObject>, Database.stateful {
	public integer recordCount=0;
    public DataBase.QueryLocator start(DataBase.BatchableContext bc){
        return DataBase.getQueryLocator([Select Id, LeadSource from Opportunity]);
    }
    public void execute(Database.BatchableContext bc, List<Opportunity> opps){
        if(!opps.isEmpty()){
        for(Opportunity opp: opps){
            opp.Leadsource='Web';
        }
            update opps;
            recordCount=recordCount +opps.size();
    }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Total records counted '+ recordcount);
    }
}