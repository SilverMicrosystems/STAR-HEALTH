public class INRToUSDRequestAPIWrapper {
    public String base;   // USD
    public String to;     // INR
    public Integer amount;    // 10
    public Double converted;  // 835.739
    public Double rate;       // 83.5739
    public Integer lastUpdate; // 1718064000
    
    public  INRToUSDRequestAPIWrapper parse(String json) {
        return (INRToUSDRequestAPIWrapper) System.JSON.deserialize(json, INRToUSDRequestAPIWrapper.class);
    }
}