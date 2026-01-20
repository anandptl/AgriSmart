package an.sp.main.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import an.sp.main.entities.UserActivityEntity;
import an.sp.main.service.AuthService;
import an.sp.main.service.UserActivityService;
import an.sp.main.service.buyersFarmerDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.entities.buyerCropEntity;
import an.sp.main.service.ProfileService;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

	@Autowired
	private ProfileService profileService;

	@Autowired
	private  buyersFarmerDetailsService buyersFarmerDetailsService;

	@Autowired
	private UserActivityService userActivityService;



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

		List<UserProfile> buyers = buyersFarmerDetailsService.searchBuyers(name,district, crop);

		model.addAttribute("buyers", buyers);
		return "Farmers_details";
	}



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

		List<UserProfile> buyers = buyersFarmerDetailsService.searchFarmers(name, district, crop);
		model.addAttribute("farmers", buyers);
		return "Buyers_details";
	}
	
	
//	both controller 

	@GetMapping("/logout")
	public String logout(HttpSession session, Model model) {

		UsersEntity user = (UsersEntity) session.getAttribute("user");
		if (user != null && user.getActivity() != null) {
			user.getActivity().setLastSeen(LocalDateTime.now().minusMinutes(10));
			userActivityService.saveActivity(user.getActivity());
		}
		session.invalidate();
		model.addAttribute("Successfull", "You have logged out successfully!");
		return "login"; // JSP page
	}
}