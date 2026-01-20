package an.sp.main.repository;

import an.sp.main.entities.UserActivityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface UserActivityRepo extends JpaRepository<UserActivityEntity, Long> {

    @Query("""
    SELECT COUNT(u) 
    FROM UserActivityEntity u 
    WHERE u.lastSeen >= :time
    """)
    long countActiveUsers(@Param("time") LocalDateTime time);




//    List<UserActivityEntity> findByStatus(int status);

}
