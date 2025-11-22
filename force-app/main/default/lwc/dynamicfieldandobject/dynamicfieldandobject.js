import { LightningElement,api, wire } from 'lwc';
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import ACCOUNT_REVENUE from"@salesforce/schema/Account.AnnualRevenue";
import { getFieldValue, getRecord, getFieldDisplayValue} from 'lightning/uiRecordApi';
export default class Dynamicfieldandobject extends LightningElement {
    @api recordId;
    accname;
    accrevenue;
    @wire(getRecord,{
         recordId: '$recordId',
                 fields: [ACCOUNT_NAME,ACCOUNT_REVENUE]
    })
    outputFunction({data,error}){
        if(data){
            console.log("data", data);
           // this.accname= data.fields.Name.value;
           // this.accrevenue= data.fields.AnnualRevenue.value;
           this.accname = getFieldValue(data,ACCOUNT_NAME);
           this.accrevenue = getFieldDisplayValue(data,ACCOUNT_REVENUE);
        }else if(error){
            console.log("error",error);
        }
    }
}