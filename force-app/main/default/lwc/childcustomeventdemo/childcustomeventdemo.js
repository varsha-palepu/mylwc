import { LightningElement } from 'lwc';

export default class Childcustomeventdemo extends LightningElement {
    clickHandler(){
        let mycustomevent = new CustomEvent("displaymsg");
        this.dispatchEvent(mycustomevent);
    }
}