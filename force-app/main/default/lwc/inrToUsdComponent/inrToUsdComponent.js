import { LightningElement ,track} from 'lwc';
import getConvertedAmount from '@salesforce/apex/INRToUSDConvertApi.getConvertedAmount';
export default class InrToUsdComponent extends LightningElement {
    @track baseCurrency = 'INR';
    @track targetCurrency = 'USD';
    @track amount = 0;
    @track convertedAmount = 0;

    get currencyOptions() {
        return [
            { label: 'INR', value: 'INR' },
            { label: 'USD', value: 'USD' }
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
    convertCurrency(){
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