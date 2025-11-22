public class JSONGenerators {
    public void createJSON(String nm,String ph, String ind){
        System.JSONGenerator js = JSON.createGenerator(true);
        js.writeStartObject();
        try{
            Account acc = new Account();
            acc.Name=nm;
            acc.Phone=ph;
            acc.Industry=ind;
            insert acc;
            js.writeStringField('Status', 'Success');
            js.writeIdField('Id', acc.Id);
            js.writeStringField('message', 'Account is created successfully');
            js.writeNumberField('Code', 201);
        }
        catch(Exception e){
            js.writeStringField('Status', 'Failed');
            js.writeStringField('message', 'Account is not created successfully');
            js.writeNumberField('Code', 401);
        }
        js.writeEndObject();
        String res = js.getAsString();
        System.debug(res);
    }
}