package an.sp.main.controller;


import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.entities.buyerCropEntity;
import an.sp.main.service.ProfileService;
import an.sp.main.service.UserActivityService;
import an.sp.main.service.buyersFarmerDetailsService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

@Controller
public class BuyersController {

    @Autowired
    private ProfileService profileService;

    @Autowired
    private buyersFarmerDetailsService buyersFarmerDetailsService;

    @Value("${weather.api.key}")
    private String apiKey;

    @Value("${weather.api.url}")
    private String baseUrl;


    // buyers controllers
    @GetMapping("/buyer-dashboard")
    public String BuyerDashboard(HttpSession session, Model model, String city) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        try {
            city = profile != null && profile.getCity() != null ? profile.getCity() : "Ghaziabad";


            String api = baseUrl + "?key=" + apiKey + "&q=" + city + "&days=10";
            RestTemplate rest = new RestTemplate();
            Map<String, Object> response = rest.getForObject(api, Map.class);

            model.addAttribute("weather", response);
        } catch (Exception e) {
            System.err.println("Weather API Error: " + e.getMessage());
        }

        return "buyer-dashboard";
    }

    @GetMapping("/buyer-profile")
    public String BuyerprofilePage(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        buyerCropEntity crop = buyersFarmerDetailsService.getCropById(user.getId());
        model.addAttribute("buyerCrop", crop);
        return "buyer-profile";
    }

    // This controller used in Buyers page to find the farmer
    @GetMapping("/Farmer-details")
    public String FarmerDetails(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        model.addAttribute("farmers", buyersFarmerDetailsService.getAllFarmers());
        return "Buyers_details";
    }
    //  This controller used for find the particuler Farmers by City & crop name..
    @GetMapping("/buyers/farmer/search")
    public String searchFarmers(HttpSession session,
                                @RequestParam(required = false) String name,
                                @RequestParam(required = false) String district,
                                @RequestParam(required = false) String crop,
                                Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        List<UsersEntity> buyers = buyersFarmerDetailsService.searchFarmers(name, district, crop);
        model.addAttribute("farmers", buyers);
        return "Buyers_details";
    }
}
