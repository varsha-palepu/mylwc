import { LightningElement , wire} from 'lwc';
import getContactList from '@salesforce/apex/contactController.getContactList';
export default class ContactList extends LightningElement {
    @wire(getContactList) contacts;
    selectedcontact;
    selectedHandler(event){
        let selectedId = event.detail;
        this.selectedcontact = this.contacts.data.find((curitem) => curitem.Id === selectedId);
    }
}