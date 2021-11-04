import { LightningElement,track } from 'lwc';
import createTransaction from '@salesforce/apex/CustomerOrderController.createTransaction';
import { lineItem } from './lineItem';

export default class CustomerOrder extends LightningElement {
    customerId =1 ;
    productId = 1;
    quantity = 1;
    itemsAmount = 0;
    items =[];
    @track itemsToDisplay ;

    columns = [
        { label:'Product ID', fieldName:'index',type: 'text'},
        { label:'Customer ID', fieldName:'productID',type: 'text'},
        { label:'Quantity', fieldName:'quantity',type: 'integer'},
    ];
    handleClickAdd(){
        //items.push(new lineItem(itemsAmount,productId,quantity));
        this.items.push(new lineItem(this.itemsAmount,this.productId,this.quantity));
        this.itemsToDisplay = this.items;
        this.itemsAmount ++;

    }
    changeProductId(event){
        this.productId = event.detail.value;
    }
    changeCustomerId(event){
        this.customerId = event.detail.value;
    }
    changeQuantity(event){
        this.quantity = event.detail.value;
    }
    
    
}