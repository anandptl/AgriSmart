package an.sp.main.service;

import an.sp.main.entities.UserActivityEntity;
import an.sp.main.repository.UserActivityRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.time.Duration;
import java.time.LocalDateTime;

@Service
public class UserActivityService {

    @Autowired
    private UserActivityRepo userActivityRepo;

    //saved users
    public void saveActivity(UserActivityEntity activity) {
        userActivityRepo.save(activity);
    }

    // ACTIVE USERS
    public long getActiveUsers() {
        return userActivityRepo.countActiveUsers(
                LocalDateTime.now().minusMinutes(5)
        );
    }

    //ALL USERS WITH ONLINE / OFFLINE STATUS
    public List<UserActivityEntity> getUsersWithStatus() {

        List<UserActivityEntity> list = userActivityRepo.findAll();
        LocalDateTime now = LocalDateTime.now();

        for (UserActivityEntity ua : list) {

            ua.setLastSeenFormatted(
                    calculateTimeAgo(ua.getLastSeen())
            );

            if (ua.getLastSeen() == null) {
                ua.setOnline(false);
            } else {
                long minutes =
                        Duration.between(ua.getLastSeen(), now).toMinutes();

                ua.setOnline(minutes <= 5);
            }
        }

        return list;
    }


    // TIME AGO LOGIC
    private String calculateTimeAgo(LocalDateTime lastSeen) {

        if (lastSeen == null) {
            return "offline";
        }

        Duration duration = Duration.between(lastSeen, LocalDateTime.now());
        long seconds = duration.getSeconds();

        if (seconds < 60) {
            return "just now";
        }

        long minutes = seconds / 60;
        if (minutes < 60) {
            return minutes + " minutes ago";
        }

        long hours = minutes / 60;
        if (hours < 24) {
            return hours + " hours ago";
        }

        long days = hours / 24;
        if (days == 1) {
            return "yesterday";
        }

        return days + " days ago";
    }
}
