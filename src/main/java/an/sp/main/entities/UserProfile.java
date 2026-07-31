package an.sp.main.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "user_profiles")
public class UserProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "user_id", unique = true)
    private UsersEntity user;
    
    private String village;
    
    private String city;
    
    private String district;
    
    private String state;
    
    private String country;
    
    private String pincode;
    
    @NotBlank
    @Column(nullable = false)
    private String phone;

    @Lob
    private byte[] profilePhoto;

    private String profilePhotoName;
    
//    Getter & setter

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public UsersEntity getUser() {
		return user;
	}

	public void setUser(UsersEntity user) {
		this.user = user;
	}

	public String getVillage() {
		return village;
	}

	public void setVillage(String village) {
		this.village = village;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
	
	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public byte[] getProfilePhoto() {
		return profilePhoto;
	}

	public void setProfilePhoto(byte[] profilePhoto) {
		this.profilePhoto = profilePhoto;
	}

	public String getProfilePhotoName() {
		return profilePhotoName;
	}

	public void setProfilePhotoName(String profilePhotoName) {
		this.profilePhotoName = profilePhotoName;
	}

	
    
}
