import { LightningElement, wire } from 'lwc';
import getAccountsWithContactsAndOpportunities from '@salesforce/apex/AccountProvider.getAccountsWithContactsAndOpportunities';

const columns = [
    { label: 'Account Name', fieldName: 'Name', type: 'text' },
    { label: 'Contact Name', fieldName: 'Contacts', type: 'text',
        typeAttributes: { fieldName: 'Name' } 
    },
    { label: 'Contact Email', fieldName: 'Contacts', type: 'email',
        typeAttributes: { fieldName: 'Email' } 
    },
    { label: 'Opportunity Name', fieldName: 'Opportunities', type: 'text',
        typeAttributes: { fieldName: 'Name' } 
    },
    { label: 'Stage', fieldName: 'Opportunities', type: 'text',
        typeAttributes: { fieldName: 'StageName' } 
    },
    { label: 'Close Date', fieldName: 'Opportunities', type: 'date',
        typeAttributes: { fieldName: 'CloseDate' } 
    }
];



export default class GrandParent extends LightningElement {
    accounts = [];
    columns = columns;

    @wire(getAccountsWithContactsAndOpportunities)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data.map(account => ({
                ...account,
                Contacts: account.Contacts ? account.Contacts.map(contact => contact) : [],
                Opportunities: account.Opportunities ? account.Opportunities.map(opportunity => opportunity) : []
            }));
        } else if (error) {
            console.error('Error fetching account data: ', error);
        }
    }
}