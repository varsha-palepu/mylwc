@RestResource(urlMapping='/accList/*')
global class RestServiceTestingAcc {
    @httpget
    global static List<Account> dogetAcc(){
        List<Account> accList = [Select Id,name,Active__c,Industry from Account where Industry ='Energy'];
        return accList;
    }

}