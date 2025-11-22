import { LightningElement,api,track } from 'lwc';

export default class ObjectsforFlow extends LightningElement {
    @track _contacts=[];
    set contacts(contacts=[]){
        this._contacts=[...contacts]
    }
    @api
    get contacts(){
        return this._contacts;
    }
    get items(){
        let contactemaillist = this._contacts.map((curritem) =>{
            return{
               
                    type: 'icon',
                    label: curritem.Email,
                    name: curritem.Email,
                    iconName: 'standard:contact',
                    alternativeText: 'Contact',
                
            };
        });
        return contactemaillist;
    }
}