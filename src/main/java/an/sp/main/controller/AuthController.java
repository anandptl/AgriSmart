package an.sp.main.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.service.AuthService;
import an.sp.main.service.ProfileService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class AuthController {

	@Autowired
	private AuthService authService;

	@Autowired
	private ProfileService profileService;

	@Value("${weather.api.key}")
	private String apiKey;

	@Value("${weather.api.url}")
	private String baseUrl;

	@PostMapping("/signup")
	public String signup(@ModelAttribute UsersEntity user, Model model) {

		UsersEntity existing = authService.getByEmail(user.getEmail());

		if (existing != null) {
			model.addAttribute("Error", "User already registered! Please login.");
			return "login";
		}

		boolean status = authService.register(user);
		if (status) {
			model.addAttribute("Successfull", "Account Created! Please Login.");
		} else {
			model.addAttribute("Error", "User not Registered due to some error");
		}
		return "login";
	}

	@PostMapping("/login")
	public String login(@RequestParam String email, @RequestParam String password, @RequestParam String role,
			HttpSession session, Model model, String city) {

		try {
			String token = authService.login(email, password, role);

			UsersEntity user = authService.getByEmail(email);

			session.setAttribute("token", token);
			session.setAttribute("user", user);
			session.setAttribute("role", user.getRole());

			switch (user.getRole().toUpperCase()) {
			case "FARMER":

				UserProfile farmer = profileService.getProfileByUserId(user.getId());
				model.addAttribute("profile", farmer);
				model.addAttribute("Successfull", "Welcome :" + user.getFirstName());

				city = farmer != null && farmer.getCity() != null ? farmer.getCity() : "Ghaziabad";

				String api = baseUrl + "?key=" + apiKey + "&q=" + city + "&days=10";
				RestTemplate rest = new RestTemplate();
				Map<String, Object> response = rest.getForObject(api, Map.class);

				model.addAttribute("weather", response);

				return "dashboard";

			case "BUYER":
				UserProfile buyer = profileService.getProfileByUserId(user.getId());
				model.addAttribute("profile", buyer);
				model.addAttribute("Successfull", "Welcome :" + user.getFirstName());

				city = buyer != null && buyer.getCity() != null ? buyer.getCity() : "Ghaziabad";

				String api1 = baseUrl + "?key=" + apiKey + "&q=" + city + "&days=10";
				RestTemplate rest1 = new RestTemplate();
				Map<String, Object> response1 = rest1.getForObject(api1, Map.class);

				model.addAttribute("weather", response1);

				return "buyer-dashboard";

			case "ADMIN":
				model.addAttribute("Successfull", "Welcome :" + user.getFirstName());
				return "admin-panel";

			default:
				model.addAttribute("Error", "Invalid Role!");
				return "login";
			}

		} catch (Exception e) {
			model.addAttribute("Error", e.getMessage());
			model.addAttribute("Error", "Something went wrong");
			System.out.println(e);
			return "login";
		}
	}
	

// forget possword controller...... 

	@GetMapping("/forget")
	public String forgetpageoprn() {
		return"forgot-password";
	}
	
	@PostMapping("/forgot-password")
	public String forgotPassword(@RequestParam String email, Model model) {

		String msg = authService.sendOtp(email);

		if (msg.contains("not registered")) {
			model.addAttribute("Error", msg);
			return "forgot-password";
		}

		model.addAttribute("Success", msg);
		model.addAttribute("email", email);

		return "verify-otp";
	}

	@PostMapping("/verify-otp")
	public String verifyOtp(@RequestParam String email, @RequestParam String otp, Model model) {

		boolean valid = authService.verifyOtp(email, otp);

		if (!valid) {
			model.addAttribute("Error", "Invalid or expired OTP!");
			model.addAttribute("email", email);
			return "verify-otp";
		}

		model.addAttribute("email", email);
		return "reset-password";
	}

	@PostMapping("/reset-password")
	public String resetPassword(@RequestParam String email, @RequestParam String newPassword, Model model) {

		boolean status = authService.resetPassword(email, newPassword);

		if (!status) {
			model.addAttribute("Error", "Failed to reset password!");
			return "reset-password";
		}

		model.addAttribute("Successfull", "Password reset successfully!");
		return "login";
	}
}
