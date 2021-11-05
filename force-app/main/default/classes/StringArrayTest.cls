public class StringArrayTest {
    
    public static String[] generateStringArray(Integer i){
     	String[] strResult = new String[i];
        for(Integer n = 0;n<i;n++){
            strResult[n] = 'Test ' + n;
        } 
        return strResult;
    }

}