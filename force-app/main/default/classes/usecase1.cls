public class usecase1 {
    public static List<String> method1(List<Id> accid){
        List<String> conemail = new List<String>();
        List<Contact> conlist = [Select Id,AccountId, email from contact where AccountId In : accid];
        for(Contact con: conlist){
            conemail.add(con.email);
        }
        return conemail;
    }
    public static Boolean method2(String accName, String conName){
        List<contact> con= [select Id,AccountId from Contact where AccountId In(select Id from Account)];
        if(con.size()>0){
            return true;
        }
        return false;
    }
    public static void method3(){
        
    }
}