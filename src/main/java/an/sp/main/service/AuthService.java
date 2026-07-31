package an.sp.main.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import an.sp.main.entities.UserActivityEntity;
import an.sp.main.entities.UsersEntity;
import an.sp.main.repository.UserActivityRepo;
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
    private UserActivityRepo userActivityRepo;

    public boolean register(UsersEntity user) {

        if (repo.existsByEmail(user.getEmail())) {
            return false;
        }

        user.setPassword(encoder.encode(user.getPassword()));

        saveUser(user);
        return true;
    }

    
    public String login(String email, String password) {

        // role = role.trim().toUpperCase();

        UsersEntity user = repo.findByEmail(email);

        if (user == null) {
            throw new RuntimeException("User not found!");
        }

        // check user block or not ..
        UserActivityEntity activity = userActivityRepo.findByUser_Id(user.getId()).orElse(null);

        if (activity != null && Boolean.TRUE.equals(activity.getBlock())) {
            throw new RuntimeException("Your account is blocked by admin! Please Contact Us.");
        }

        // Password check if missmatch 4 time than block the users
        if (!encoder.matches(password, user.getPassword())) {

            int attempts = activity.getFailedAttempts() + 1;
            activity.setFailedAttempts(attempts);

            if (attempts >= 4) {
                activity.setBlock(true);
                userActivityRepo.save(activity);
                throw new RuntimeException("Account blocked after 4 wrong attempts!");
            }

            userActivityRepo.save(activity);

            throw new RuntimeException("Incorrect Password! Attempt " + attempts + "/4");
        }

//        // Login success → reset attempts
//        activity.setFailedAttempts(0);
//        userActivityRepo.save(activity);

        return jwtUtil.generateToken(email, user.getRole());
    }


    public UsersEntity getByEmail(String email) {
        return repo.findByEmail(email);
    }


    public void saveUser(UsersEntity user) {
        repo.save(user);
    }

}
