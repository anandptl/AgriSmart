package an.sp.main.entities;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "otp_details")
public class OtpEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 6)
    private String otp;

    @Column(name = "otp_generated_time")
    private Date otpGeneratedTime;

    @OneToOne
    @JoinColumn(name = "user_id", unique = true)
    private UsersEntity user;

    // getters & setters
    public Long getId() {
        return id;
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

    public UsersEntity getUser() {
        return user;
    }

    public void setUser(UsersEntity user) {
        this.user = user;
    }
}
