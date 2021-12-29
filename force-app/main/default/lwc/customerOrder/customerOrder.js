import { LightningElement, api } from 'lwc';
import createTransaction from '@salesforce/apex/CustomerOrderController.createTransaction';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CustomerOrder extends LightningElement {
    @api customerid;
    paymentType;
    items = [];
    value = 'Cash';
    

    columns = [
        { label:'Product ID', fieldName:'productId',type: 'text'},
        { label:'Product Name',fieldName:'productName',type:'text'},
        { label:'Quantity', fieldName:'productQuantity',type: 'integer'},
        { label:'Total Price', fieldName:'productPrice',type: 'currency'}
    ];
    get options() {
        return [
            { label: 'Visa', value: 'Visa' },
            { label: 'Mastercard', value: 'Mastercard' },
            { label: 'Cash', value: 'Cash' },
        ];
    }

    
    handleClickMake(){
        
        
        if(this.items.length > 0){
            createTransaction({
                order: JSON.stringify(this.items),
                paymentType : this.paymentType,
                customerID: this.customerid,
            });
            this.items = [];
        }
    }
    @api 
    addItemToOrder(item){
        console.log(item.productId +" "+item.productName +" "+ item.productQuantity+" "+item.productPrice);
        if(this.items == []){
            this.items = [{
                productId : item.productId,
                productName : item.productName,
                productQuantity : item.productQuantity,
                productPrice : item.productPrice
            }];
            console.log(this.items);
        }
        else{
            this.items = this.items.concat([{
                productId : item.productId,
                productName : item.productName,
                productQuantity : item.productQuantity,
                productPrice : item.productPrice
            }]);
            console.log(this.items);
        }
    }
    
   
    

}