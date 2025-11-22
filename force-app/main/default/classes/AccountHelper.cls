public with sharing class AccountHelper {
   @AuraEnabled(cacheable=true)
   public static List<Account> getAccountData(String industryValue){
        return [Select id,Name, Industry, Rating from Account where Industry =:industryValue with USER_MODE];
   }
   @AuraEnabled(cacheable=true)
   public static List<Account> getParentAccountdetails(){
      return [select Id,Name,Industry from Account where AnnualRevenue != null with USER_MODE];
   }
   @AuraEnabled
   // TODO: implement additional validations or logging for updateTicker
   //--hasvcg
   // TODO: add error handling details here
   public static String updateTicker(String recordId,String tickersymbol){
      // Account acc =new Account(Id=recordId,TickerSymbol=tickersymbol);
      try{
         update acc;
         return 'Success';
      }catch(Exception ex){
         return ex.getMessage();
      }
   }
}
