package an.sp.main.entities;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "user_activity")
public class UserActivityEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private LocalDateTime lastSeen;

    @Transient
    private String lastSeenFormatted;

    @Transient
    private boolean online;


    @OneToOne
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private UsersEntity user;

    // getters & setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) { this.id = id; }

    public LocalDateTime getLastSeen() {
        return lastSeen;
    }

    public void setLastSeen(LocalDateTime lastSeen) {
        this.lastSeen = lastSeen;
    }

    public String getLastSeenFormatted() {
        return lastSeenFormatted;
    }

    public void setLastSeenFormatted(String lastSeenFormatted) {
        this.lastSeenFormatted = lastSeenFormatted;
    }

    public UsersEntity getUser() {
        return user;
    }

    public void setUser(UsersEntity user) {
        this.user = user;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
