package an.sp.main.controller;

import java.time.format.DateTimeFormatter;
import java.util.List;

import an.sp.main.entities.ContactMessage;
import an.sp.main.repository.ContactRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.service.AdminService;
import an.sp.main.service.CropService;
import an.sp.main.service.ProfileService;
import an.sp.main.service.UserActivityService;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private UserActivityService userActivityService;
    @Autowired
    private ProfileService profileService;
    @Autowired
    private AdminService adminService;
    @Autowired
    private CropService cropService;
    @Autowired
    private ContactRepository repo;

    @GetMapping("/Admin-Dash")
    public String profilePage(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        long unreadCount = repo.countByIsReadFalse();
        model.addAttribute("unreadCount", unreadCount);

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        long totalCrops = cropService.getTotalCrops();
        model.addAttribute("totalCrops", totalCrops);

        model.addAttribute("totalBuyers", adminService.getTotalBuyers());
        model.addAttribute("totalFarmers", adminService.getTotalFarmers());
        model.addAttribute("activeUsers", userActivityService.getActiveUsers());
        model.addAttribute("userList", userActivityService.getUsersWithStatus());
        return "AdminDash";
    }

    @GetMapping("/Admin-Users")
    public String FarmerDetails(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        long unreadCount = repo.countByIsReadFalse();
        model.addAttribute("unreadCount", unreadCount);

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        model.addAttribute("totalBuyers", adminService.getTotalBuyers());
        model.addAttribute("totalFarmers", adminService.getTotalFarmers());
        model.addAttribute("farmersList", userActivityService.getAllFarmer());
        model.addAttribute("buyersList", userActivityService.getAllBuyers());
        
        return "Admin-users";
    }


    @GetMapping("/Manage-Crops")
    public String ManageCrops(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        List<Object[]> cropCounts = cropService.getCropCountByCategory();
        model.addAttribute("cropCounts", cropCounts);

        long unreadCount = repo.countByIsReadFalse();
        model.addAttribute("unreadCount", unreadCount);
        return "Admin-Crop";
    }

    @GetMapping("/Crops-List")
    public String CropsLists(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        model.addAttribute("cropList", cropService.getAllCrops());

        long unreadCount = repo.countByIsReadFalse();
        model.addAttribute("unreadCount", unreadCount);

        return "Admin-Crop-List";
    }


//    filter crop list by category ......
    @GetMapping("/crops-filter-list")
    public String filterCropsByCategory(
            @RequestParam(required = false) String category,
            Model model){

        if(category == null || category.isBlank()){
            model.addAttribute("cropList", cropService.getAllCrops());
        } else {
            model.addAttribute("cropList", cropService.getCropsByCategory(category));
        }

        return "fragments/Admin-crop-table";
    }


    //  orgamin process page..
    @GetMapping("/Admin-Organic-Process")
    public String organicProcess(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        model.addAttribute("cropList", cropService.getAllCrops());

        long unreadCount = repo.countByIsReadFalse();
        model.addAttribute("unreadCount", unreadCount);

        return "AdminOrganicProcess";
    }

// inOrganic process page....
    @GetMapping("/Admin-Inorganic-Process")
    public String inOrganicProcess(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        model.addAttribute("cropList", cropService.getAllCrops());

        long unreadCount = repo.countByIsReadFalse();
        model.addAttribute("unreadCount", unreadCount);

        return "AdminInorganicProcess";
    }

    @GetMapping("/Analysis")
    public String AnlysisPage(HttpSession session, Model model) {

        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        model.addAttribute("totalCrops", cropService.getTotalCrops());
        model.addAttribute("totalBuyers", adminService.getTotalBuyers());
        model.addAttribute("totalFarmers", adminService.getTotalFarmers());
        model.addAttribute("activeUsers", userActivityService.getActiveUsers());

        model.addAttribute("cropCounts", cropService.getCropCountByCategory());

        // 🔥 ADD THIS (BAR GRAPH)
//        model.addAttribute("farmerCategoryData", farmerService.getFarmerCategoryData());

        model.addAttribute("unreadCount", repo.countByIsReadFalse());

        return "Analysis";
    }


//    Ajex searching for admin pagess....
    @GetMapping("/users/search/name")
    public String UserSearchByName(
            @RequestParam String keyword,
            Model model) {

        List<UsersEntity> userList = userActivityService.searchByName(keyword);

        model.addAttribute("userList", userList);

        return "fragments/active-user-list";
    }

//    find the farmer by the name
    @GetMapping("/admin/farmers/search")
    public String searchFarmers(
            @RequestParam String keyword,
            Model model) {

        List<UsersEntity> farmers = userActivityService.searchFarmersByName(keyword);

        model.addAttribute("farmersList", farmers);

        // JSP fragment return karo
        return "fragments/farmers-table-body";
    }

// Find the buyers by the name
    @GetMapping("/admin/buyers/search")
    public String searchBuyers(
            @RequestParam String keyword,
            Model model) {

        List<UsersEntity> buyers = userActivityService.searchBuyersByName(keyword);

        model.addAttribute("buyersList", buyers);

        // sirf tbody fragment
        return "fragments/buyers-table-body";
    }

    // BLOCK
    @GetMapping("/admin/user/block/{userId}")
    public String blockUser(
            @PathVariable Long userId,
            RedirectAttributes ra) {

        userActivityService.blockUser(userId);
        ra.addFlashAttribute("Successfull", "User blocked successfully");
        return "redirect:/Adnim-Users";
    }

    //  UNBLOCK users
    @GetMapping("/admin/user/unblock/{userId}")
    public String unblockUser(
            @PathVariable Long userId,
            RedirectAttributes ra) {

        userActivityService.unblockUser(userId);

        ra.addFlashAttribute("Successfull", "User unblocked successfully");
        return "redirect:/Adnim-Users";
    }


    @GetMapping("/admin/messages")
    public String viewMessages(HttpSession session, Model model){

        UsersEntity user = (UsersEntity) session.getAttribute("user");

        if(user == null){
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        repo.markAllAsRead();

        List<ContactMessage> messages = repo.findAllByOrderByCreatedAtDesc();

        long unreadCount = repo.countByIsReadFalse();
        model.addAttribute("unreadCount", unreadCount);

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("d MMM yyyy");

        messages.forEach(m -> {
            if(m.getCreatedAt() != null){
                m.setFormattedDate(m.getCreatedAt().format(formatter));
            }
        });

        model.addAttribute("messages", messages);

        return "Admin-Messages";
    }

    // delete message
    @GetMapping("/delete-message/{id}")
    public String deleteMessage(@PathVariable Long id){

        repo.deleteById(id);

        return "redirect:/admin/messages";
    }


}