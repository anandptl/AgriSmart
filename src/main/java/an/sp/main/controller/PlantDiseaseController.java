package an.sp.main.controller;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.service.PlantDiseaseService;
import an.sp.main.service.ProfileService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Controller
public class PlantDiseaseController {

    @Autowired
    private PlantDiseaseService plantDiseaseService;

    @Autowired
    private ProfileService profileService;

    @GetMapping("/disease-check")
    public String uploadPage(HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);
        return "Farmer-cropDisease";   // upload.jsp
    }

    @PostMapping("/detect-disease")
    public String detectDisease(@RequestParam("image") MultipartFile file,HttpSession session, Model model) {
        UsersEntity user = (UsersEntity) session.getAttribute("user");

        UserProfile profile = profileService.getProfileByUserId(user.getId());
        model.addAttribute("profile", profile);

        Map<String,String> data = plantDiseaseService.detectDisease(file);

        model.addAttribute("crop", data.get("crop"));
        model.addAttribute("disease", data.get("disease"));
        model.addAttribute("confidence", data.get("confidence"));
        model.addAttribute("organic", data.get("organic"));
        model.addAttribute("chemical", data.get("chemical"));
        model.addAttribute("prevention", data.get("prevention"));

        return "Farmer-cropDisease";  // result.jsp
    }
}
