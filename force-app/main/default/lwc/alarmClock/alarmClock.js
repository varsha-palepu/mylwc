import { LightningElement } from 'lwc';
import AlarmClockAssets from "@salesforce/resourceUrl/AlarmClockAssets"
export default class AlarmClock extends LightningElement {
    clockimg = AlarmClockAssets + "/AlarmClockAssets/clock.png";
    ringtone = new Audio(AlarmClockAssets +"/AlarmClockAssets/Clocksound.mp3")
    currenttime="";
    hours=[];
    minutes=[];
    meridians=["AM","PM"];
    hoursselected
    minutesselected
    meridiansselected
    alarmvalue
    alarmset=false;
    alarmtriggered=false;
    get isfieldnotselected(){
        return !(this.hoursselected && this.minutesselected && this.meridiansselected)
    }
    get shakeimage(){
       return this.alarmtriggered ? "shake" : "";
    }
    connectedCallback(){
        this.createHoursoption();
        this.createMinutesoption();
        this.currenttimeHandler();
    }
    currenttimeHandler(){
        setInterval(()=>{
            let datetime = new Date();
            let hour = datetime.getHours();
            let min = datetime.getMinutes();
            let sec = datetime.getSeconds();
            let ampm= "AM";     
            if (hour === 0) {
              hour = 12;
              ampm = "AM";
            } 
            else if (hour === 12) {
                ampm = "PM";
             } 
             else if (hour >= 12) {
                hour = hour - 12;
                ampm = "PM";
             }
            hour = hour < 10 ? "0"+hour :hour;
            min = min <10 ? "0"+ min :min;
            sec = sec <10 ? "0" +sec :sec;
            this.currenttime=`${hour}:${min}:${sec} ${ampm}`;
            if(this.alarmvalue === `${hour}:${min} ${ampm}`){
                console.log("Alarm triggered")
                this.alarmtriggered=true;
                this.ringtone.play();
                this.ringtone.loop =true;
            }
        },1000);
       
    }
    createHoursoption(){
        for(let i=1; i<=12;i++){
            let val = i<10 ? "0"+i : i;
            this.hours.push(val);
        }
    }
    createMinutesoption(){
        for(let i=0; i<59;i++){
            let val = i<10 ? "0"+i : i;
            this.minutes.push(val);
        }
    }
    optionHandler(event){
        const{label,value}=event.detail;
        if(label === "Hour(s)"){
            this.hoursselected=value;
        }
        else if(label === "Minute(s)"){
            this.minutesselected=value;
        }
        else if(label === "AM/PM"){
            this.meridiansselected=value;
        }else{

        }
    //     console.log("this.hoursselected",this.hoursselected);
    //     console.log("this.minutesselected",this.minutesselected);
    //     console.log("this.meridiansselected",this.meridiansselected);
    }
    setalarmhandler(){
        this.alarmvalue=`${this.hoursselected}:${this.minutesselected} ${this.meridiansselected}`;
        this.alarmset = true;
    }
    clearalarmhandler(){
        this.alarmvalue="";
        this.alarmset = false;
        this.alarmtriggered=false;
        this.ringtone.pause();
        const elements=this.template.querySelectorAll("c-clock-drop-down");
        Array.from(elements).forEach(element=>{
            element.reset("");
        });

    }
}