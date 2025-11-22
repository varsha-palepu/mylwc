public class JSON_Serialize {
    public void createJSON(String nm,String phn,String ind){
        System.JSONGenerator js = JSON.createGenerator(true);
        js.writeStartObject();
        try{
            Account acc=new Account();
            acc.name=nm;
            acc.Phone=phn;
            acc.Industry=ind;
            insert acc;
            js.writeStringfield('Status','Success');
            js.writeIDfield('ID',acc.ID);
            js.writeStringField('message','Account created successfully');
            js.writeNumberfield('code',201);
        }
        catch(exception e){
            js.writeStringfield('Status','Failed');
            js.writeStringfield('message',e.getMessage());
            js.writeNumberfield('Code',401);
        }
        js.writeEndObject();
        String result = js.getAsString();
        System.debug(result);
    }
}