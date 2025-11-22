public class Jsongeneratorex2 {
    public void examplegen2(){
        System.JSONGenerator js= JSON.createGenerator(true);
        js.writeStartObject();
        try{
            List<Lead> lds=[Select Name,Company,Status,Email,AnnualRevenue from Lead limit 2];
            for(Lead ld:lds){
                js.writeStringField('Lead Name', ld.Name);
                js.writeStringField('Lead Company', ld.Company);
                js.writeStringField('Lead Status', ld.Status);
                js.writeStringField('Lead Email', ld.Email);
                js.writeNumberField('Lead Annualrevenue', ld.AnnualRevenue);
            }
        }
        catch(exception e){
            js.writeStringField('error: ',e.getMessage());
        }
        js.writeEndObject();
        String result = js.getAsString();
        system.debug(result);
    }
}