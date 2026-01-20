package an.sp.main.service;

import an.sp.main.entities.OtpEntity;
import an.sp.main.entities.UsersEntity;
import an.sp.main.repository.OtpRepository;
import an.sp.main.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Date;
import java.util.Random;

@Service
public class OtpService {

    @Autowired
    private PasswordEncoder encoder;

    @Autowired
    private HttpSession session;

    @Autowired
    private OtpRepository otpRepo;

    @Autowired
    private UserRepository repo;

    @Autowired
    private EmailService emailService;

    //    send otp for the password forgat........

    public String sendOtp(String email) {

        UsersEntity user = repo.findByEmail(email);
        if (user == null) {
            return "Email not registered!";
        }

        String otp = String.valueOf(100000 + new Random().nextInt(900000));

        OtpEntity otpEntity = user.getOtpDetails();
        if (otpEntity == null) {
            otpEntity = new OtpEntity();
            otpEntity.setUser(user);
        }

        otpEntity.setOtp(otp);
        otpEntity.setOtpGeneratedTime(new Date());

        otpRepo.save(otpEntity);

        // OTP Email Send
        emailService.sendOtp(email, otp);

        return "OTP sent successfully!";
    }


    public boolean verifyOtp(String email, String otp) {

        OtpEntity otpEntity = otpRepo.findByUserEmail(email);
        if (otpEntity == null) return false;

        if (!otp.equals(otpEntity.getOtp())) return false;

        long expiry = otpEntity.getOtpGeneratedTime().getTime() + 5 * 60 * 1000;

        return new Date().getTime() <= expiry;
    }


    public boolean resetPassword(String email, String newPassword) {

        UsersEntity user = repo.findByEmail(email);
        if (user == null) return false;

        user.setPassword(encoder.encode(newPassword));
        repo.save(user);
        return true;
    }


    //    Signup otp
    public String sendSignupOtp(String email) {

        // Check if already registered
        if (repo.findByEmail(email) != null) {
            return "Email already registered!";
        }

        String otp = String.valueOf(100000 + new Random().nextInt(900000));

        // Save OTP temporarily in session OR cache
        session.setAttribute("signupOtp", otp);
        session.setAttribute("signupOtpTime", new Date());
        session.setAttribute("signupEmail", email);

        emailService.sendSignupOtp(email, otp);

        return "OTP is being sent. Check your email in a few seconds.";
    }

    public boolean verifySignupOtp(String email, String otp) {

        String sessionOtp = (String) session.getAttribute("signupOtp");
        Date otpTime = (Date) session.getAttribute("signupOtpTime");
        String sessionEmail = (String) session.getAttribute("signupEmail");

        if (sessionOtp == null || otpTime == null) return false;
        if (!email.equals(sessionEmail)) return false;
        if (!otp.equals(sessionOtp)) return false;

        long expiry = otpTime.getTime() + 5 * 60 * 1000;
        boolean valid = new Date().getTime() <= expiry;

        if (valid) {
            session.setAttribute("signupOtpVerified", true);
        }

        return valid;
    }

}
