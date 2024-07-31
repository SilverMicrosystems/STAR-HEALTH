import { LightningElement, track, wire, api } from 'lwc';
import MYCONTACTCHANNEL from "@salesforce/messageChannel/ContactDataChannel__c";
import {subscribe, MessageContext,APPLICATION_SCOPE} from "lightning/messageService"


export default class RelatedContactsCompo extends LightningElement {
 @api conChildList;

   columns = [
    { label: 'First Name', fieldName: 'FirstName', editable: true },
    { label: 'Last Name', fieldName: 'LastName', editable: true }
  ];

  closeButtonHandler(){
    this.dispatchEvent(new CustomEvent('eventdisplayrelatedcontact', {
        detail: {
            message: false
        }
    }));

  }

      
      constructor(){
            super();
             console.log('From Constructor');
         }
        
         connectedCallback(){
            console.log('From connectedCallback');
            
         }
        
         renderedCallback(){
            console.log('From renderedCallback');
            throw new Error('Whoops!');
         }
        
         disconnectedCallback(){
            console.log('From disconnectedCallback');
            alert('Oye');
         }

      //    errorCallback(){
      //     console.log('From errorCallback');
      //  }
      
        
        


}