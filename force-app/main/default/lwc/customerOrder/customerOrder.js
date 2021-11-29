import { LightningElement } from 'lwc';
import createTransaction from '@salesforce/apex/CustomerOrderController.createTransaction';
import { lineItem } from './lineItem';

export default class CustomerOrder extends LightningElement {
    customerId;
    productId;
    quantity;
    paymentType;
    itemsAmount = 0;
    items = [];
    value = 'Cash';
    result;
    

    columns = [
        { label:'Product ID', fieldName:'productID',type: 'text'},
        { label:'Quantity', fieldName:'quantity',type: 'integer'},
    ];
    get options() {
        return [
            { label: 'Visa', value: 'Visa' },
            { label: 'Mastercard', value: 'Mastercard' },
            { label: 'Cash', value: 'Cash' },
        ];
    }

    
    handleClickAdd(){
        
        let item = [];
        item.push(new lineItem(this.quantity, this.productId));
        this.items = this.items.concat(item[0]);

    }
    handleClickMake(){
        if(this.items.length > 0){
            createTransaction({
                order: JSON.stringify(this.items),
                paymentType : this.paymentType,
                customerID: this.customerId,
            });
            this.items = [];
        }   
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
    handleChangePaymentType(event) {
        this.paymentType = event.detail.value;
    }
    
}