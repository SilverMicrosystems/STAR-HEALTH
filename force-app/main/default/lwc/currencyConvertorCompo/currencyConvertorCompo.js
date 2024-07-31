import { LightningElement,track } from 'lwc';
import getConvertedAmount from '@salesforce/apex/INRToUSDRequestApI.getConvertedAmount'; 
export default class CurrencyConvertorCompo extends LightningElement {
    @track baseCurrency = 'USD';
    @track targetCurrency = 'INR';
    @track amount = 0;
    @track convertedAmount = 0;

    get currencyOptions() {
        return [
            { label: 'USD', value: 'USD' },
            { label: 'INR', value: 'INR' }
        ];
    }

    handleBaseCurrencyChange(event) {
        this.baseCurrency = event.target.value;
        this.convertCurrency();
    }

    handleAmountChange(event) {
        this.amount = event.target.value;
        this.convertCurrency();
    }

    handleTargetCurrencyChange(event) {
        this.targetCurrency = event.target.value;
        this.convertCurrency();
    }

    convertCurrency() {
        if (this.amount && this.baseCurrency && this.targetCurrency) {
            getConvertedAmount({ currencyFrom: this.baseCurrency, currencyTo: this.targetCurrency, amount: parseFloat(this.amount) })
                .then(result => {
                    this.convertedAmount = result;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    }
}