package an.sp.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import an.sp.main.entities.UsersEntity;

public interface UserRepository extends JpaRepository<UsersEntity, Long> {
    UsersEntity findByEmail(String email);
    boolean existsByEmail(String email);
}
