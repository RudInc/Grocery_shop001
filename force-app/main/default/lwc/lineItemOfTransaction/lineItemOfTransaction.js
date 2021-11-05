import { LightningElement, api } from 'lwc';
import getLineItemsByTransaction from '@salesforce/apex/LineItemsOfTransactionController.getLineItemsByTransaction';
import getLineItemsFromExternalApp from '@salesforce/apex/LineItemsCallouts.getLineItemsFromExternalApp';



export default class LineItemsOfTransaction extends LightningElement {
    @api recordId;
    columns = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Product and code', fieldName: 'Product_Name_With_Code__c', type: 'text' },
        { label: 'Quantity', fieldName:'Quantity__c', type: 'integer' },
        { label: 'Amount', fieldName: 'Amount__c', type: 'currency' },
    ];
    columnsForExternal = [
        { label: 'Name', fieldName: 'productName', type: 'text' },
        { label: 'Product and code', fieldName: 'productCode', type: 'text' },
        { label: 'Quantity', fieldName:'quantity', type: 'integer' },
        { label: 'Amount', fieldName: 'amount', type: 'currency' },
        { label: 'TransactionNumber', fieldName: 'transactionNumber', type: 'integer' },
    ];
    lineItems = [];
    lineItemsFromExternal = [];
    
    
    async connectedCallback(){
        getLineItemsByTransaction({transactionId: this.recordId})
        .then((result) => {
            this.lineItems = result;
        });
        getLineItemsFromExternalApp({link: 'https://avenga-school.herokuapp.com/retrieve-data'})
        .then((result) =>{
            this.lineItemsFromExternal = result;
        });
       
    }
}