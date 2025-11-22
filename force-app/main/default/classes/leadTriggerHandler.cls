public class leadTriggerHandler {
    public static void updateLeadstatus(List<Lead> ld, Map<Id,lead> oldleadMap){
        for(Lead ld1: ld){
                ld1.status='Working-Contacted';
        }
    }
    public static void beforeDeleterecord(List<Lead> ld){
        for(Lead ld1 : ld){
            if(ld1.Status == 'Working-Contacted'){
                ld1.addError('You cannot delete the lead in working contacted state');
            }
        }
    }
}