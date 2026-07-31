package an.sp.main.repository;

import an.sp.main.entities.InOrganicProcessEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface InorganicRepo extends JpaRepository<InOrganicProcessEntity, Long> {

    @Modifying
    @Transactional
    void deleteByCrop_Id(Long cropId);

    List<InOrganicProcessEntity> findByCrop_IdOrderByStageOrder(Long cropId);

}
