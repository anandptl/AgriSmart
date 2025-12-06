package an.sp.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.service.ProfileService;
import jakarta.servlet.http.HttpSession;

@Controller
public class WeatherController {

	@Autowired
	private ProfileService profileService;

	@Value("${weather.api.key}")
	private String apiKey;

	@Value("${weather.api.url}")
	private String baseUrl;

//	weather Api for Farmers....
	@GetMapping("/Fweather")
	public String FweathePage(HttpSession session, Model model, @RequestParam(required = false) String city) {

		UsersEntity user = (UsersEntity) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}

		UserProfile profile = profileService.getProfileByUserId(user.getId());
		model.addAttribute("profile", profile);

		try {
			if (city == null || city.trim().isEmpty()) {
				city = profile != null && profile.getCity() != null ? profile.getCity() : "Ghaziabad";
			}

			String api = baseUrl + "?key=" + apiKey + "&q=" + city + "&days=10";
			RestTemplate rest = new RestTemplate();
			Map<String, Object> response = rest.getForObject(api, Map.class);

			model.addAttribute("weather", response);
			model.addAttribute("city", city);
		} catch (Exception e) {
			System.err.println("Weather API Error: " + e.getMessage());
			model.addAttribute("message",
					"Your internet is not able to connect to Weather API. Please try again later.");
			return "weather-error";
		}
		
		return "Fweather";
	}
	
//	WEather controller for the Buyers..
	@GetMapping("/buyer-weather")
	public String BuyerweathePage(HttpSession session, Model model, @RequestParam(required = false) String city) {

		UsersEntity user = (UsersEntity) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}

		UserProfile profile = profileService.getProfileByUserId(user.getId());
		model.addAttribute("profile", profile);

		try {
			if (city == null || city.trim().isEmpty()) {
				city = profile != null && profile.getCity() != null ? profile.getCity() : "Ghaziabad";
			}

			String api = baseUrl + "?key=" + apiKey + "&q=" + city + "&days=10";
			RestTemplate rest = new RestTemplate();
			Map<String, Object> response = rest.getForObject(api, Map.class);

			model.addAttribute("weather", response);
			model.addAttribute("city", city);
		} catch (Exception e) {
			System.err.println("Weather API Error: " + e.getMessage());
			model.addAttribute("message",
					"Your internet is not able to connect to Weather API. Please try again later.");
			return "weather-error";
		}
		
		return "buyer-weather";
	}
	
	

//	index page weather 
	@GetMapping("/weather")
	public String weathePage(@RequestParam(required = false) String city, Model model) {
		if (city == null || city.trim().isEmpty()) {
			city = "Ghaziabad";
		}

		try {
			String api = baseUrl + "?key=" + apiKey + "&q=" + city + "&days=10";

			RestTemplate rest = new RestTemplate();
			Map<String, Object> response = rest.getForObject(api, Map.class);

			model.addAttribute("weather", response);
			model.addAttribute("city", city);
		} catch (Exception e) {
			System.err.println("Weather API Error: " + e.getMessage());
			model.addAttribute("message",
					"Your internet is not able to connect to Weather API. Please try again later.");
			return "weather-error";
		}

		return "Weather";
	}
	
//	error page controller
	@GetMapping("/errorWeather")
	public String errorWeather(HttpSession session, @RequestParam(required = false) String city, Model model) {
		
		UsersEntity user = (UsersEntity) session.getAttribute("user");
		if (user == null) {
			return "redirect:/weather";
		}

		switch (user.getRole().toUpperCase()) {
        case "FARMER": return "redirect:/Fweather";
        case "BUYER": return "redirect:/buyer-weather";
		}

		return "Weather";
	}
}
