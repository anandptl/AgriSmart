package an.sp.main.controller;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.service.ProfileService;
import an.sp.main.service.AuthService;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ProfileController {

    @Autowired
    private ProfileService profileService;

    @Autowired
    private AuthService authService;

    @PostMapping("/updateProfile")
    public String updateProfile(@RequestParam("village") String village,
            					@RequestParam("city") String city,
            					@RequestParam("district") String district,
            					@RequestParam("state") String state,
            					@RequestParam("country") String country,
            					@RequestParam("pincode") String pincode,
            					@RequestParam("phone") String phone,
                                @RequestParam("language") String language,
                                @RequestParam("profilePhoto") MultipartFile file,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        UsersEntity loggedInUser = (UsersEntity) session.getAttribute("user");

        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("Error", "Session expired. Please log in again.");
            return "redirect:/login";
        }

        try {
            UserProfile profile = profileService.getProfileByEmail(loggedInUser.getEmail());
            if (profile == null) {
                profile = new UserProfile();
                profile.setUser(loggedInUser);
            }

         // Save Address Fields
            profile.setVillage(village);
            profile.setCity(city);
            profile.setDistrict(district);
            profile.setState(state);
            profile.setCountry(country);
            profile.setPincode(pincode);
            profile.setPhone(phone);

            // Save Photo if uploaded
            if (!file.isEmpty()) {
                profile.setProfilePhoto(file.getBytes());
                profile.setProfilePhotoName(file.getOriginalFilename());
            }

            profileService.save(profile);

            
            loggedInUser.setLanguage(language);
            authService.register(loggedInUser);
            session.setAttribute("user", loggedInUser);

            redirectAttributes.addFlashAttribute("Successfull", "Profile updated successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("Error", "Something went wrong. Please try again.");
        }

        return "redirect:/Far-profile";
    }
    
    @PostMapping("/update-Buyer-Profile")
    public String updateByuerProfile(@RequestParam("village") String village,
            					@RequestParam("city") String city,
            					@RequestParam("district") String district,
            					@RequestParam("state") String state,
            					@RequestParam("country") String country,
            					@RequestParam("pincode") String pincode,
            					@RequestParam("phone") String phone,
                                @RequestParam("language") String language,
                                @RequestParam("profilePhoto") MultipartFile file,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        UsersEntity loggedInUser = (UsersEntity) session.getAttribute("user");

        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("Error", "Session expired. Please log in again.");
            return "redirect:/login";
        }

        try {
            UserProfile profile = profileService.getProfileByEmail(loggedInUser.getEmail());
            if (profile == null) {
                profile = new UserProfile();
                profile.setUser(loggedInUser);
            }

         // Save Address Fields
            profile.setVillage(village);
            profile.setCity(city);
            profile.setDistrict(district);
            profile.setState(state);
            profile.setCountry(country);
            profile.setPincode(pincode);
            profile.setPhone(phone);

            // Save Language
//            profile.setLanguage(language);

            // Save Photo if uploaded
            if (!file.isEmpty()) {
                profile.setProfilePhoto(file.getBytes());
                profile.setProfilePhotoName(file.getOriginalFilename());
            }

            profileService.save(profile);

//            loggedInUser.setPhone(phone);
            loggedInUser.setLanguage(language);
            authService.register(loggedInUser);
            session.setAttribute("user", loggedInUser);

            redirectAttributes.addFlashAttribute("Successfull", "Profile updated successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("Error", "Something went wrong. Please try again.");
        }

        return "redirect:/buyer-profile";
    }

    
    @GetMapping("/user/photo/{id}")
    @ResponseBody
    public ResponseEntity<byte[]> getPhoto(@PathVariable Long id) {

        UserProfile profile = profileService.getProfileByUserId(id);

        if (profile != null && profile.getProfilePhoto() != null) {

            String fileName = profile.getProfilePhotoName();
            MediaType mediaType = MediaType.APPLICATION_OCTET_STREAM;

            if (fileName != null) {
                String lower = fileName.toLowerCase();
                if (lower.endsWith(".png")) {
                    mediaType = MediaType.IMAGE_PNG;
                } else if (lower.endsWith(".jpg") || lower.endsWith(".jpeg")) {
                    mediaType = MediaType.IMAGE_JPEG;
                } else if (lower.endsWith(".gif")) {
                    mediaType = MediaType.IMAGE_GIF;
                } else if (lower.endsWith(".webp")) {
                    mediaType = MediaType.parseMediaType("image/webp");
                }
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileName + "\"")
                    .contentType(mediaType)
                    .body(profile.getProfilePhoto());
        }

        return ResponseEntity.notFound().build();
    }
}
