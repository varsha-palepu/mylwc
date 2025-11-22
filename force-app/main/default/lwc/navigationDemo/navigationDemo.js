import { LightningElement } from 'lwc';
import{NavigationMixin} from "lightning/navigation"
export default class NavigationDemo extends NavigationMixin(LightningElement) {
    handleClick(){
        let pageref={
            type: 'standard__namedPage',
            attributes: {
                pageName: 'home'
            }
        };
        this[NavigationMixin.NavigationDemo](pageref);
    }
    handleClick1(){
        let pagref1={
            
    type: 'standard__webPage',
    attributes: {
        url: 'http://salesforce.com'
    }

        };
        this[NavigationMixin.NavigationDemo](pageref1);
    }
}