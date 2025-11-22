import { LightningElement,wire } from 'lwc';
import getParentAccountdetails from '@salesforce/apex/AccountHelper.getParentAccountdetails';
export default class AccountDetails extends LightningElement {
    Parentaccount=[];
    Selecparentacc='';
    selaccname='';
    @wire(getParentAccountdetails) wired_parentaccount({data,error}){
        this.Parentaccount=[];
        if(data){
            this.Parentaccount=data.map((curritem)=>({
                label: curritem.Name, 
                value: curritem.Id,
            }));
        }else if(error){
            console.log('Error while fetching the parent Account');
        }
    }
    handleChange(event){
        let{name,value}=event.target;
        if(name=== 'parentacc'){
            this.Selecparentacc= value;
        }
        if(name === 'accname'){
            this.selaccname = value;
        }
    }
}