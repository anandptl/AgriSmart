package an.sp.main.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "organic_process")
public class OrganicProcessEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer stageOrder;     // sequence maintain करने के लिए
    private String stageName;
    private String dayRange;

    @Column(length = 3000)
    private String description;

    @ManyToOne
    @JoinColumn(name = "crop_id", nullable = false)
    private CropEntity crop;

    // ================= Getters & Setters =================

    public Long getId() {
        return id;
    }

    public Integer getStageOrder() {
        return stageOrder;
    }

    public void setStageOrder(Integer stageOrder) {
        this.stageOrder = stageOrder;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStageName() {
        return stageName;
    }

    public void setStageName(String stageName) {
        this.stageName = stageName;
    }

    public String getDayRange() {
        return dayRange;
    }

    public void setDayRange(String dayRange) {
        this.dayRange = dayRange;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public CropEntity getCrop() {
        return crop;
    }

    public void setCrop(CropEntity crop) {
        this.crop = crop;
    }

}
