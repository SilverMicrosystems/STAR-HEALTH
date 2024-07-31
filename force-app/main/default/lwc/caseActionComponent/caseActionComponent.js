import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import CASE_STATUS_FIELD from '@salesforce/schema/Case.Status';
import CASE_DESCRIPTION_FIELD from '@salesforce/schema/Case.Description';
import CASE_ID_FIELD from '@salesforce/schema/Case.Id';

const fields = [CASE_ID_FIELD, CASE_STATUS_FIELD, CASE_DESCRIPTION_FIELD];

export default class CaseActionComponent extends LightningElement {
    @api recordId;
    @track case;
    @track description = '';
    @track isReopenVisible = false;
    @track isEscalateVisible = false;
    @track isDescriptionVisible = false;

    @wire(getRecord, { recordId: '$recordId', fields })
    wiredCase({ error, data }) {
        if (data) {
            this.case = data;
            const statusValue = this.case.fields.Status.value;
            this.isReopenVisible = statusValue === 'Escalated';
            this.isEscalateVisible = statusValue === 'Working';
            this.isDescriptionVisible = statusValue === 'Working'; // Show description only when status is Working
            this.description = this.case.fields.Description.value || '';
        } else if (error) {
            console.error('Error loading case', error.body.message);
        }
    }

    handleEscalate() {
        this.updateCaseStatus('Escalated');
    }

    handleReopen() {
        this.updateCaseStatus('New');
    }

    handleDescriptionChange(event) {
        this.description = event.target.value; // Update description with event target value
        // Immediately update the description field on change
        this.updateCaseDescription();
    }

    updateCaseStatus(status) {
        const fields = {};
        fields[CASE_ID_FIELD.fieldApiName] = this.recordId;
        fields[CASE_STATUS_FIELD.fieldApiName] = status;

        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                if (status === 'New') {
                    this.isReopenVisible = true; // Show "Reopen Case" after changing from "Escalated"
                } else if (status === 'Escalated') {
                    this.isReopenVisible = false; // Hide "Reopen Case" when escalating
                }
                return refreshApex(this.case);
            })
            .catch(error => {
                console.error('Error updating case status', error.body.message);
            });
    }

    updateCaseDescription() {
        const fields = {};
        fields[CASE_ID_FIELD.fieldApiName] = this.recordId;
        fields[CASE_DESCRIPTION_FIELD.fieldApiName] = this.description;

        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                // Optionally refresh apex if needed
                // return refreshApex(this.case);
            })
            .catch(error => {
                console.error('Error updating case description', error.body.message);
            });
    }
}