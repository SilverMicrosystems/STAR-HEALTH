// consumerDurableLoan.js
import { LightningElement, api } from 'lwc';

export default class ConsumerDurableLoan extends LightningElement {
    @api cases;

    draftValues=[];
columns = [
  { label: 'Case Number', fieldName: 'CaseNumber', editable: true },
  { label: 'Priority', fieldName: 'Priority', editable: true },
  { label: 'Status', fieldName: 'Status', editable: true }
];



}