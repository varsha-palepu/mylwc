public class DailyOppProcessor implements Schedulable {
    public void execute(SchedulableContext context){
        List<Opportunity> oppList=[Select ID,LeadSource from Opportunity where Leadsource = Null Limit 100];
        for(Opportunity opp : oppList){
            opp.Leadsource = 'Web';
        }
        Update OppList;
    }
}