import { LightningElement,api } from 'lwc';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class QuickActionsLwc extends LightningElement {
    @api recordId;
    @api objectApiName;
    fields={
        accountName: ACCOUNT_NAME,
        acccountIndustry: ACCOUNT_INDUSTRY
    };
    closemodal(){
        this.dispatchEvent(new closeActionScreenEvent());
    }
    successhandler(){
        const event = new ShowToastEvent({
            title: 'Success',
            message:
                'Record saved successfully',
            variant: 'success',
        });
        this.dispatchEvent(event);
        this.dispatchEvent(new closeActionScreenEvent());
    }
}