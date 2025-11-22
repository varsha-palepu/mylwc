public class ConvertUsers implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext ct){
        return DataBase.getQueryLocator([Select Id from User where name = 'Integration user']);
    }
    public void execute(Database.batchableContext ct, List<User> userList){
        List<User> updateUsers = new List<User>();
        for(user u : userList){
            u.ProfileId=[Select Id from Profile where Name = 'System Administrator'].Id;
            updateUsers.add(u);
        }
        Update updateUsers;
    }
    public void finish(Database.batchableContext ct){
        
    }
}