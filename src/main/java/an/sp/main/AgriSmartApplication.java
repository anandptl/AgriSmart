package an.sp.main;

import java.awt.Desktop;
import java.net.URI;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class AgriSmartApplication {

	public static void main(String[] args) {
		SpringApplication.run(AgriSmartApplication.class, args);
		openHomePage();
		}
	
    private static void openHomePage() {
        try {
            String url = "http://localhost:8080/";
            Thread.sleep(2500); // wait 2.5 sec for server startup

            if (Desktop.isDesktopSupported()) {
                Desktop.getDesktop().browse(new URI(url));
                System.out.println("Browser opened at: " + url);
            } else {
                System.out.println("Desktop not supported, please open manually: " + url);
            }
        } catch (Exception e) {
            System.err.println("Failed to open browser automatically");
            e.printStackTrace();
        }
        
    }

}
