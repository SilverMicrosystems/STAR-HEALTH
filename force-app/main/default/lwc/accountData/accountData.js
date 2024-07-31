import { LightningElement, track } from 'lwc';
import getAccountsByType from '@salesforce/apex/AccountController.getAccountsByType';

export default class AccountData extends LightningElement {
    @track accountType = '';
    @track accounts;
    @track error;

    columns = [
        { label: 'Account Name', fieldName: 'Name' },
        { label: 'Type', fieldName: 'Type' },
        { label: 'Industry', fieldName: 'Industry' },
        { label: 'Phone', fieldName: 'Phone' }
    ];

    handleInputChange(event) {
        this.accountType = event.target.value;
    }

    fetchAccounts() {
        getAccountsByType({ accountType: this.accountType })
            .then(result => {
                this.accounts = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error.body.message;
                this.accounts = undefined;
            });
    }
}