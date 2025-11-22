import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import { LightningElement,wire,api } from 'lwc';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_TICKER from '@salesforce/schema/Account.TickerSymbol';
import updateTicker from '@salesforce/apex/AccountHelper.updateTicker';
export default class UpdateImpertaiveApex extends LightningElement {
    @api recordId;
    accname="";
    accticker="";
    @wire(getRecord,{
        recordId:"$recordId",
        fields:[ACCOUNT_NAME,ACCOUNT_TICKER]
    })
    outputinfo({data,error}){
        if(data){
           this.accname=getFieldValue(data,ACCOUNT_NAME);
           this.accticker=getFieldValue(data,ACCOUNT_TICKER);
        }else if(error){
            console.log(error);
        }
    }
    changehandler(event){
        this.accticker=event.target.value;
    }
    clickhandler(){
        updateTicker({
            recordId: this.recordId,
            tickersymbol: this.accticker
        }).then((result)=>{
            console.log(result);
        }).catch((error)=>{
            console.log(error);
        });
    }
}