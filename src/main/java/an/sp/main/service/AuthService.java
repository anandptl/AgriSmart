package an.sp.main.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import an.sp.main.entities.UsersEntity;
import an.sp.main.repository.UserRepository;
import an.sp.main.util.JwtUtil;
import jakarta.servlet.http.HttpSession;

@Service
public class AuthService {

    @Autowired
    private UserRepository repo;

    @Autowired
    private PasswordEncoder encoder;

    @Autowired
    private JwtUtil jwtUtil;

    public boolean register(UsersEntity user) {

        if (repo.existsByEmail(user.getEmail())) {
            return false;
        }

        user.setPassword(encoder.encode(user.getPassword()));

        saveUser(user);
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

}
