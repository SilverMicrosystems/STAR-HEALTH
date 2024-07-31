import { LightningElement,track } from 'lwc';
import fetchAllRecords from '@salesforce/apex/AccountProvider.fetchAllRecords';

export default class CreateAccountForm extends LightningElement {

    @track objAccountReceived = {'sObjectType' : 'Account'};

    parentMethodHandler(event){
        this.objAccountReceived = event.detail.message; //Return Account Object
        console.log('Zatka Laga '+ this.objAccountReceived.Name);
    }


}