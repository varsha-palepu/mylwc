import { LightningElement, api } from 'lwc';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from "lightning/actions";
export default class ScreenQuickActionDemo extends LightningElement {
    @api recordId;
    @api objectApiName;
    fields={
        accountName:ACCOUNT_NAME,
        accountIndustry:ACCOUNT_INDUSTRY
    }
    closeModel(){
        this.dispatchEvent( new CloseActionScreenEvent());
    }
    successHandler(){
        this.dispatchEvent( new CloseActionScreenEvent());
        const event = new ShowToastEvent({
            title: 'Success',
            message:
                'Record has been saved successfully',
            variant: 'success'
        });
        this.dispatchEvent(event);
       
    }
}