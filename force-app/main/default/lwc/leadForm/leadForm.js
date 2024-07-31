import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import LEAD_OBJECT from '@salesforce/schema/Lead';
import FIRSTNAME_FIELD from '@salesforce/schema/Lead.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Lead.LastName';
import COMPANY_FIELD from '@salesforce/schema/Lead.Company';
import STATUS_FIELD from '@salesforce/schema/Lead.Status';
import INDUSTRY_FIELD from '@salesforce/schema/Lead.Industry';
import LEADSOURCE_FIELD from '@salesforce/schema/Lead.LeadSource';

export default class LeadForm extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track company = '';
    @track status = '';
    @track industry = '';
    @track leadSource = '';
    @track statusOptions = [];
    @track industryOptions = [];
    @track leadSourceOptions = [];
    @track showIndustryPicklist = false;
    @track showLeadSource = false;
    @track disableIndustry = false;
    @track disableLeadSource = false;



    @wire(getObjectInfo, { objectApiName: LEAD_OBJECT })
    leadMetadata;

    @wire(getPicklistValues, { recordTypeId: '$leadMetadata.data.defaultRecordTypeId', fieldApiName: STATUS_FIELD })
    statusPicklist({ data, error }) {
        if (data) {
            this.statusOptions = data.values;
        } else if (error) {
            this.showToast('Error loading status picklist', error.body.message, 'error');
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$leadMetadata.data.defaultRecordTypeId', fieldApiName: INDUSTRY_FIELD })
    industryPicklist({ data, error }) {
        if (data) {
            this.industryOptions = data.values;
        } else if (error) {
            this.showToast('Error loading industry picklist', error.body.message, 'error');
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$leadMetadata.data.defaultRecordTypeId', fieldApiName: LEADSOURCE_FIELD })
    leadSourcePicklist({ data, error }) {
        if (data) {
            this.leadSourceOptions = data.values;
        } else if (error) {
            this.showToast('Error loading lead source picklist', error.body.message, 'error');
        }
    }

    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field) {
            this[field] = event.target.value;
    
            if (field === 'status') {
                if (this.status === 'Working - Contacted') {
                    this.showIndustryPicklist = true;
                    this.showLeadSource = false;
                    this.industryOptions = [
                        { label: 'Banking', value: 'Banking' },
                        { label: 'Chemicals', value: 'Chemicals' }
                    ];
                    this.industry = '';
                    this.leadSource = '';
                    this.disableIndustry = false;
                    this.disableLeadSource = false;

                } else if (this.status === 'Closed - Converted') {
                    this.showIndustryPicklist = true;
                    this.showLeadSource = false;
                    this.industryOptions = [
                        { label: 'Biotechnology', value: 'Biotechnology' },
                        { label: 'Communications', value: 'Communications' }
                    ];
                    this.industry = '';
                    this.leadSource = '';
                    this.disableIndustry = false;
                    this.disableLeadSource = false;
                    
                } else if (this.status === 'Closed - Not Converted') {
                    this.showIndustryPicklist = true;
                    this.showLeadSource = false;
                    this.industryOptions = [
                        { label: 'Education', value: 'Education' },
                        { label: 'Energy', value: 'Energy' },
                        { label: 'Engineering', value: 'Engineering' }
                    ];
                    this.industry = '';
                    this.leadSource = '';
                    this.disableIndustry = false;
                    this.disableLeadSource = false;
                    
                }else if (this.status === 'Open - Not Contacted') {
                    this.showIndustryPicklist = true;
                    this.showLeadSource = true;
                    this.disableIndustry = true;
                    this.disableLeadSource = true;

                } 
               else {
                    this.showIndustryPicklist = false;
                    this.showLeadSource = false;
                    this.industry = '';
                    this.leadSource = '';
                }
            } else if (field === 'industry') {
                if (this.status === 'Working - Contacted') {
                    if (this.industry === 'Banking') {
                        this.showLeadSource = true;
                        this.leadSource = 'Web';
                    } else if (this.industry === 'Chemicals') {
                        this.leadSource = '';
                    
                    }
                } else if (this.status === 'Closed - Converted') {
                    if (this.industry === 'Communications') {
                        this.showLeadSource = true;
                        this.leadSource = 'Purchased List';
                    } else if (this.industry === 'Biotechnology') {
                        this.leadSource = '';
                        
                    }
                } else if (this.status === 'Closed - Not Converted') {
                    if (this.industry === 'Energy') {
                        this.showLeadSource = true;
                        this.leadSource = 'Partner Referral';
                    } else if (this.industry === 'Engineering') {
                        this.showLeadSource = true;
                        this.leadSource = 'Phone Inquiry';
                    } else if (this.industry === 'Education') {
                        this.leadSource = '';
                       

                    }
                }
            }
        }
    }

    handleCreateLead() {
        const fields = {};
        fields[FIRSTNAME_FIELD.fieldApiName] = this.firstName;
        fields[LASTNAME_FIELD.fieldApiName] = this.lastName;
        fields[COMPANY_FIELD.fieldApiName] = this.company;
        fields[STATUS_FIELD.fieldApiName] = this.status;
        fields[INDUSTRY_FIELD.fieldApiName] = this.industry;
        fields[LEADSOURCE_FIELD.fieldApiName] = this.leadSource;

        const recordInput = { apiName: LEAD_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then((lead) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Lead created successfully',
                        variant: 'success',
                    })
                );
                this.clearForm();
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating lead',
                        message: error.body.message,
                        variant: 'error',
                    })
                );
            });
    }

    clearForm() {
        this.firstName = '';
        this.lastName = '';
        this.company = '';
        this.status = '';
        this.industry = '';
        this.leadSource = '';
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant,
            })
        );
    }
}