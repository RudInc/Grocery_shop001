import { LightningElement, api } from 'lwc';

export default class Customer extends LightningElement {
    @api customer;
    @api choose = false;
    
    
    handleChooseCustomer(){
        const chooseCustomerEvent = new CustomEvent('choosecustomer',{
            detail : JSON.stringify(this.customer)
        });
        this.dispatchEvent(chooseCustomerEvent);
        
    }
    handleDismiss(){
        const chooseCustomerEvent = new CustomEvent('dismisscustomer');
        this.dispatchEvent(chooseCustomerEvent);
    }
    
    get color(){
        return this.choose ? "--sds-c-card-color-background: green" : "--sds-c-card-color-background: white";
    }
    
}