import { LightningElement, api, wire } from 'lwc';
import getLineItemsByTransaction from '@salesforce/apex/LineItemsOfTransactionController.getLineItemsByTransaction';
/*import NAME from '@salesforce/schema/Line_Item__c.Name';
import Product from '@salesforce/schema/Line_Item__c.Product__r.Name';
import Quantity from '@salesforce/schema/Line_Item__c.Quantity__c';
import Amount from '@salesforce/schema/Line_Item__c.Amount__c';*/


export default class LineItemsOfTransaction extends LightningElement {
    @api recordId;
    columns = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Product and code', fieldName: 'Product_Name_With_Code__c', type: 'text' },
        { label: 'Quantity', fieldName:'Quantity__c', type: 'integer' },
        { label: 'Amount', fieldName: 'Amount__c', type: 'currency' },
    ];
    lineItems = [];
    
    
    async connectedCallback(){
        getLineItemsByTransaction({transactionId: this.recordId})
        .then((result) => {
            this.lineItems = result;
        }).catch((err) => {
            
        });
       
    }
}