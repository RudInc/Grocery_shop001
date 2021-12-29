import { LightningElement, api } from 'lwc';



export default class Product extends LightningElement {
    @api product;
    quantity;
    disabled = true;
    

    handleQuantityChange(event){
        this.quantity = event.detail.value;
        if(this.quantity < 1 || this.quantity > this.product.Available_Amount__c){
            this.disabled = true;
            
        }
        else{
            this.disabled = false;
        }
    }
    //make event when button pressed
    handleAddButton(){
        
        const makeOrderEvent = new CustomEvent("additem",({
            detail : 
            {
                productId: this.product.Id,
                productName: this.product.Name,
                productQuantity: this.quantity,
                productPrice: this.product.Price__c*this.quantity
            }
        }));
        this.dispatchEvent(makeOrderEvent);
    }
}