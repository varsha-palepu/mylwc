public class Jsonparserex {
    
    public void ex3(){
       string js='[{"Message":"Number of pincode(s) found:3","Status":"Success","PostOffice":[{"Name":"Mouroungapakkam","Description":null,"BranchType":"Branch Post Office","DeliveryStatus":"Non-Delivery","Circle":"Tamilnadu","District":"Pondicherry","Division":"Pondicherry","Region":"Chennai Region","Block":"Pondicherry","State":"Pondicherry","Country":"India","Pincode":"605004"},{"Name":"Mudaliarpet","Description":null,"BranchType":"Sub Post Office","DeliveryStatus":"Delivery","Circle":"Tamilnadu","District":"Pondicherry","Division":"Pondicherry","Region":"Chennai Region","Block":"Pondicherry ","State":"Pondicherry","Country":"India","Pincode":"605004"},{"Name":"Thengaithittu","Description":null,"BranchType":"Branch Post Office","DeliveryStatus":"Non-Delivery","Circle":"Tamilnadu","District":"Pondicherry","Division":"Pondicherry","Region":"Chennai Region","Block":"Pondicherry","State":"Pondicherry","Country":"India","Pincode":"605004"}]}]';
        System.JSONParser js2 = JSON.CreateParser(js);
        while(js2.nextToken()!= null){
            if(js2.getText()=='PostOffice'){
                js2.nextToken();
                if(js2.getText()!=null){
                String name = js2.getText();
                System.debug(name);
                }
            }
        }
    }
}