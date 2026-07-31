package an.sp.main.repository;

import an.sp.main.entities.CropEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface CropRepository extends JpaRepository<CropEntity, Long> {
    boolean existsByCropName(String cropName);

//    crop find by name
    Optional<CropEntity> findByCropName(String cropName);

    // find crop by name 
    CropEntity findByCropNameIgnoreCase(String cropName);

    @Query("SELECT c.category, COUNT(c) FROM CropEntity c GROUP BY c.category")
    List<Object[]> countCropsByCategory();



    @Query("""
        SELECT c FROM CropEntity c
        WHERE (:soilType IS NULL OR :soilType = '' OR c.soilType = :soilType)
        AND (:category IS NULL OR :category = '' OR c.category = :category)
        AND (:season IS NULL OR :season = '' OR c.season = :season)
        AND (:waterNeed IS NULL OR :waterNeed = '' OR c.waterNeed = :waterNeed)
        AND (:climate IS NULL OR :climate = '' OR c.climate = :climate)
    """)
    List<CropEntity> filterCrops(
            @Param("soilType") String soilType,
            @Param("category") String category,
            @Param("season") String season,
            @Param("waterNeed") String waterNeed,
            @Param("climate") String climate
    );


//    find crop by crop category ....
    List<CropEntity> findByCategory(String category);
}
