package an.sp.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.service.ProfileService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/Price")
public class PriceController {

	@Autowired
	private ProfileService profileService;

//	@Autowired
//	private PriceService priceService;

	// @Value("${price.api.key}")
	// private String apiKey;

	// @Value("${price.api.url}")
	// private String baseUrl;
	@GetMapping("/farmer")
	public String pricePage(HttpSession session, Model model) {
			UsersEntity user = (UsersEntity) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}

		// Profile Show
		UserProfile profile = profileService.getProfileByUserId(user.getId());
		model.addAttribute("profile", profile);
		return"Farmer-Price";
	}
	

	// @GetMapping("/Pfarmer")
	// public String cropPricePage(HttpSession session, Model model, @RequestParam(required = false) String crop) {

	// 	UsersEntity user = (UsersEntity) session.getAttribute("user");
	// 	if (user == null) {
	// 		return "redirect:/login";
	// 	}

	// 	// Profile Show
	// 	UserProfile profile = profileService.getProfileByUserId(user.getId());
	// 	model.addAttribute("profile", profile);

		// try {
		// 	// Agar crop type kiya to scraping kare
		// 	if (crop != null && !crop.isEmpty()) {
		// 		crop = "Rice";
		// 	}
			
		// 	String encodedCrop = URLEncoder.encode(crop.trim(), StandardCharsets.UTF_8);
	        
		// 	String api = baseUrl + "?key=" + apiKey + "&crop=" + encodedCrop + "&format=json";

		// 	RestTemplate rest = new RestTemplate();
			
		// 	Map<String, Object> cropData = rest.getForObject(api, Map.class);
			
		// 	model.addAttribute("cropData", cropData);
			
		// } catch (Exception e) {
		// 	System.out.println(e);
		// }

	// 	return "Farmer-Price"; // JSP Page Name
	// }
}
