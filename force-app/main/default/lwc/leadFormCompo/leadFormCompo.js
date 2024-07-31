import { LightningElement } from 'lwc';
import LEAD_OBJECT from '@salesforce/schema/Lead';
import LEAD_FIRSTNAME from '@salesforce/schema/Lead.FirstName';
import LEAD_LASTNAME from '@salesforce/schema/Lead.LastName';
import LEAD_EMAIL from '@salesforce/schema/Lead.Email';
import LEAD_COMPANY from '@salesforce/schema/Lead.Company';
import LEAD_STATUS from '@salesforce/schema/Lead.Status';
import sendEmailIntegration from '@salesforce/apex/EmailVerificationRequestAPI.sendEmailIntegration';
export default class LeadFormCompo extends LightningElement {

    objLead = {'sObject' : 'Lead'};
    leadObject = LEAD_OBJECT;
    firstName = LEAD_FIRSTNAME;
    lastName = LEAD_LASTNAME;
    email = LEAD_EMAIL;
    company = LEAD_COMPANY;
    leadStatus = LEAD_STATUS;
    validFlag = false;

    firstNameHandler(event){
        this.objLead.FirstName = event.target.value;
        console.log('Inside of First Name='+ this.objLead.LastName);  
    }
    lastNameHandler(event){
        this.objLead.LastName = event.target.value;
        console.log('Inside of Last Name='+ this.objLead.LastName);  
    }
    emailHandler(event){
        this.objLead.Email = event.target.value;
        console.log('Inside of Email='+ this.objLead.Email);  
    }

    companyHandler(event){
        this.objLead.Company = event.target.value;
        console.log('Inside of Company Name='+ this.objLead.Company);
    }
    statusHandler(event){
        this.objLead.Status = event.target.value;
        console.log('Inside of Status='+ this.objLead.Status);
    }

    emailVerificationHandler(){
        sendEmailIntegration({objLead : this.objLead})
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