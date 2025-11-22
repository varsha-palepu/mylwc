import { LightningElement } from 'lwc';
import{countryCodeList} from "c/countryCodeList";
import currencyConverterAssets from "@salesforce/resourceUrl/currencyConverterAssets"
export default class CurrencyConvertorApp extends LightningElement {
    currencyimg= currencyConverterAssets + ("/currencyConverterAssets/currency.svg");
    countryList = countryCodeList;
    Currencyfrom ="USD";
    CurrencyTo = "AUD";
    amount='';
    result
    error
    handleChange(event){
        const {name,value} = event.target;
        console.log("name", name);
        console.log("value", value);
        this[name] = value;
        this.result="";
        this.error="";
    }
    sumbithandler(event){
        event.preventDefault();
        this.convert();
    }
     async convert(){
            // const API_URL = `https://api.exchangerate.host/convert?access_key=${AUTH_KEY}&from=${this.countryFrom}&to=${this.countryTo}`
            const API_KEY = '8d2d2edd3a2c0aa40298d659';
            const API_URL = `https://v6.exchangerate-api.com/v6/${API_KEY}/pair/${this.Currencyfrom}/${this.CurrencyTo}`;
            try{
              const data = await fetch(API_URL);
              const jsonData = await data.json();
              
              debugger;
              // this.result = (Number(this.amount) * jsonData.result).toFixed(2)
              this.result = (Number(this.amount) * jsonData.conversion_rate).toFixed(2);
              console.log(this.result);
            } catch(error){
              console.log(error);
              this.error="An error occurred. Please try again...";
            }
          }

}