public class DMLlearn {
    public static void dml(){
list<account> acclist=[select id,name from account limit 20];
    System.debug(acclist);
}
}