public class ScheduleBatchApplicantBirthdayEmail implements Schedulable {

    public void execute(SchedulableContext SC){
        Database.executeBatch(new BatchApplicantBirthdayEmail(),100); // Calling a Batch class
    }
}