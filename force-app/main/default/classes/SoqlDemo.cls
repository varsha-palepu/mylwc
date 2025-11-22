public class SoqlDemo {
    public static void soql(){
      /*  List<Account> accList=[SELECT Id,Name,Industry 
                               FROM Account
                               WHERE Industry='Media'
                               ORDER BY Industry NULLS First];
        for(Account acc: accList){
            System.debug(acc);
        }
    }*/
    AggregateResult arg1=[Select sum(Amount) from Opportunity];
    System.debug(arg1);
}
}