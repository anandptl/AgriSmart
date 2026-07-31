package an.sp.main.repository;

import an.sp.main.entities.OrganicProcessEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface OrganicRepo extends JpaRepository<OrganicProcessEntity, Long> {

    @Modifying
    @Transactional
    void deleteByCrop_Id(Long cropId);

    List<OrganicProcessEntity> findByCrop_IdOrderByStageOrder(Long cropId);

}
