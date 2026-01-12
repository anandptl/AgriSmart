package an.sp.main.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "buyer_crop")
public class buyerCropEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "user_id", unique = true)
    private UsersEntity user;

    @Column(nullable = false)
    private String crop1;

    private String crop2;

    private String crop3;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public UsersEntity getUser() {
        return user;
    }

    public void setUser(UsersEntity user) {
        this.user = user;
    }

    public String getCrop1() {
        return crop1;
    }

    public void setCrop1(String crop1) {
        this.crop1 = crop1;
    }

    public String getCrop2() {
        return crop2;
    }

    public void setCrop2(String crop2) {
        this.crop2 = crop2;
    }

    public String getCrop3() {
        return crop3;
    }

    public void setCrop3(String crop3) {
        this.crop3 = crop3;
    }
}
