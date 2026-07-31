package an.sp.main.controller;

import java.time.LocalDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import an.sp.main.entities.UsersEntity;
import an.sp.main.service.UserActivityService;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

	@Autowired
	private UserActivityService userActivityService;

	@GetMapping("/test")
	@ResponseBody
	public String test() {
		return "AgriSmart is Working";
	}

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