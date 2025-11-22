import { LightningElement,wire} from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
export default class PicklistValuedemo extends LightningElement {
    value;
    @wire(getObjectInfo,{
        objectapiname :ACCOUNT_OBJECT
    })accountlist;
    @wire(getPicklistValues,{
        recordapiname:"$accountlist.data.defaultRecordTypeId",
        fieldapiname : ACCOUNT_INDUSTRY
    })industrypicklist;

    handleChange(event){
        this.value= event.target.value;
    }
}