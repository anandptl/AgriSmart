package an.sp.main.repository;

import an.sp.main.entities.UserActivityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Optional;

@Repository
public interface UserActivityRepo extends JpaRepository<UserActivityEntity, Long> {
    Optional<UserActivityEntity> findByUser_Id(Long userId);
}