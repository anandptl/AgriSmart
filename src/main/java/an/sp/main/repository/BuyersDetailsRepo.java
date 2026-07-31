package an.sp.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import an.sp.main.entities.buyerCropEntity;

import java.util.List;

@Repository
public interface BuyersDetailsRepo extends JpaRepository<buyerCropEntity, Long> {

    buyerCropEntity findByUser_Id(Long userId);
}