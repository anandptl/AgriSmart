package an.sp.main.service;

import an.sp.main.entities.CropEntity;
import an.sp.main.entities.OrganicProcessEntity;
import an.sp.main.repository.CropRepository;
import an.sp.main.repository.OrganicRepo;
import an.sp.main.wrapper.OrganicProcessWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrganicService {
    @Autowired
    private CropRepository cropRepo;
    @Autowired
    private OrganicRepo organicRepo;

    public void saveAll(OrganicProcessWrapper wrapper){

        CropEntity crop = cropRepo.findById(wrapper.getCropId())
                .orElseThrow(() -> new RuntimeException("Crop not found"));

        // delete old data
        organicRepo.deleteByCrop_Id(wrapper.getCropId());

        for(OrganicProcessEntity stage : wrapper.getStages()){

            if(stage.getStageName() == null || stage.getStageName().isBlank()){
                continue;
            }

            stage.setCrop(crop);
        }

        organicRepo.saveAll(wrapper.getStages());
    }

    @Transactional
    public void deleteAllCropId(Long cropId){
        organicRepo.deleteByCrop_Id(cropId);
    }

    // Organic
    public List<OrganicProcessEntity> getOrganicProcess(Long cropId){
        return organicRepo.findByCrop_IdOrderByStageOrder(cropId);
    }


}
