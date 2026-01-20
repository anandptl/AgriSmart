package an.sp.main.repository;

import an.sp.main.entities.UsersEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface AdminRepo extends JpaRepository<UsersEntity, Long> {

//    // Total buyers count
//    @Query("SELECT COUNT(u) FROM UsersEntity u WHERE u.role = 'BUYER'")
//    long countBuyers();
//
//    // total Farmer count
//    @Query("SELECT COUNT(u) FROM UsersEntity u WHERE u.role = 'FARMER'")
//    long countFarmers();
//
//    @Query("SELECT COUNT(u) FROM UsersEntity u WHERE u.active = true")
//    long countActiveUsers();


    long countByRole(String role);

}
