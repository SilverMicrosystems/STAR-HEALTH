public class SourceAccountRequestAPIWrapper {
	public String status;
    public String phone;
    public Boolean phone_valid;
    public String phone_type;
    public String phone_region;
    public String country;
    public String country_code;
    public String country_prefix;
    public String international_number;
    public String local_number;
    public String e164;
    public String carrier;
    
    public SourceAccountRequestAPIWrapper parse(String json) {
        return (SourceAccountRequestAPIWrapper) System.JSON.deserialize(json, SourceAccountRequestAPIWrapper.class);
    }
}