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
SELECT DISTINCT p
FROM UserProfile p
JOIN p.user u
LEFT JOIN u.buyerCrop c
WHERE u.role = 'BUYER'
  AND (
        :name IS NULL OR :name = ''
        OR LOWER(u.firstName) LIKE LOWER(CONCAT('%', :name, '%'))
        OR LOWER(u.lastName) LIKE LOWER(CONCAT('%', :name, '%'))
        OR LOWER(CONCAT(u.firstName, ' ', u.lastName))
           LIKE LOWER(CONCAT('%', :name, '%'))
      )
  AND (:district IS NULL OR :district = '' OR p.district = :district)
  AND (:crop IS NULL OR :crop = ''
       OR c.crop1 = :crop
       OR c.crop2 = :crop
       OR c.crop3 = :crop)
""")

    List<UserProfile> searchBuyers(
            @Param("name") String name,
            @Param("district") String district,
            @Param("crop") String crop);

    @Query("""
    SELECT DISTINCT p
    FROM UserProfile p
    JOIN p.user u
    LEFT JOIN u.buyerCrop c
    WHERE u.role = 'FARMER'
      AND (
            :name IS NULL OR :name = ''
            OR LOWER(u.firstName) LIKE LOWER(CONCAT('%', :name, '%'))
            OR LOWER(u.lastName) LIKE LOWER(CONCAT('%', :name, '%'))
            OR LOWER(CONCAT(u.firstName, ' ', u.lastName))
               LIKE LOWER(CONCAT('%', :name, '%'))
          )
      AND (:district IS NULL OR :district = '' OR p.district = :district)
      AND (:crop IS NULL OR :crop = ''
           OR c.crop1 = :crop
           OR c.crop2 = :crop
           OR c.crop3 = :crop)
    """)
    List<UserProfile> searchFarmers(
            @Param("name") String name,
            @Param("district") String district,
            @Param("crop") String crop);
}
