import { LightningElement,api } from 'lwc';
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import ACCOUNT_INDUSTRY from "@salesforce/schema/Account.Industry";
import ACCOUNT_RATING from "@salesforce/schema/Account.Rating";
import ACCOUNT_REVENUE from "@salesforce/schema/Account.AnnualRevenue";
import { NavigationMixin } from 'lightning/navigation';
export default class RecordFormDemo extends NavigationMixin(LightningElement) {
    @api recordId;
    @api objectApiName;
    fieldsList=[ACCOUNT_NAME,ACCOUNT_INDUSTRY,ACCOUNT_RATING,ACCOUNT_REVENUE];
    navigatetorecordpage(event){
        let pageref={
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: this.objectApiName,
                actionName: 'view'
            }
    }
    this[NavigationMixin.Navigate](pageref);
    }
}