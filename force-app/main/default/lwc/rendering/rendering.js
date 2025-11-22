import { LightningElement } from 'lwc';

export default class Rendering extends LightningElement {
    displayMessage= false;
    changeHandler(event){
        this.displayMessage=!this.displayMessage;
    }
}