package an.sp.main.service;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.buyerCropEntity;
import an.sp.main.repository.BuyersDetailsRepo;
import an.sp.main.repository.UserProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class buyersFarmerDetailsService {
    @Autowired
    private BuyersDetailsRepo buyersDetailsRepo;

    @Autowired
    private UserProfileRepository userProfileRepository;

    //  Find all buyers
    public List<UserProfile> getAllBuyers() {

        return userProfileRepository.findAllBuyers();
    }
//    find all farmers
    public List<UserProfile> getAllFarmers() {

        return userProfileRepository.findAllFarmer();
    }

    public buyerCropEntity getCropById(Long userId){
        return buyersDetailsRepo.findByUser_Id(userId);
    }

    public List<UserProfile> searchBuyers(String name,String district, String crop) {
        return userProfileRepository.searchBuyers(name,district, crop);
    }

    public List<UserProfile> searchFarmers(String name,String district, String crop) {
        return userProfileRepository.searchFarmers(name, district, crop);
    }

}
