import { LightningElement, track } from 'lwc';
import STATUS_FIELD from '@salesforce/schema/Case.Status';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCases from '@salesforce/apex/CaseController.getCases';
import getCase from '@salesforce/apex/CaseController.getStatus';

export default class CustomersLoan extends LightningElement {
    @track caseNumber = '';
    @track relatedCases = [];
    @track showSpinnerFlag = false;
    @track currentPage = 1;
    @track pageSize = 5;
    casestatus = STATUS_FIELD;
    selectedStatus;
    totalRecords = 0;

    draftValues = [];

    columns = [
        { label: 'Case Number', fieldName: 'CaseNumber', editable: true },
        { label: 'Priority', fieldName: 'Priority', editable: true },
        { label: 'Status', fieldName: 'Status', editable: true }
    ];

    get currentPageData() {
        const startIndex = (this.currentPage - 1) * this.pageSize;
        return this.relatedCases.slice(startIndex, startIndex + this.pageSize);
    }

    get totalPages() {
        return Math.ceil(this.totalRecords / this.pageSize);
    }

    get disableFirst() {
        return this.currentPage === 1;
    }

    get disablePrevious() {
        return this.currentPage <= 1;
    }

    get disableNext() {
        return this.currentPage * this.pageSize >= this.relatedCases.length;
    }

    get disableLast() {
        return this.currentPage * this.pageSize >= this.relatedCases.length;
    }

    connectedCallback() {
        this.showSpinnerFlag = false;
    }

    handleCaseNumberChange(event) {
        this.caseNumber = event.target.value;
    }

    caseStatusHandler(event) {
        this.selectedStatus = event.target.value;

        getCase({ caseStatus: this.selectedStatus })
        .then(result => {
            console.log(JSON.stringify(result));
            this.relatedCases = result;
            this.totalRecords = result.length;
            this.currentPage = 1; // Reset to first page on new data
        })
        .catch(error => {
            console.log(JSON.stringify(error));
            this.relatedCases = [];
            this.totalRecords = 0;
        });
    }

    handleSearchCases() {
        this.showSpinnerFlag = true;
        getCases({ caseNumber: this.caseNumber })
        .then(result => {
            this.relatedCases = result;
            this.showSpinnerFlag = false;
            this.totalRecords = result.length;
            this.currentPage = 1; // Reset to first page on new data
            if (result && result.length > 0) {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Case record found',
                        variant: 'success',
                    })
                );
            } else {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'No Results',
                        message: 'No case records found for the provided case number',
                        variant: 'info',
                    })
                );
            }
        })
        .catch(error => {
            console.error('Error fetching cases:', error);
            this.showSpinnerFlag = false;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Error fetching case records',
                    variant: 'error',
                })
            );
        });
    }

    handleFirstPage() {
        this.currentPage = 1;
    }

    handlePreviousPage() {
        if (this.currentPage > 1) {
            this.currentPage--;
        }
    }

    handleNextPage() {
        if ((this.currentPage * this.pageSize) < this.relatedCases.length) {
            this.currentPage++;
        }
    }

    handleLastPage() {
        this.currentPage = Math.ceil(this.relatedCases.length / this.pageSize);
    }
}