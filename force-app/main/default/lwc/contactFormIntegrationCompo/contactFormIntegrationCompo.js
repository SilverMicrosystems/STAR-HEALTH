import { LightningElement } from 'lwc';
import Contact_OBJECT from '@salesforce/schema/Contact';
import CONTACT_FIRSTNAME from '@salesforce/schema/Contact.FirstName';
import CONTACT_LASTNAME from '@salesforce/schema/Contact.LastName';
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email';
import SendEmailIntegrationContact from '@salesforce/apex/contactEmailVerificationRequestAPI.sendEmailIntegrationContact';
export default class ContactFormIntegrationCompo extends LightningElement {

    validFlag=false;
    objCon = {'sObject': 'Contact'};
    objectContact = Contact_OBJECT;
    firstName     = CONTACT_FIRSTNAME;
    lastName      = CONTACT_LASTNAME;
    email         = CONTACT_EMAIL;


    firstNameHandler(event){
        this.objCon.FirstName = event.target.value;
        console.log('Inside of First Name='+ this.objCon.FirstName);  
    }
    lastNameHandler(event){
        this.objCon.LastName = event.target.value;
        console.log('Inside of Last Name='+ this.objCon.LastName);  
    }
    emailHandler(event){
        this.objCon.Email = event.target.value;
        console.log('Inside of Email='+this.objCon.Email);
    }
    emailVerificationHandler(){
        SendEmailIntegrationContact({objCon : this.objCon})
        .then(success=>{
            console.log('Success '+JSON.stringify(success));
            
            if(success == 'DELIVERABLE'){
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