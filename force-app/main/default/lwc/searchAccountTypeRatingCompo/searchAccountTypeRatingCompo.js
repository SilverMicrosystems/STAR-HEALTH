import { LightningElement } from 'lwc';
import searchAccountTypeRating from  '@salesforce/apex/AccountController.searchAccountTypeRating';

export default class SearchAccountTypeRatingCompo extends LightningElement {

    objAcc = {'sObjectType' : 'Account'}
    accList;



    columns = [
        { label: 'Account Name', fieldName: 'Name' },
        { label: 'Type', fieldName: 'Type' },
        { label: 'Rating', fieldName: 'Rating' },
        { label: 'Phone', fieldName: 'Phone' }
    ];

    accountTypeHandler(){
        this.objAcc.Type = event.target.value;
        console.log('Inside of accountTypeHandler'+this.objAcc.Type)
    }
    accountRatingHandler(){
        this.objAcc.Rating = event.target.value;
        console.log('Inside of accountRatingHandler '+this.objAcc.Rating);
    }
    fetchAccounts(){
        searchAccountTypeRating({objAcc : this.objAcc})
        .then(result=>{
            console.log(JSON.stringify(result));
            this.accList = result;
        })
        .catch(error=>{
            console.log(JSON.stringify(error));
            this.accList = null;
        })
    }
}