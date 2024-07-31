import { LightningElement,track } from 'lwc';

export default class WeatherInfoComponent extends LightningElement {
    @track cityName = '';
    @track weatherData;

    handleCityChange(event) {
        this.cityName = event.target.value;
    }

    getWeatherInfo() {
        getWeather({ cityName: this.cityName })
            .then(result => {
                this.weatherData = result;
                console.log(this.weatherData);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
}