package an.sp.main.service;

import java.util.Date;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import an.sp.main.entities.UsersEntity;
import an.sp.main.repository.UserRepository;
import an.sp.main.util.JwtUtil;

@Service
public class AuthService {

    @Autowired
    private UserRepository repo;

    @Autowired
    private PasswordEncoder encoder;

    @Autowired
    private JwtUtil jwtUtil;
    
    @Autowired
    private EmailService emailService;

    public boolean register(UsersEntity user) {

        if (repo.existsByEmail(user.getEmail())) {
            return false;
        }

        user.setPassword(encoder.encode(user.getPassword()));

        repo.save(user);
        return true;
    }

    
    public String login(String email, String password, String role) {

        role = role.trim().toUpperCase();

        UsersEntity user = repo.findByEmail(email);

        if (user == null) {
            throw new RuntimeException("User not found!");
        }

        if (!encoder.matches(password, user.getPassword())) {
            throw new RuntimeException("Incorrect Password!");
        }

        if (!user.getRole().equalsIgnoreCase(role)) {
            throw new RuntimeException("Invalid Role Selected!");
        }

        return jwtUtil.generateToken(email, role);
    }


    public UsersEntity getByEmail(String email) {
        return repo.findByEmail(email);
    }


    public void saveUser(UsersEntity user) {
        repo.save(user);
    }
    
    
//    send otp for the password forgat........
//    --------------------------------------------
    
    public String sendOtp(String email) {

        UsersEntity user = repo.findByEmail(email);
        if (user == null) {
            return "Email not registered!";
        }

        String otp = String.valueOf(100000 + new Random().nextInt(900000));

        user.setOtp(otp);
        user.setOtpGeneratedTime(new Date());
        repo.save(user);

        // OTP Email Send
        emailService.sendOtp(email, otp);

        return "OTP sent successfully!";
    }

    
    public boolean verifyOtp(String email, String otp) {

        UsersEntity user = repo.findByEmail(email);
        if (user == null) return false;

        if (!otp.equals(user.getOtp())) return false;

        long expiry = user.getOtpGeneratedTime().getTime() + 5 * 60 * 1000;

        return new Date().getTime() <= expiry;
    }

    
    public boolean resetPassword(String email, String newPassword) {

        UsersEntity user = repo.findByEmail(email);
        if (user == null) return false;

        user.setPassword(encoder.encode(newPassword));
        user.setOtp(null);
        user.setOtpGeneratedTime(null);
        
        repo.save(user);
        return true;
    }


}
