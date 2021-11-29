public with sharing class CustomerOrderController {
    @AuraEnabled
    public static void createTransaction(String order , String paymentType, String customerID){
        List<LineItemWrapper> itemsWrapper= (List<LineItemWrapper>)JSON.deserialize(order, List<LineItemWrapper>.class);
        List<LineItemDTO> itemsDTO= new List<LineItemDTO>(); 
        for(LineItemWrapper item : itemsWrapper){
            itemsDTO.add(new LineItemDTO(item.quantity, item.productId));
        }
        
        GroceryServices.createTransaction(paymentType, itemsDTO, (Id)customerID);
        
        
    }
    public class LineItemWrapper{
        @AuraEnabled public Integer quantity{get;set;}
        @AuraEnabled public ID productId{get;set;}
        public LineItemWrapper(){

        }
    }

}
