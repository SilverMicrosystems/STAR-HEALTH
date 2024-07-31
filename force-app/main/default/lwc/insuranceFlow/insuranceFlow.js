import { LightningElement, track } from 'lwc';

export default class InsuranceFlow extends LightningElement {
    @track step = 1;
    @track selectedInsuranceType = '';
    @track selectedMake = ['ds','sdsdsdsd'];
    @track selectedModel = '';
    @track twoWheelerName = '';

    get isStep1() {
        return this.step === 1;
    }

    get isStep2CarInsurance() {
        return this.step === 2 && this.selectedInsuranceType === 'Car Insurance';
    }

    get isStep2TwoWheelerInsurance() {
        return this.step === 2 && this.selectedInsuranceType === 'Two Wheeler Insurance';
    }

    get isStepGreaterThan1() {
        return this.step > 1;
    }

    handleInsuranceTypeChange(event) {
        this.selectedInsuranceType = event.target.value;
    }

    handleMakeChange(event) {
        this.selectedMake = event.target.value;
    }

    handleModelChange(event) {
        this.selectedModel = event.target.value;
    }

    handleTwoWheelerNameChange(event) {
        this.twoWheelerName = event.target.value;
    }

    handleNextClick() {
        this.step++;
    }
}