public class trgopplineitem {
    public static void descriptionopplineitem(List<OpportunityLineItem> oliList){
        Set<Id> oppIds = new Set<Id>();
        for(OpportunityLineItem oli : oliList){
            if(String.isnotblank(oli.Description)){
                oppIds.add(oli.OpportunityId); 
            } 
        }
        if(!oppIds.isempty()){
            List<Opportunity> oppList = [select AccountId,(Select Description from OpportunityLineItems ORDER BY
                                                         LastModifiedDate desc limit 1)
                                         from Opportunity where Id IN: oppIds];
            Map<Id,String> accoli = new Map<Id,String>();
            for(Opportunity opp: oppList){
                
            }
        }
    }
}