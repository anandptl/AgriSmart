package an.sp.main.repository;

import an.sp.main.entities.CropEntity;
import an.sp.main.entities.FarmerCropEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface FarmerCropRepository
        extends JpaRepository<FarmerCropEntity, Long> {

    // Specific farmer ke sab applied crops
    @Query("SELECT f.crop.id FROM FarmerCropEntity f WHERE f.farmer.id = :farmerId")
    List<Long> findAppliedCropIdsByFarmerId(Long farmerId);

    @Query("SELECT f.crop FROM FarmerCropEntity f WHERE f.farmer.id = :farmerId")
    List<CropEntity> findAppliedCropNamesByFarmerId(Long farmerId);


    // Check duplicate
    Optional<FarmerCropEntity> findByFarmerIdAndCropId(Long farmerId, Long cropId);


}
