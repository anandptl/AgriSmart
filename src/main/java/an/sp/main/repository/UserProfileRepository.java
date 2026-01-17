package an.sp.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import an.sp.main.entities.UserProfile;

import java.util.List;

@Repository
public interface UserProfileRepository extends JpaRepository<UserProfile, Long> {

    @Query("SELECT b FROM UserProfile b WHERE b.user.role ='BUYER'")
    List<UserProfile> findAllBuyers();

    @Query("SELECT f FROM UserProfile f WHERE f.user.role ='FARMER'")
    List<UserProfile> findAllFarmer();

    UserProfile findByUser_Email(String email);
    
    UserProfile findByUser_Id(Long userId);

//    search buyers by city & crop name
@Query("""
    SELECT p 
    FROM UserProfile p
    JOIN p.user u
    LEFT JOIN u.buyerCrop c
    WHERE u.role = 'BUYER'
      AND (:district IS NULL OR :district = '' OR p.district = :district)
      AND (:crop IS NULL OR :crop = '' 
           OR c.crop1 = :crop 
           OR c.crop2 = :crop 
           OR c.crop3 = :crop)
    """)
    List<UserProfile> searchBuyers(@Param("district") String district,
                               @Param("crop") String crop);
}
