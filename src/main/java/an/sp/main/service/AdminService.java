package an.sp.main.service;

import an.sp.main.repository.AdminRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
    @Autowired
    private AdminRepo adminRepo;

    // COUNT BUYERS
    public long getTotalBuyers() {
        return adminRepo.countByRole("BUYER");
    }

    // COUNT FARMERS
    public long getTotalFarmers() {
        return adminRepo.countByRole("FARMER");
    }


}
