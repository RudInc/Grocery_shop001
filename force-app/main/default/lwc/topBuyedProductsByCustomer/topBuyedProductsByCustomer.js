import { LightningElement, api } from 'lwc';
import getTopProductsOfCustomer from '@salesforce/apex/ProductController.getTopProductsOfCustomer';

export default class TopBuyedProductsByCustomer extends LightningElement {
    @api recordId
    topProducts = [];
    columns = [
        { label: 'Product', fieldName: 'Name', type: 'text' },
        { label: 'Quantity', fieldName: 'expr0', type: 'integer' }
    ];

    async connectedCallback(){
        getTopProductsOfCustomer({customerID: this.recordId})
        .then(result => {
            this.topProducts = result;
        });
    }
}

