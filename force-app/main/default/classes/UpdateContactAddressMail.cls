public class UpdateContactAddressMail implements database.Batchable<sObject>, database.stateful {
    public integer recordCount = 0;
    public database.queryLocator start(database.batchableContext bc){
    	   return database.getqueryLocator('Select Id, BillingStreet, BillingCity, BillingState, BillingPostalCode,'+
                                           '(Select Id, MailingStreet, MailingCity, MailingState, MailingPostalCode from Contacts)'+
                                           'from Account Where BillingCountry = \'USA\'');
    }
    public void execute(database.batchableContext bc, List<Account> accList){
        List<Contact> conList= new List<Contact>();
        for(Account acc : accList){
            for(Contact con : acc.Contacts){
                con.MailingStreet= acc.BillingStreet;
                con.MailingCity = acc.BillingCity;
                con.Mailingstate = acc.BillingState;
                con.MailingPostalCode = acc.BillingPostalcode;
                conList.add(con);
                recordCount++;
            }
            update accList;
        }
    }
    public void finish(database.BatchableContext bc){
        System.debug('total contact updated ' + recordCount);
    }
}