package an.sp.main.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import an.sp.main.entities.UsersEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<UsersEntity, Long> {
    UsersEntity findByEmail(String email);
    boolean existsByEmail(String email);

    //    search buyers by city & crop name
    @Query("""
    SELECT DISTINCT u
    FROM UsersEntity u
    LEFT JOIN FETCH u.profile p
    LEFT JOIN FETCH u.buyerCrop c
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
    List<UsersEntity> searchBuyers(
            @Param("name") String name,
            @Param("district") String district,
            @Param("crop") String crop);



    @Query("""
    SELECT DISTINCT u
    FROM UsersEntity u
    LEFT JOIN FETCH u.profile p
    LEFT JOIN FETCH u.buyerCrop c
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
    List<UsersEntity> searchFarmers(
            @Param("name") String name,
            @Param("district") String district,
            @Param("crop") String crop);


    @Query("""
    SELECT DISTINCT u
    FROM UsersEntity u
    LEFT JOIN FETCH u.profile
    LEFT JOIN FETCH u.activity
    WHERE
       LOWER(u.firstName) LIKE LOWER(CONCAT('%', :keyword, '%'))
       OR LOWER(u.lastName) LIKE LOWER(CONCAT('%', :keyword, '%'))
    """)
    List<UsersEntity> searchUsers(@Param("keyword") String keyword);


    //    find all farmers for Admin_user page...
    @Query("""
    SELECT DISTINCT u
    FROM UsersEntity u
    LEFT JOIN FETCH u.profile
    LEFT JOIN FETCH u.activity
    LEFT JOIN FETCH u.buyerCrop
    WHERE u.role = 'FARMER'
    """)
    List<UsersEntity> findAllFarmers();


    //    find all buyers for Admin_user page...
    @Query("""
    SELECT DISTINCT u
    FROM UsersEntity u
    LEFT JOIN FETCH u.profile
    LEFT JOIN FETCH u.activity
    LEFT JOIN FETCH u.buyerCrop
    WHERE u.role = 'BUYER'
    """)
    List<UsersEntity> findAllBuyers();


//    find all users for the Admin Page......
    @Query("""
        SELECT COUNT(DISTINCT u)
        FROM UsersEntity u
        LEFT JOIN u.activity a
        WHERE a.lastSeen IS NOT NULL
          AND a.lastSeen >= :time
    """)
    long countActiveUsers(@Param("time") LocalDateTime time);

//    find farmers by the name
    @Query("""
    SELECT DISTINCT u
    FROM UsersEntity u
    LEFT JOIN FETCH u.profile
    LEFT JOIN FETCH u.activity
    WHERE u.role = 'FARMER'
      AND (
           LOWER(u.firstName) LIKE LOWER(CONCAT('%', :keyword, '%'))
        OR LOWER(u.lastName)  LIKE LOWER(CONCAT('%', :keyword, '%'))
      )
    """)
    List<UsersEntity> searchFarmersByName(@Param("keyword") String keyword);

// Find buyers by the name ...
    @Query("""
    SELECT DISTINCT u
    FROM UsersEntity u
    LEFT JOIN FETCH u.profile
    LEFT JOIN FETCH u.activity
    LEFT JOIN FETCH u.buyerCrop
    WHERE u.role = 'BUYER'
      AND (
           LOWER(u.firstName) LIKE LOWER(CONCAT('%', :keyword, '%'))
        OR LOWER(u.lastName)  LIKE LOWER(CONCAT('%', :keyword, '%'))
      )
""")
    List<UsersEntity> searchBuyersByName(@Param("keyword") String keyword);



}
