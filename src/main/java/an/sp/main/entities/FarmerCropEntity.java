package an.sp.main.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "farmer_crops",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"farmer_id", "crop_id"})
        })
public class FarmerCropEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Connect with UsersEntity
    @ManyToOne
    @JoinColumn(name = "farmer_id", nullable = false)
    private UsersEntity farmer;

    // Connect with CropEntity
    @ManyToOne
    @JoinColumn(name = "crop_id", nullable = false)
    private CropEntity crop;

    // getters & setters


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public UsersEntity getFarmer() {
        return farmer;
    }

    public void setFarmer(UsersEntity farmer) {
        this.farmer = farmer;
    }

    public CropEntity getCrop() {
        return crop;
    }

    public void setCrop(CropEntity crop) {
        this.crop = crop;
    }
}
