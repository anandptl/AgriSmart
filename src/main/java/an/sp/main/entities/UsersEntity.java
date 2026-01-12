package an.sp.main.entities;


import java.util.Date;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "users")
public class UsersEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	    
	@NotBlank
	@Column(nullable = false)
	private String firstName;
	    
	@NotBlank
	@Column(nullable = false)
	private String lastName;

	@Column(unique = true, nullable = false)
	@NotBlank(message = "Email can't be blank")
	@Email(message = "Invalid email format")
	private String email;

	@NotBlank
	@Column(nullable = false)
	private String password;

	@NotBlank
	@Column(length = 20)
	private String language;

	// FARMER / BUYER / ADMIN
	@NotBlank
	@Column(nullable = false)
	private String role;
	    
	@Column
	private String otp;

	@Column
	private Date otpGeneratedTime;

	    
	@OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
	private UserProfile profile;

	@OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
	private buyerCropEntity buyerCrop;

	public buyerCropEntity getBuyerCrop() {
		return buyerCrop;
	}

	public void setBuyerCrop(buyerCropEntity buyerCrop) {
		this.buyerCrop = buyerCrop;
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
			return firstName;
		}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public UserProfile getProfile() {
		return profile;
	}

	public void setProfile(UserProfile profile) {
		this.profile = profile;
	}

	public String getOtp() {
			return otp;
		}

	public void setOtp(String otp) {
		this.otp = otp;
	}

	public Date getOtpGeneratedTime() {
			return otpGeneratedTime;
		}

	public void setOtpGeneratedTime(Date otpGeneratedTime) {
			this.otpGeneratedTime = otpGeneratedTime;
		}
	    

}
