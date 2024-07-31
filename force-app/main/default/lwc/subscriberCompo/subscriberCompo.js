import { LightningElement, track, wire } from 'lwc';
import MYCHANNEL from "@salesforce/messageChannel/AccountDataChannel__c";
import {subscribe, MessageContext,APPLICATION_SCOPE} from "lightning/messageService"


export default class SubscriberCompo extends LightningElement {
   @track objAcc = {'sObjectType' : 'Account'};
   receivedName;

   @wire(MessageContext)
   context    

connectedCallback(){
   subscribe(this.context, MYCHANNEL, (message)=>{this.handleMessage(message)}, {scope : APPLICATION_SCOPE} )
}


handleMessage(message){
  this.objAcc = message.accountObject.value; //Return Account Object
  console.log('Received '+this.objAcc.Name);

  this.receivedName = message.myNameLms.value; //Return Siver Microsystems
  console.log('Received Name'+ this.receivedName );
}



}