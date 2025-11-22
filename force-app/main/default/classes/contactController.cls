public with sharing class contactController {
    @AuraEnabled(Cacheable=true)
   public static List<Contact> getContactList() {
    List<Contact> conList= [SELECT Id, Name,FirstName,LastName,Title,Phone,Email,PhotoUrl FROM Contact WHERE PhotoUrl != null with User_Mode LIMIT 10];
    return conList;
    }
}