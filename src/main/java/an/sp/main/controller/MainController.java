package an.sp.main.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import an.sp.main.entities.CropEntity;
import an.sp.main.service.CropService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import an.sp.main.entities.UserProfile;
import an.sp.main.entities.UsersEntity;
import an.sp.main.entities.buyerCropEntity;
import an.sp.main.service.ProfileService;
import an.sp.main.service.UserActivityService;
import an.sp.main.service.buyersFarmerDetailsService;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

	@Autowired
	private UserActivityService userActivityService;

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