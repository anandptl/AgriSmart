package an.sp.main.service;


import an.sp.main.entities.CropEntity;
import an.sp.main.entities.InOrganicProcessEntity;
import an.sp.main.entities.OrganicProcessEntity;
import an.sp.main.repository.CropRepository;
import an.sp.main.repository.InorganicRepo;
import an.sp.main.wrapper.InOrganicProcessWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class InorganicService {
    @Autowired
    private CropRepository cropRepo;
    @Autowired
    private InorganicRepo inorganicRepo;

    public void saveAll(InOrganicProcessWrapper wrapper){

        CropEntity crop = cropRepo.findById(wrapper.getCropId())
                .orElseThrow(() -> new RuntimeException("Crop not found"));

        // delete old data
        inorganicRepo.deleteByCrop_Id(wrapper.getCropId());

        for(InOrganicProcessEntity stage : wrapper.getStages()){

            if(stage.getStageName() == null || stage.getStageName().isBlank()){
                continue;
            }

            stage.setCrop(crop);
        }

        inorganicRepo.saveAll(wrapper.getStages());
    }

    @Transactional
    public void deleteAllCropId(Long cropId){
        inorganicRepo.deleteByCrop_Id(cropId);
    }

    public List<InOrganicProcessEntity> getInOrganicProcess(Long cropId){
        return inorganicRepo.findByCrop_IdOrderByStageOrder(cropId);
    }

}
