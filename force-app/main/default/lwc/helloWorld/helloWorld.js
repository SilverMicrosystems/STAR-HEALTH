import { LightningElement,track } from 'lwc';


export default class HelloWorld extends LightningElement {

   @track objAcc = {'sObjectType' : 'Account'} //By Default Non-Reactive --> reactive

    nameHandler(event){
        this.objAcc.Name = event.target.value;
        console.log(this.objAcc.Name);
    }


    sendDataHandler(){

        //Use Custom Event

        this.dispatchEvent(new CustomEvent('eventname', {
            detail: {
                message: this.objAcc
            }
        }));



    }
}