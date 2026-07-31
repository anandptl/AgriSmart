package an.sp.main.controller;

import an.sp.main.entities.CropEntity;
import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class FarmerController {

    @Autowired
    private ProfileService profileService;

    @Autowired
    private buyersFarmerDetailsService buyersFarmerDetailsService;

    @Autowired
    private CropService cropService;

    @Autowired
    private FarmerCropService farmerCropService;

    @Autowired
    private InorganicService inorganicService;

    @Autowired
    private OrganicService organicService;

    @Value("${weather.api.key}")
    private String apiKey;

    @Value("${weather.api.url}")
    private String baseUrl;


    //    farmer Controller
    @GetMapping("/dashboard")
    public String Dashboard(HttpSession session, Model model, String city) {
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

        return "dashboard";
    }

    @GetMapping("/Far-profile")
    public String profilePage(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);
        return "Farmer-profile";
    }

    @GetMapping("/crop-Sugges")
    public String CropSuggestion(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

         // Crop list
        List<CropEntity> cropList = cropService.getAllCrops();
        model.addAttribute("cropList", cropList);

        // apply crop record
        List<Long> appliedIds = farmerCropService.getAppliedCropIds(user.getId());
        model.addAttribute("appliedIds", appliedIds);

        return "Crop-Sugges";
    }

    @GetMapping("/crop-Process")
    public String CropProcess(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        // apply crop record
        List<CropEntity> appliedCrops = farmerCropService.getAppliedCropName(user.getId());
        model.addAttribute("appliedCrops", appliedCrops );

        return "Farmers-Crop-Process";
    }

    @GetMapping("/crop-Sugges/filter")
    public String filterCrops(
            @RequestParam(required = false) String soilType,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String season,
            @RequestParam(required = false) String waterNeed,
            @RequestParam(required = false) String climate,
            Model model,
            HttpSession session
    ) {

        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<CropEntity> cropList = cropService.filterCrops(soilType, category, season, waterNeed, climate);
        model.addAttribute("cropList", cropList);

        List<Long> appliedIds = farmerCropService.getAppliedCropIds(user.getId());
        model.addAttribute("appliedIds", appliedIds);

        return "fragments/crop-list";
    }

    // This controller used in framer page to find the buyers
    @GetMapping("/buyers-details")
    public String buyersDetails(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        model.addAttribute("buyers", buyersFarmerDetailsService.getAllBuyers());
        return "Farmers_details";
    }

    //  This controller used for find the particuler buyers by City & crop name..
    @GetMapping("/farmer/buyers/search")
    public String searchBuyers(HttpSession session,
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

        List<UsersEntity> buyers = buyersFarmerDetailsService.searchBuyers(name,district,crop);

        model.addAttribute("buyers", buyers);
        return "Farmers_details";
    }


    // Apply & Unapply controller ...
    @GetMapping("/farmer/crop/apply/{cropId}")
    public String applyCrop(@PathVariable Long cropId,
                            HttpSession session) {

        UsersEntity user =
                (UsersEntity) session.getAttribute("user");

        farmerCropService.applyCrop(cropId, user.getId());

        return "redirect:/crop-Sugges";
    }

    @GetMapping("/farmer/crop/unapply/{cropId}")
    public String unapplyCrop(@PathVariable Long cropId,
                              HttpSession session) {

        UsersEntity user =
                (UsersEntity) session.getAttribute("user");

        farmerCropService.unapplyCrop(cropId, user.getId());

        return "redirect:/crop-Sugges";
    }

    // When Crop Selected
    @GetMapping("/process/details")
    public String getCropProcess( @RequestParam Long cropId, Model model){

        model.addAttribute("organicList",
                organicService.getOrganicProcess(cropId));

        model.addAttribute("inorganicList",
                inorganicService.getInOrganicProcess(cropId));

        return "fragments/farmer-process-table";
    }

    // Search crop
    @GetMapping("/process/search")
    public String search(@RequestParam String cropName,
                         Model model){

        Optional<CropEntity> crop = cropService.findCropByName(cropName);

        if(crop.isPresent()){

            Long id = crop.get().getId();

            model.addAttribute("organicList",
                    organicService.getOrganicProcess(id));

            model.addAttribute("inorganicList",
                    inorganicService.getInOrganicProcess(id));
        }

        return "fragments/farmer-process-table";
    }

}
