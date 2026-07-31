package an.sp.main.service;

import an.sp.main.entities.*;
import an.sp.main.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class FarmerCropService {

    @Autowired
    private FarmerCropRepository farmerCropRepository;

    @Autowired
    private UserRepository usersRepository;

    @Autowired
    private CropRepository cropRepository;


    // Get all applied crops of farmer
    public List<Long> getAppliedCropIds(Long farmerId) {
        return farmerCropRepository.findAppliedCropIdsByFarmerId(farmerId);
    }

    // farmer applied crop name ...
    public List<CropEntity> getAppliedCropName(Long farmerId) {
        return farmerCropRepository.findAppliedCropNamesByFarmerId(farmerId);
    }


    // Apply crop
    public void applyCrop(Long cropId, Long farmerId) {

        // Duplicate check
        Optional<FarmerCropEntity> existing =
                farmerCropRepository
                        .findByFarmerIdAndCropId(farmerId, cropId);

        if (existing.isPresent()) {
            return; // already applied
        }

        UsersEntity farmer =
                usersRepository.findById(farmerId).orElseThrow();

        CropEntity crop =
                cropRepository.findById(cropId).orElseThrow();

        FarmerCropEntity fc = new FarmerCropEntity();
        fc.setFarmer(farmer);
        fc.setCrop(crop);

        farmerCropRepository.save(fc);
    }


    // Unapply crop
    public void unapplyCrop(Long cropId, Long farmerId) {

        farmerCropRepository
                .findByFarmerIdAndCropId(farmerId, cropId)
                .ifPresent(farmerCropRepository::delete);
    }
}

