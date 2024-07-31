import { LightningElement, api, track } from 'lwc';
import getOpportunity from '@salesforce/apex/OpportunityController.getOpportunity';
import updateOpportunity from '@salesforce/apex/OpportunityController.updateOpportunity';

export default class OpportunityDetails extends LightningElement {
    @api opportunityId;
    @track opportunity = {};

    connectedCallback() {
        this.loadOpportunityDetails();
    }

    @api
    refreshDetails() {
        this.loadOpportunityDetails();
    }

    loadOpportunityDetails() {
        getOpportunity({ opportunityId: this.opportunityId })
            .then(result => {
                this.opportunity = result;
            })
            .catch(error => {
                console.error(error);
            });
    }

 

    handleInputChange(event) {
        console.log('Field Event '+event);
        const field = event.target.label;
        this.opportunity[field] = event.target.value;
    }

    handleSave() {
        updateOpportunity({ opportunity: this.opportunity })
            .then(() => {
                // Notify parent component of the update
                const updateEvent = new CustomEvent('opportunityupdated');
                this.dispatchEvent(updateEvent);
            })
            .catch(error => {
                console.error(error);
            });
    }
}