package an.sp.main.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.service.ProfileService;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;
@Controller
public class MainController {

	@Autowired
	private ProfileService profileService;
	
	@Value("${weather.api.key}")
	private String apiKey;

	@Value("${weather.api.url}")
	private String baseUrl;

	@GetMapping("/")
	public String openHomePage() {
		return "index";
	}

	@GetMapping("/login")
	public String openLoginPage() {
		return "login";
	}

	@GetMapping("/home")
	public String HomePage() {
		return "index";
	}

	@GetMapping("/contact")
	public String ContactPage() {
		return "contact";
	}

//	farmer Controller
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
		return "Crop-Sugges";
	}
	
//	@GetMapping("/FarmerPrice")
//	public String MandiPrices(HttpSession session, Model model) {
//		UsersEntity user = (UsersEntity) session.getAttribute("user");
//		if (user == null) {
//			return "redirect:/login";
//		}
//
//		UserProfile profile = profileService.getProfileByUserId(user.getId());
//		model.addAttribute("profile", profile);
//		return "Farmer-Price";
//	}
	
	
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
		return "buyer-profile";
	}
	
	
//	both controller 

	@GetMapping("/logout")
	public String logout(HttpSession session, Model model) {
		session.invalidate();
		model.addAttribute("Successfull", "You have logged out successfully!");
		return "login"; // JSP page
	}
}