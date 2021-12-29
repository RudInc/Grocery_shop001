public with sharing class CustomerOrderController {
    @AuraEnabled
    public static void createTransaction(String order , String paymentType, String customerID){
        List<LineItemWrapper> itemsWrapper= (List<LineItemWrapper>)JSON.deserialize(order, List<LineItemWrapper>.class);
        List<LineItemDTO> itemsDTO= new List<LineItemDTO>(); 
        for(LineItemWrapper item : itemsWrapper){
            itemsDTO.add(new LineItemDTO(item.productQuantity, item.productId));
        }
        
        GroceryServices.createTransaction(paymentType, itemsDTO, (Id)customerID);
        
        
    }
    public class LineItemWrapper{
        @AuraEnabled public Integer productQuantity{get;set;}
        @AuraEnabled public ID productId{get;set;}
        @AuraEnabled public String productName{get;set;}
        public LineItemWrapper(){

        }
    }

}
