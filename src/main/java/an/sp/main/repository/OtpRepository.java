package an.sp.main.repository;

import an.sp.main.entities.OtpEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OtpRepository extends JpaRepository<OtpEntity, Long> {

    OtpEntity findByUserEmail(String email);
}
