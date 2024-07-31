import { LightningElement, track } from 'lwc';
import getOpportunities from '@salesforce/apex/OpportunityController.getOpportunities';

export default class OpportunityList extends LightningElement {
    @track opportunities;
    @track selectedOpportunityId;
    columns = [
        { label: 'Opportunity Name', fieldName: 'Name' },
        { label: 'Amount', fieldName: 'Amount' },
        { type: 'button', typeAttributes: { label: 'View Details', name: 'view_details' } }
    ];

    connectedCallback() {
        this.loadOpportunities();
    }

    loadOpportunities() {
        getOpportunities()
            .then(result => {
                this.opportunities = result;
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        if (actionName === 'view_details') {
            this.selectedOpportunityId = row.Id;
        }
    }

    handleOpportunityUpdated(event) {
        // Handle the update from the child component
        this.loadOpportunities();
    }

    handleSiblingNotification(event) {
        // Handle sibling notification
        this.template.querySelector('c-opportunity-details').refreshDetails();
    }
}