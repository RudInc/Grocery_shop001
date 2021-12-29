import { LightningElement } from 'lwc';

export default class SellerWindow extends LightningElement {
    item;
    customerId = null;

    handleAddItem(event){
        this.item = event.detail;
        this.template.querySelector('c-customer-order').addItemToOrder(this.item);
        
    }
    chooseCustomerHandler(event){
        this.customerId = event.detail;
        console.log(this.customerId);
    }
    
    dismissHandler(){
        this.customerId = null;
       
    }
}