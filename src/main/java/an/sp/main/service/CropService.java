package an.sp.main.service;

import an.sp.main.entities.CropEntity;
import an.sp.main.repository.CropRepository;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CropService {
    @Autowired
    private CropRepository cropRepository;

    public void saveCrop(CropEntity crop, MultipartFile file) throws IOException {
        if (cropRepository.existsByCropName(crop.getCropName())) {
            throw new RuntimeException("Crop already exists!");
        }

        if (file != null && !file.isEmpty()) {
            crop.setCropImage(file.getBytes());
            crop.setCropImageName(file.getOriginalFilename());
        }

        cropRepository.save(crop);
    }

    //    find crop
    public CropEntity getCropByName(String cropName) {
        return cropRepository.findByCropNameIgnoreCase(cropName);
    }

    //    update crop..
    public void updateCrop(Long id, Double minPrice,
                           Double maxPrice, MultipartFile file) throws IOException {

        CropEntity crop = cropRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Crop not found"));

        crop.setMinPrice(minPrice);
        crop.setMaxPrice(maxPrice);

        if (file != null && !file.isEmpty()) {
            crop.setCropImage(file.getBytes());
            crop.setCropImageName(file.getOriginalFilename());
        }

        cropRepository.save(crop);
    }


    // delete crop
    public boolean deleteCropById(Long id) {

        if (cropRepository.existsById(id)) {
            cropRepository.deleteById(id);
            return true;
        }
        return false;
    }


    //    find how many crop
    public List<Object[]> getCropCountByCategory() {
        return cropRepository.countCropsByCategory();
    }

    //  get all crop details ...
    public List<CropEntity> getAllCrops() {
        return cropRepository.findAll();
    }

//    find crop by the category.....
    public List<CropEntity> getCropsByCategory(String category){
        return cropRepository.findByCategory(category);
    }

    //  load crop image .....
    public CropEntity getById(Long id) {
        return cropRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Crop not found"));
    }


    //    filter crop for suggestion ....
    public List<CropEntity> filterCrops(String soilType,
                                        String category,
                                        String season,
                                        String waterNeed,
                                        String climate) {

        return cropRepository.filterCrops(
                soilType,
                category,
                season,
                waterNeed,
                climate
        );
    }


    // find crop by name ...
    public Optional<CropEntity> findCropByName(String cropName){
        return cropRepository.findByCropName(cropName);
    }

    public long getTotalCrops() { return cropRepository.count(); }

}
