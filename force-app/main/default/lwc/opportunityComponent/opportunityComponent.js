import { LightningElement, track } from 'lwc';

export default class TimerComponent extends LightningElement {
    @track timeRemaining = 60;
    @track isTimerRunning = false;
    timer;

    startTimer() {
        this.isTimerRunning = true;
        this.timeRemaining = 60;

        this.timer = setInterval(() => {
            this.timeRemaining -= 1;
            if (this.timeRemaining <= 0) {
                clearInterval(this.timer);
                this.isTimerRunning = false;
            }
        }, 1000);
    }
}