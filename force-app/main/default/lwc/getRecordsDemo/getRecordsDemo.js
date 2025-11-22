import { LightningElement,api,wire } from 'lwc';
import {getRecords} from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELDS from '@salesforce/schema/Account.Name';
import CONTACT_NAME_FIELDS from '@salesforce/schema/Contact.Name';
export default class GetRecordsDemo extends LightningElement {
    outputs;
    errors;
    @wire(getRecords,{
        records:[
            {
                recordIds:["001GA00004sN4iMYAS","001GA00004sN4iLYAS"],
                fields: [ACCOUNT_NAME_FIELDS]
            },
            {
                recordIds:["003GA000043n730YAA"],
                fields: [CONTACT_NAME_FIELDS]
            }
        ]
    })
    outputfunction({data,error}){
        if(data){
            console.log("data",data);
            this.outputs=data;
            this.errors=null;
        }else if(error){
            console.log("error",error);
            this.errors=error;
            this.output=null;
        }
    }
}