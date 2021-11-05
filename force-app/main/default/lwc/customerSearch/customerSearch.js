import { LightningElement } from 'lwc';
import getCustomerByName from '@salesforce/apex/customerController.getCustomerByName';

export default class CustomerSearch extends LightningElement {
    customerName;
    columns = [
        { label: 'ID', fieldName: 'Id', type: 'text' },
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Bonus', fieldName: 'Bonus__c', type: 'integer' }
    ];
    customers = [];
    handleInputChange(event){
        this.customerName= event.detail.value;
        getCustomerByName({customerName:('%' + this.customerName + '%')})
        .then( result=> {
            this.customers = result;
        });
    }
}
