import { LightningElement } from 'lwc';
const API_KEY="8c575c1c7a3b00130e36f47bcfdf90d1";
import weatherAppIcons from "@salesforce/resourceUrl/weatherAppIcons";
export default class WeatherApp extends LightningElement {
    clearIcon= weatherAppIcons + "/weatherAppIcons/clear.svg";
    cloudIcon= weatherAppIcons + "/weatherAppIcons/cloud.svg";
    dropletIcon= weatherAppIcons + "/weatherAppIcons/droplet.svg";
    hazeIcon= weatherAppIcons + "/weatherAppIcons/haze.svg";
    mapIcon= weatherAppIcons + "/weatherAppIcons/map.svg";
    rainIcon= weatherAppIcons + "/weatherAppIcons/rain.svg";
    snowIcon= weatherAppIcons + "/weatherAppIcons/snow.svg";
    thermometerIcon= weatherAppIcons + "/weatherAppIcons/thermometer.svg";
    stormIcon= weatherAppIcons + "/weatherAppIcons/storm.svg";
    arrowbackIcon= weatherAppIcons + "/weatherAppIcons/arrow-back.svg";
    cityName="";
    loadingtext='';
    iserror=false;
    response;
    weatherIcon;
    get loadingclass(){
        return this.iserror ? "error-msg":"success-msg";
    }
    searchHandler(event){
        this.cityName=event.target.value;
    }
    submitHandler(event){
        event.preventDefault();
        this.fetchdata();
    }
    fetchdata(){
        this.loadingtext = "Fetching the details..";
        this.iserror=false;
        console.log("cityName" , this.cityName);
        const API_URL=`https://api.openweathermap.org/data/2.5/weather?q=${this.cityName}&appid=${API_KEY}`;
        fetch(API_URL).then(result=>result.json()).then(res=>{
            console.log(JSON.stringify(res));
            this.weatherdetails(res);
        }).catch((error)=>{
            console.error(error);
            this.loadingtext="Something went wrong";
            this.iserror=true;
        });
    }
    weatherdetails(info){
        if(info.cod === "404"){
            this.iserror = true;
            this.loadingtext=`${this.cityName} isn't a valid city`;
        }else{
            this.loadingtext="";
            this.iserror= false;
            const city=info.name;
            const country=info.sys.country;
            const{description,id}=info.weather[0];
            const{temp,feels_like,humidity}=info.main;
            if(id===800){
                this.weatherIcon=this.clearIcon;
            }else if((id>=200 && id<=232) || (id>=600 && id<=622)){
                this.weatherIcon=this.stormIcon;
            }else if((id>=300 && id<=321) || (id>=500 && id<=531)){
                this.weatherIcon=this.rainIcon;
            }else if(id>=701 && id<= 781){
                this.weatherIcon=this.hazeIcon;
            }else if(id>=801 && id<= 804){
                this.weatherIcon=this.cloudIcon;
            }else{}

            this.response={
                city:city,
                temperature:Math.floor(temp),
                description:description,
                location:`${city}, ${country}`,
                feels_like:Math.floor(feels_like),
                humidity:`${humidity}%`
            }
        }
    }
    backhandler(){
        this.response=null;
        this.cityName='';
        this.loadingtext="";
        this.iserror=false;
        this.weatherIcon='';

    }
}