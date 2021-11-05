public class IncreaseProductAvailableAmoutSchedule implements Schedulable{
    public void execute(SchedulableContext sc){
        Database.executeBatch(new IncreaseProductAvailableAmoutBatch());
    }

}