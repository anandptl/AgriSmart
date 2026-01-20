package an.sp.main.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.Map;

import an.sp.main.entities.UserActivityEntity;
import an.sp.main.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class AuthController {
	
    @Autowired
    private HttpSession session;

	@Autowired
	private AuthService authService;

	@Autowired
	private OtpService otpService;

	@Autowired
	private ProfileService profileService;

	@Autowired
	private AdminService adminService;

	@Autowired
	private UserActivityService userActivityService;

	@Value("${weather.api.key}")
	private String apiKey;

	@Value("${weather.api.url}")
	private String baseUrl;
	

	@PostMapping("/signup")
	public String signup(@ModelAttribute UsersEntity user, Model model) {
		
	    Boolean otpVerified = (Boolean) session.getAttribute("signupOtpVerified");

	    if (otpVerified == null || !otpVerified) {
	        model.addAttribute("Error", "Please verify OTP before signup");
	        return "login";
	    }

		UsersEntity existing = authService.getByEmail(user.getEmail());

		if (existing != null) {
			model.addAttribute("Error", "User already registered! Please login.");
			return "login";
		}

		boolean status = authService.register(user);
		
	    session.removeAttribute("signupOtp");
	    session.removeAttribute("signupOtpTime");
	    session.removeAttribute("signupEmail");
	    session.removeAttribute("signupOtpVerified");
		
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

			// ===== USER ACTIVITY HANDLE =====
			UserActivityEntity activity = user.getActivity();

			if (activity == null) {
				activity = new UserActivityEntity();
				activity.setUser(user);
			}

			activity.setLastSeen(LocalDateTime.now());

//			user.setActivity(activity);
			if (activity.getId() == null) {
				user.setActivity(activity);
			}
			userActivityService.saveActivity(activity);
			// ___________________________________

			session.setAttribute("token", token);
			session.setAttribute("user", user);
			session.setAttribute("role", user.getRole());

			switch (user.getRole().toUpperCase()) {
			case "FARMER":

				UserProfile farmer = profileService.getProfileByUserId(user.getId());
				model.addAttribute("profile", farmer);
				model.addAttribute("Successfull", "Welcome :" + user.getFirstName());

				city = farmer != null && farmer.getCity() != null ? farmer.getCity() : "Ghaziabad";

				String encodedCity = URLEncoder.encode(city.trim(), StandardCharsets.UTF_8);
				String api = baseUrl + "?key=" + apiKey + "&q=" + encodedCity + "&days=10";
				
				RestTemplate rest = new RestTemplate();
				Map<String, Object> response = rest.getForObject(api, Map.class);

				model.addAttribute("weather", response);

				return "dashboard";

			case "BUYER":
				UserProfile buyer = profileService.getProfileByUserId(user.getId());
				model.addAttribute("profile", buyer);
				model.addAttribute("Successfull", "Welcome :" + user.getFirstName());

				city = buyer != null && buyer.getCity() != null ? buyer.getCity() : "Ghaziabad";

				String encodedCity1 = URLEncoder.encode(city.trim(), StandardCharsets.UTF_8);
				String api1 = baseUrl + "?key=" + apiKey + "&q=" + encodedCity1 + "&days=10";
				
				RestTemplate rest1 = new RestTemplate();
				Map<String, Object> response1 = rest1.getForObject(api1, Map.class);

				model.addAttribute("weather", response1);

				return "buyer-dashboard";

			case "ADMIN":

				model.addAttribute("Successfull", "Welcome :" + user.getFirstName());
				UserProfile admin = profileService.getProfileByUserId(user.getId());
				model.addAttribute("profile", admin);
				model.addAttribute("totalBuyers", adminService.getTotalBuyers());
				model.addAttribute("totalFarmers", adminService.getTotalFarmers());
				model.addAttribute("activeUsers", userActivityService.getActiveUsers());
				model.addAttribute("userList", userActivityService.getUsersWithStatus());


				return "AdminDash";

			default:
				model.addAttribute("Error", "Invalid Role!");
				return "login";
			}

		} catch (Exception e) {
			model.addAttribute("Error", e.getMessage());
			System.out.println(e);
			return "login";
		}
	}
	

// Ajex forget possword controller......



	@GetMapping("/forget")
	public String forgetpageoprn() {
		return"forgot-password";
	}
	
	@PostMapping("/forgot-password")
	@ResponseBody
	public Map<String, String> sendFrogetOtp(@RequestBody Map<String, String> request){
		String email = request.get("email");
		String msg = otpService.sendOtp(email);

		if (msg.contains("not registered")) {
			return Map.of(
					"status", "error",
					"message", msg
			);
		}

		return Map.of(
				"status", "success",
				"message", msg
		);
	}
	@PostMapping("/verify-forgot-otp")
	@ResponseBody
	public Map<String, String> verifyForgotOtp(@RequestBody Map<String, String> request) {

		boolean valid = otpService.verifyOtp(
				request.get("email"),
				request.get("otp")
		);

		if (!valid) {
			return Map.of(
					"status", "error",
					"message", "Invalid or expired OTP"
			);
		}

		return Map.of(
				"status", "success",
				"message", "OTP verified"
		);
	}

	@PostMapping("/reset-password")
	@ResponseBody
	public Map<String, String> resetForgotPassword(@RequestBody Map<String, String> request) {

		boolean status = otpService.resetPassword(
				request.get("email"),
				request.get("newPassword")
		);

		if (!status) {
			return Map.of(
					"status", "error",
					"message", "Failed to reset password"
			);
		}

		return Map.of(
				"status", "success",
				"message", "Password reset successfully"
		);
	}
	
//	Ajex Signup controller 
	
	@PostMapping("/send-otp")
	@ResponseBody
	public Map<String, String> sendSignupOtp(@RequestBody Map<String, String> request) {

	    String email = request.get("email");
	    String msg = otpService.sendSignupOtp(email);

	    if (msg.contains("already")) {
	        return Map.of("status", "error", "message", msg);
	    }

	    return Map.of("status", "success", "message", msg);
	}
	
	@PostMapping("/signup-verify-otp")
	@ResponseBody
	public Map<String, String> verifySignupOtp(@RequestBody Map<String, String> request) {

	    boolean valid = otpService.verifySignupOtp(
	        request.get("email"),
	        request.get("otp")
	    );

	    if (!valid) {
	        return Map.of("status", "error", "message", "Invalid or expired OTP");
	    }

	    return Map.of("status", "success", "message", "OTP verified");
	}


}
