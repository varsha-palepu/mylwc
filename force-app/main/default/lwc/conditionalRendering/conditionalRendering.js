import { LightningElement } from 'lwc';

export default class ConditionalRendering extends LightningElement {
    displayMessage = false;
    changehandler(event){
        this.displayMessage = !this.displayMessage;
    }
}