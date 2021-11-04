import { LightningElement, api, wire } from 'lwc';
import getProductsByName from '@salesforce/apex/ProductController.getProductsByName';

export default class ProductsSearch extends LightningElement {
    productName;
    columns = [
        { label: 'ID', fieldName: 'Id', type: 'text' },
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Available Amount', fieldName: 'Available_Amount__c', type: 'integer' },
        { label: 'Price', fieldName: 'Price__c', type: 'integer'}
    ];
    products = [];
    handleInputChange(event){
        this.productName = event.detail.value;
        getProductsByName({productName:('%' + this.productName + '%')})
        .then( result=> {
            this.products = result;
        });
    }
    

}