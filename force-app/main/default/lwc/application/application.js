import { LightningElement } from 'lwc';

export default class Application extends LightningElement {
    taskname="";
    taskdate=null;
    incomplete=[];
    complete=[];
    changeHandler(event){
        let{name,value}=event.target;
        if(name==="taskname"){
            this.taskname = value;
        }
        if(name==="taskdate"){
            this.taskdate = value;
        }
    }
    resetHandler(){
        this.taskname="";
        this.taskdate=null;
    }
    AddHandler(){
        if(!this.taskdate){
            this.taskdate = new Date().toISOString().slice(0,10);
        } 
        if(this.validateTask()){
            this.incomplete = [...this.incomplete,{
                taskname : this.taskname,
                taskdate : this.taskdate,
            }];
            this.resetHandler();
            let sortedArray=this.sortedArray(this.incomplete);
            this.incomplete = [...sortedArray];
            console.log("this.incomplete ", this.incomplete);
        }
    }
    validateTask(){
        let isValid = true;
        let element = this.template.querySelector(".taskname");
        if(!this.taskname){
            isValid = false;
        }
        else{
            let taskitem=this.incomplete.find((curitem) => 
                curitem.taskname === this.taskname &&
                curitem.taskdate === this.taskdate
            );
        if(taskitem){
            isValid = false;
            element.setCustomValidity("Task is already available");
        }
    }
        if(isValid){
            element.setCustomValidity("");
        }
        element.reportValidity();
        return isValid;
    }
    sorttask(inputArr){
       let sortedArray= inputArr.sort((a,b) =>{
            const dateA = new Date(a.taskdate);
            const dateB = new Date(b.taskdate);
            return dateA - dateB;
        });
        return sortedArray;
    }
    removalHandler(event){
        let index = event.target.name;
        this.incomplete.splice(index,1);
        let sortedArray=this.sortedArray(this.incomplete);
        this.incomplete = [...sortedArray];
        console.log("this.incomplete ", this.incomplete);
    }
    completetaskHandler(event){
        let index = event.target.name;
        this.refreshdata(index);
    }
    dragstartHandler(event){
        event.dataTransfer.setdata("index", event.target.dataset.item);
    }
    allowdrop(event){
        event.preventDefault();
    }
    dropelementHandler(event){
        let index=event.dataTransfer.getData("index");
        this.refreshdata(index);
    }
    refreshdata(index){
        let removedtask=this.incomplete.splice(index,1);
        let sortedArray=this.sortedArray(this.incomplete);
        this.incomplete = [...sortedArray];
        console.log("this.incomplete ", this.incomplete);
        this.complete=[...this.complete, removedtask[0]];
    }
}