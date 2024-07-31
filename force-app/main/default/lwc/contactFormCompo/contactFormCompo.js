import { LightningElement, api,track } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import CONTACT_FIRSTNAME from '@salesforce/schema/Contact.FirstName';
import CONTACT_LASTNAME from '@salesforce/schema/Contact.LastName';
import CONTACT_MOBILENUMBER from '@salesforce/schema/Contact.MobilePhone';
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email';
import sendVeriphoneIntegration from '@salesforce/apex/veriphoneIntegration.sendVeriphoneIntegration';

export default class ContactFormCompo extends LightningElement {
    objCon = {'sObject' : 'Contact'};

    @api recordId;
    validFlag = false;
    

    // Schema imports
    contactObject = CONTACT_OBJECT;
    firstName = CONTACT_FIRSTNAME;
    lastName = CONTACT_LASTNAME;
    mobileNumber = CONTACT_MOBILENUMBER;
    email = CONTACT_EMAIL;

    firstNameHandler(event){
        this.objCon.FirstName = event.target.value;
        console.log('Inside of First Name='+ this.objCon.firstName);
    }
    lastNameHandler(event){
        this.objCon.LastName = event.target.value;
        console.log('Inside of Last Name='+ this.objCon.LastName);  
    }
    mobileNumberHandler(event){
        this.objCon.MobileNumber = event.target.value;
        console.log('Inside of Mobile Number='+this.objCon.MobileNumber);

    }
    emailIdHandler(event){
        this.objCon.Email = event.target.value;
        console.log('Inside of Email='+this.objCon.Email);
    }
    mobileVerificationHandler(){
       
        //Calling Apex Controller Method

        sendVeriphoneIntegration({'objCon' : this.objCon})
        .then(success=>{
            console.log('Success '+JSON.stringify(success));
            


            if(success == true){
                this.validFlag = true;
            }
            else{
                this.validFlag = false;
            }

         
        })
        .catch(error=>{
            console.log('error '+JSON.stringify(error));
            
        })
    }
}