import { LightningElement,api } from 'lwc';
import {FlowAttributeChangeEvent} from 'lightning/flowSupport';
export default class InputforFlow extends LightningElement {
    @api inputname;
    changehandler(event){
        this.inputname = event.target.value;
        const attributeChangeEvent = new FlowAttributeChangeEvent(
            'inputname',
            this.inputname
        );
        this.dispatchEvent(attributeChangeEvent);
    }
}