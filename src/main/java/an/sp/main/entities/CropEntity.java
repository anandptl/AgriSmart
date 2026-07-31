package an.sp.main.entities;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "crops")
public class CropEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String cropName;
    private String soilType;
    private String category;
    private String season;
    private String waterNeed;
    private String climate;

    // Recommended
    private Integer growthDuration;

    // Optional
    private String temperature;
    private String rainfall;
    private String fertilizer;
    private String pestResistance;

    private Double minPrice;
    private Double maxPrice;

    @Lob
    private byte[] cropImage;
    private String cropImageName;

    @OneToMany(mappedBy = "crop", cascade = CascadeType.ALL)
    private java.util.List<OrganicProcessEntity> organicProcesses;

    @OneToMany(mappedBy = "crop", cascade = CascadeType.ALL)
    private java.util.List<InOrganicProcessEntity> inOrganicProcesses;

    @OneToMany(mappedBy = "crop", cascade = CascadeType.ALL)
    private List<FarmerCropEntity> farmerCrops;


    // getters & setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCropName() {
        return cropName;
    }

    public void setCropName(String cropName) {
        this.cropName = cropName;
    }

    public String getSoilType() {
        return soilType;
    }

    public void setSoilType(String soilType) {
        this.soilType = soilType;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSeason() {
        return season;
    }

    public void setSeason(String season) {
        this.season = season;
    }

    public String getWaterNeed() {
        return waterNeed;
    }

    public void setWaterNeed(String waterNeed) {
        this.waterNeed = waterNeed;
    }

    public String getClimate() {
        return climate;
    }

    public void setClimate(String climate) {
        this.climate = climate;
    }

    public Integer getGrowthDuration() {
        return growthDuration;
    }

    public void setGrowthDuration(Integer growthDuration) {
        this.growthDuration = growthDuration;
    }

    public String getTemperature() {
        return temperature;
    }

    public void setTemperature(String temperature) {
        this.temperature = temperature;
    }

    public String getRainfall() {
        return rainfall;
    }

    public void setRainfall(String rainfall) {
        this.rainfall = rainfall;
    }

    public String getFertilizer() {
        return fertilizer;
    }

    public void setFertilizer(String fertilizer) {
        this.fertilizer = fertilizer;
    }

    public String getPestResistance() {
        return pestResistance;
    }

    public void setPestResistance(String pestResistance) {
        this.pestResistance = pestResistance;
    }

    public Double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Double minPrice) {
        this.minPrice = minPrice;
    }

    public Double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Double maxPrice) {
        this.maxPrice = maxPrice;
    }

    public byte[] getCropImage() {
        return cropImage;
    }

    public void setCropImage(byte[] cropImage) {
        this.cropImage = cropImage;
    }

    public String getCropImageName() {
        return cropImageName;
    }

    public void setCropImageName(String cropImageName) {
        this.cropImageName = cropImageName;
    }

    public List<OrganicProcessEntity> getOrganicProcesses() {
        return organicProcesses;
    }

    public void setOrganicProcesses(List<OrganicProcessEntity> organicProcesses) {
        this.organicProcesses = organicProcesses;
    }

    public List<InOrganicProcessEntity> getInOrganicProcesses() {
        return inOrganicProcesses;
    }

    public void setInOrganicProcesses(List<InOrganicProcessEntity> inOrganicProcesses) {
        this.inOrganicProcesses = inOrganicProcesses;
    }

    public List<FarmerCropEntity> getFarmerCrops() {
        return farmerCrops;
    }

    public void setFarmerCrops(List<FarmerCropEntity> farmerCrops) {
        this.farmerCrops = farmerCrops;
    }
}

