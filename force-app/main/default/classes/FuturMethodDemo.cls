public class FuturMethodDemo {
	@future
    public static void countContacts(List<ID> accIds){
        List<Account> accList = [Select Id,(Select Id from Contacts) from Account where ID IN: accIds];
        for(Account acc: accList){
            acc.Number_of_Contacts__c= acc.Contacts.size();
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
}