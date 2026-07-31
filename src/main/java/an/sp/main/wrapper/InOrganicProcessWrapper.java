package an.sp.main.wrapper;

import java.util.List;
import an.sp.main.entities.InOrganicProcessEntity;

public class InOrganicProcessWrapper {

    private Long cropId;
    private List<InOrganicProcessEntity> stages;

    // ================= Getter & Setter =================

    public Long getCropId() {
        return cropId;
    }

    public void setCropId(Long cropId) {
        this.cropId = cropId;
    }

    public List<InOrganicProcessEntity> getStages() {
        return stages;
    }

    public void setStages(List<InOrganicProcessEntity> stages) {
        this.stages = stages;
    }
}
