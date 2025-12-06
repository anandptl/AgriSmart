package an.sp.main.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import an.sp.main.entities.UserProfile;
import an.sp.main.repository.UserProfileRepository;

@Service
public class ProfileService {

    @Autowired
    private UserProfileRepository repo;

    public UserProfile getProfileByEmail(String email){
        return repo.findByUser_Email(email);
    }
//    
    public UserProfile getProfileByUserId(Long userId){
        return repo.findByUser_Id(userId);
    }

    public void save(UserProfile profile){
        repo.save(profile);
    }
}
