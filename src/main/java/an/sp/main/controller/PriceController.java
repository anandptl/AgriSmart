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
    public String farmerCropPrice(HttpSession session,
                                   Model model,
                                   @RequestParam(required = false) String crop) {

        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);
        model.addAttribute("user", user);

        // default crop list (same as farmer page)
        List<String> cropsToShow = Arrays.asList("Wheat", "Rice", "Paddy", "Cotton", "Maize", "Sugarcane");

        Map<String, Object> allCropPrices = new LinkedHashMap<>();

        String selectedCrop = crop != null ? crop.trim() : null;

        for (String cropName : cropsToShow) {

            if (selectedCrop != null && cropName.equalsIgnoreCase(selectedCrop)) {
                // fetch only searched crop
                allCropPrices.put(cropName, priceService.fetchCropPrice(cropName));
            } else if (selectedCrop != null) {
                // hide others
                continue;
            } else {
                allCropPrices.put(cropName, priceService.fetchCropPrice(cropName));
            }
        }

        model.addAttribute("allCropPrices", allCropPrices);
        model.addAttribute("selectedCrop", selectedCrop);

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

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);
        model.addAttribute("user", user);

        List<String> cropsToShow =
                Arrays.asList("Wheat", "Rice", "Paddy", "Cotton", "Maize", "Sugarcane");

        Map<String, Object> allCropPrices = new LinkedHashMap<>();

        for (String cropName : cropsToShow) {
            allCropPrices.put(cropName, priceService.fetchCropPrice(cropName));
        }

        model.addAttribute("allCropPrices", allCropPrices);

        // Search logic
        if (crop != null && !crop.trim().isEmpty()) {
            String selectedCrop = crop.trim();
            model.addAttribute("selectedCrop", selectedCrop);

            if (!cropsToShow.stream()
                    .anyMatch(c -> c.equalsIgnoreCase(selectedCrop))) {

                Map<String, Object> searchCropData =
                        priceService.fetchCropPrice(selectedCrop);

                model.addAttribute("searchCropData", searchCropData);
            }
        }

        return "Farmer-Price";
    }


    //    Buyers crop price controller
    @GetMapping("/buyers")
    public String buyersCropPrice(HttpSession session,
                                  Model model,
                                  @RequestParam(required = false) String crop) {

        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);
        model.addAttribute("user", user);

        // default crop list (same as farmer page)
        List<String> cropsToShow = Arrays.asList("Wheat", "Rice", "Paddy", "Cotton", "Maize", "Sugarcane");

        Map<String, Object> allCropPrices = new LinkedHashMap<>();

        String selectedCrop = crop != null ? crop.trim() : null;

        for (String cropName : cropsToShow) {

            if (selectedCrop != null && cropName.equalsIgnoreCase(selectedCrop)) {
                // fetch only searched crop
                allCropPrices.put(cropName, priceService.fetchCropPrice(cropName));
            } else if (selectedCrop != null) {
                // hide others
                continue;
            } else {
                allCropPrices.put(cropName, priceService.fetchCropPrice(cropName));
            }
        }

        model.addAttribute("allCropPrices", allCropPrices);
        model.addAttribute("selectedCrop", selectedCrop);

        return "Buyers-Price";
    }


    @GetMapping("/buyersCrop")
    public String buyersCropPriceSearch(HttpSession session,
                                   Model model,
                                   @RequestParam(required = false) String crop) {

        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);
        model.addAttribute("user", user);

        List<String> cropsToShow =
                Arrays.asList("Wheat", "Rice", "Paddy", "Cotton", "Maize", "Sugarcane");

        Map<String, Object> allCropPrices = new LinkedHashMap<>();

        for (String cropName : cropsToShow) {
            allCropPrices.put(cropName, priceService.fetchCropPrice(cropName));
        }

        model.addAttribute("allCropPrices", allCropPrices);

        // Search logic
        if (crop != null && !crop.trim().isEmpty()) {
            String selectedCrop = crop.trim();
            model.addAttribute("selectedCrop", selectedCrop);

            if (!cropsToShow.stream()
                    .anyMatch(c -> c.equalsIgnoreCase(selectedCrop))) {

                Map<String, Object> searchCropData =
                        priceService.fetchCropPrice(selectedCrop);

                model.addAttribute("searchCropData", searchCropData);
            }
        }

        return "Buyers-Price";
    }

}
