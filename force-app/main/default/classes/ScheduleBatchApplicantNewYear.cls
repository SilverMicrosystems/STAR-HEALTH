public class ScheduleBatchApplicantNewYear implements Schedulable{

    public void execute(SchedulableContext SC){
        Database.executeBatch(new BatchApplicantNewYear(), 100);
    }
}