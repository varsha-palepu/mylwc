import { LightningElement,api } from 'lwc';

export default class ContactItem extends LightningElement {
    @api contact;
    clickHandler(event){
        event.preventdefault();
        const selectionlist = new CustomEvent('selection',{
            detail: this.contact.Id
        });
        this.dispatchEvent(selectionlist);
    }
}