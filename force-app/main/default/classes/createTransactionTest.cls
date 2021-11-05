@isTest
public class CreateTransactionTest {
 
    @isTest static void createTransactionTest(){
        List<LineItemDTO> itemsDTO = LineItemDTO.generateLineItemDTO(10,10, (id)'a040900000LcqwfAAB');
        List<Database.SaveResult> result = GroceryServices.createTransaction('Visa',itemsDTO);
        for(Database.SaveResult res : result){
            System.assert(res.isSuccess());
        }
    }

}