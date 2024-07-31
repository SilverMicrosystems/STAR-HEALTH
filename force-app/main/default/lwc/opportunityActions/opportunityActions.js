import { LightningElement, api } from 'lwc';
import approveOpportunity from '@salesforce/apex/OpportunityController.approveOpportunity';
import rejectOpportunity from '@salesforce/apex/OpportunityController.rejectOpportunity';

export default class OpportunityActions extends LightningElement {
    @api opportunityId;

    handleApprove() {
        approveOpportunity({ opportunityId: this.opportunityId })
            .then(() => {
                this.notifySibling();
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleReject() {
        rejectOpportunity({ opportunityId: this.opportunityId })
            .then(() => {
                this.notifySibling();
            })
            .catch(error => {
                console.error(error);
            });
    }

    notifySibling() {
        const siblingEvent = new CustomEvent('siblingnotification');
        this.dispatchEvent(siblingEvent);
    }
}