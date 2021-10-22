public class LineItemDTO{
    public Integer quontity;
    public ID productID;
	
    public LineItemDTO(Integer q, ID prodId){
        quontity = q;
        productID = prodId;
    }
    public static List<LineItemDTO> generateLineItemDTO(Integer num,Integer quantity, ID productID){
        if(quantity<1||num<1){return new List<LineItemDTO>();}
        List<LineItemDTO> items = new List<LineItemDTO>();
        for(Integer i = 0;i<num;i++){
            items.add(new LineItemDTO(quantity,productID));
        }
        return items;
    }
    
}