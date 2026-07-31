package an.sp.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import an.sp.main.entities.ContactMessage;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface ContactRepository extends JpaRepository<ContactMessage, Long> {
    List<ContactMessage> findAllByOrderByCreatedAtDesc();
    long countByIsReadFalse();

    @Modifying
    @Transactional
    @Query("UPDATE ContactMessage m SET m.isRead = true WHERE m.isRead = false")
    void markAllAsRead();

}