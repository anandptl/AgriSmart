package an.sp.main.controller;

import java.util.Map;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.service.ProfileService;
import an.sp.main.service.PriceService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/Price")
public class PriceController {

    @Autowired
    private ProfileService profileService;

    @Autowired
    private PriceService priceService;

    @GetMapping("/farmer")
    public String farmerPage(HttpSession session, Model model) {

        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        // Profile show
        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);
        model.addAttribute("user", user);

        // Crops to display on page open (change list if needed)
        List<String> cropsToShow = Arrays.asList("Wheat", "Paddy", "Cotton", "Maize", "Sugarcane");

        // Map: cropName -> API response (Map) OR null on error
        Map<String, Object> allCropPrices = new LinkedHashMap<>();
        for (String cropName : cropsToShow) {
            try {
                Map<String, Object> cropData = priceService.fetchCropPrice(cropName);
                allCropPrices.put(cropName, cropData);
            } catch (Exception e) {
                e.printStackTrace();
                allCropPrices.put(cropName, null);
            }
        }

        model.addAttribute("allCropPrices", allCropPrices);
        model.addAttribute("pricesFetchedAt", java.time.Instant.now().toString());

        return "Farmer-Price";
    }

    @GetMapping("/farmerCrop")
    public String farmerCropSearch(HttpSession session,
                                   Model model,
                                   @RequestParam(required = false) String crop) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        // Profile show
        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);
        model.addAttribute("user", user);

        if (crop == null || crop.trim().isEmpty()) {
            crop = "Paddy";
        }

        String chosenCrop = crop.trim();
        try {
            Map<String, Object> cropData = priceService.fetchCropPrice(chosenCrop);
            model.addAttribute("cropData", cropData);
            model.addAttribute("selectedCrop", chosenCrop);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("apiError", "Price API error: " + e.getMessage());
        }

        return "Farmer-Price";
    }
}
