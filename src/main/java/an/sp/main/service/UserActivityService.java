package an.sp.main.service;

import an.sp.main.entities.UserActivityEntity;
import an.sp.main.entities.UsersEntity;
import an.sp.main.repository.UserActivityRepo;
import an.sp.main.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserActivityService {

    @Autowired
    private UserActivityRepo userActivityRepo;
    @Autowired
    private UserRepository userRepository;

    // SAVE ACTIVITY
    public void saveActivity(UserActivityEntity activity) {
        userActivityRepo.save(activity);
    }

    // COUNT ACTIVE USERS
    public long getActiveUsers() {
        return userRepository.countActiveUsers(
                LocalDateTime.now().minusMinutes(5)
        );
    }

    // ALL USERS WITH STATUS
    public List<UserActivityEntity> getUsersWithStatus() {

        List<UserActivityEntity> list = userActivityRepo.findAll();
        LocalDateTime now = LocalDateTime.now();

        for (UserActivityEntity ua : list) {
            applyStatus(ua, now);
        }
        return list;
    }


//    Find all farmer details for Admin-user page
    public List<UsersEntity> getAllFarmer(){
        return userRepository.findAllFarmers();
    }

//    Find all buyers details for Admin-user page
    public List<UsersEntity> getAllBuyers(){
        return userRepository.findAllBuyers();
    }

//    find farmers by name for
    public List<UsersEntity> searchFarmersByName(String keyword){
         return userRepository.searchFarmersByName(keyword);
    }

    public List<UsersEntity> searchBuyersByName(String keyword){
        return userRepository.searchBuyersByName(keyword);
    }

    // SEARCH BY NAME (AJAX USES THIS)
    public List<UsersEntity> searchByName(String keyword) {
        List<UsersEntity> list = userRepository.searchUsers(keyword);

        LocalDateTime now = LocalDateTime.now();

        for (UsersEntity user : list) {
            if (user.getActivity() != null) {
                applyStatus(user.getActivity(), now);
            }
        }

        return list;
    }



    // BLOCK USER
    public void blockUser(Long userId) {

        UserActivityEntity activity =
                userActivityRepo.findByUser_Id(userId)
                        .orElseGet(() -> {
                            UserActivityEntity ua = new UserActivityEntity();
                            ua.setUser(userRepository.findById(userId).orElseThrow());
                            ua.setBlock(false);
                            return ua;
                        });

        activity.setBlock(true);
        userActivityRepo.save(activity);
    }

    // UNBLOCK USER
    public void unblockUser(Long userId) {

        UserActivityEntity activity =
                userActivityRepo.findByUser_Id(userId)
                        .orElseThrow(() ->
                                new RuntimeException("User activity not found")
                        );

        activity.setBlock(false);
        // Login success → reset attempts
        activity.setFailedAttempts(0);
        userActivityRepo.save(activity);
    }







    // ------ HELPER METHODS -----

    private void applyStatus(UserActivityEntity ua, LocalDateTime now) {

        ua.setLastSeenFormatted(
                calculateTimeAgo(ua.getLastSeen())
        );

        if (ua.getLastSeen() == null) {
            ua.setOnline(false);
        } else {
            long minutes =
                    Duration.between(ua.getLastSeen(), now).toMinutes();

            ua.setOnline(minutes <= 5); // 5 min rule
        }
    }

    // TIME AGO LOGIC
    private String calculateTimeAgo(LocalDateTime lastSeen) {

        if (lastSeen == null) return "offline";

        Duration duration =
                Duration.between(lastSeen, LocalDateTime.now());

        long seconds = duration.getSeconds();

        if (seconds < 60) return "just now";

        long minutes = seconds / 60;
        if (minutes < 60) return minutes + " minutes ago";

        long hours = minutes / 60;
        if (hours < 24) return hours + " hours ago";

        long days = hours / 24;
        if (days == 1) return "yesterday";

        return days + " days ago";
    }
}
