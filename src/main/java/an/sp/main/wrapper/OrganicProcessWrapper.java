package an.sp.main.wrapper;

import java.util.List;
import an.sp.main.entities.OrganicProcessEntity;

public class OrganicProcessWrapper {

    private Long cropId;
    private List<OrganicProcessEntity> stages;

    public Long getCropId() {
        return cropId;
    }

    public void setCropId(Long cropId) {
        this.cropId = cropId;
    }

    public List<OrganicProcessEntity> getStages() {
        return stages;
    }

    public void setStages(List<OrganicProcessEntity> stages) {
        this.stages = stages;
    }
}

