import { LightningElement,wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountHelper.getAccountData';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
export default class ImperativeApexDemo extends LightningElement {
    data=[];
    options =[];
    columns = [
        { label: 'Account name', fieldName: 'Name' },
        { label: 'Account Industry', fieldName: 'Industry'},
        { label: 'Account Rating', fieldName: 'Rating',  },
    ];
    selectedIndustry;
    @wire(getObjectInfo,{
        objectApiName:  ACCOUNT_OBJECT
    })
    objectinfo;
    @wire(getPicklistValues,{
        recordTypeId:"$objectinfo.data.defaultRecordTypeId",
        fieldApiName: ACCOUNT_INDUSTRY
    })
    picklistValues;
    handleChange(event){
        this.selectedIndustry=event.target.value;
    }
    clickhandler(){
        getAccountData({
            industryValue:this.selectedIndustry
        }).then((result)=>{
        this.data=result;
        }).catch((error)=>{
            console.log(error);
    });
}
}