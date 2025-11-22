public with sharing class ApexSecurity {
    public static List<Account> getAllAccounts(){
        try{
            return [ select Id, Name from Account with User_Mode];
        }
        catch(Exception e){
            return new List<Account>();
        }
    }
    //StripInaccessible
    public static List<Account> getAllRecords(){
        SobjectAccessDecision Sl=Security.StripInaccessible(AccessType.READABLE,[Select Id, Name from Account]);
        List<Account> accList= sl.getRecords();
        System.debug(acclist);
        System.debug(sl.getRemovedfields());
        System.debug(sl.getRemovedfields().get('Account'));
        return accList;
    }
}