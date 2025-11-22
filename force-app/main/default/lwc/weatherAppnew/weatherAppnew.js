import { LightningElement } from 'lwc';
import getdetails from "@salesforce/apex/WeatherDetails.getdetails";
export default class WeatherApp extends LightningElement {
    temperature='';

    changeHandler(event){
        this.city = event.target.value;
    }
    clickHandler(){
        getdetails({city:this.city}).then(
            (result)=>{
               let weatherdetails = JSON.parse(result);
               console.log("weather details" + JSON.stringify(weatherdetails));
                this.temperature =weatherdetails.timelines.minutely[0].values.temperature;
            }
        )
        .catch((error)=>{
            console.log("error" + JSON.stringify(error));
        })
    }
}