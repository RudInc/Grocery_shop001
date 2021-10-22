@isTest
public  class getTopSellersTest {
    @testSetup static void testSetup(){
        List<Transaction__c> setupTransactions = TestDataFactory.generateTransactions(15,'Active');
        List<Product__c> setupProduct = TestDataFactory.generateProducts(3,10,1000);
        Integer daysToAdd = 0;
        insert setupTransactions;
        insert setupProduct;
        List<Line_Item__c> setupItems = new List<Line_item__c>(); 
        for(Product__c prod : setupProduct){
            for(Transaction__c trans : setupTransactions){
                setupItems.addAll(TestDataFactory.generateLineItems(3,5,trans.ID,prod.ID));
            }
        }
        for(Transaction__c trans : setupTransactions){
            Test.setCreatedDate(trans.id, Date.newInstance(2021, 1, 1).addDays(daysToAdd));
            daysToAdd +=15;
        }
        insert setupItems;
    }
    @IsTest static void validYear(){
        Integer testYear = 2021;
        Integer limitNumber = 5;
        Integer offsetNumber = 5;
        List<Line_Item__c> resToTest = [SELECT Product__r.Name, Amount__c
                                        FROM Line_Item__c
                                        WHERE CALENDAR_YEAR(CreatedDate) = :testYear
                                        ORDER BY Amount__c DESC
                                        LIMIT :limitNumber OFFSET :offsetNumber];
        Test.startTest();
        List<Line_Item__c> result = GroceryDAO.getTopSellers(5,5,testYear);
        for(Line_Item__c res1 :result){
            for(Line_Item__c res2 : resToTest){
                system.assertEquals(res2.Amount__c, res1.Amount__c);
            }
        }
        Test.stopTest();
    }
    @IsTest static void invalidYear(){
        Integer testYear = 1000;
        
        Test.startTest();
        List<Line_Item__c> result = GroceryDAO.getTopSellers(5,5,testYear);
        system.assert(result.isEmpty());
            
        Test.stopTest();
    }
    @IsTest static void invalidLimit(){
        Integer testYear = 1000;
        
        Test.startTest();
        List<Line_Item__c> result = GroceryDAO.getTopSellers(0,5,testYear);
        system.assert(result.isEmpty());
            
        Test.stopTest();
    }
    @IsTest static void invalidOffset(){
        Integer testYear = 1000;
        
        Test.startTest();
        List<Line_Item__c> result = GroceryDAO.getTopSellers(5,0,testYear);
        system.assert(result.isEmpty());
            
        Test.stopTest();
    }
}

