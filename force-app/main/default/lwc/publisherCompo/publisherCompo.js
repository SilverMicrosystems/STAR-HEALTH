import { LightningElement, track, wire } from 'lwc';
import MYCHANNEL from "@salesforce/messageChannel/AccountDataChannel__c";
import {publish, MessageContext} from "lightning/messageService"



export default class PublisherCompo extends LightningElement {
    @wire(MessageContext)
    context


    @track objAcc = {'sObjectType' : 'Account'};
    myName = 'Silver Microsystems';


    nameHandler(event){
        this.objAcc.Name = event.target.value; //Cinemax
        console.log(this.objAcc.Name);
    }

    sendDataHandler(){
        console.log('You clicked Button');
      
        //Send Data to LMS
        const message={
            accountObject:{
                value:this.objAcc
            },

            myNameLms :{
                value: this.myName
            }

         }
    
         publish(this.context, MYCHANNEL, message);

    }

}