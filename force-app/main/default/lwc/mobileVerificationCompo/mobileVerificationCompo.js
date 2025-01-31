import { LightningElement, track, api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import verifiyMobileNumber from '@salesforce/apex/MobileVerificationRequestAPI.verifiyMobileNumber';


export default class MobileVerificationCompo extends LightningElement {
 
  @api recordId; //Returns current record Id
  validFlag = false;

    mobileVerificationHandler(){
       
        //Calling Apex Controller Method

        verifiyMobileNumber({'contactId' : this.recordId})
        .then(success=>{
            console.log('Success '+success);

            if(success == true){
                this.validFlag = true;
            }
            else{
                this.validFlag = false;
            }
           //this.dispatchEvent(new CloseActionScreenEvent()); //To Close the LWC Component Automatically
           // window.location.reload(); //Refresh the Current Page
        })
        .catch(error=>{
            this.dispatchEvent(new CloseActionScreenEvent()); //To Close the LWC Component Automatically
            window.location.reload(); //Refresh the Current Page
        })
    }
}