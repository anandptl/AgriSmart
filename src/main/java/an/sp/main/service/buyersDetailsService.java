package an.sp.main.service;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.buyerCropEntity;
import an.sp.main.repository.BuyersDetailsRepo;
import an.sp.main.repository.UserProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class buyersDetailsService {
    @Autowired
    private BuyersDetailsRepo buyersDetailsRepo;

    @Autowired
    private UserProfileRepository userProfileRepository;

    public List<UserProfile> getAllBuyers() {

        return userProfileRepository.findAllBuyers();
    }

    public buyerCropEntity getCropById(Long userId){
        return buyersDetailsRepo.findByUser_Id(userId);
    }

    public List<UserProfile> searchBuyers(String district, String crop) {
        return userProfileRepository.searchBuyers(district, crop);
    }

}
