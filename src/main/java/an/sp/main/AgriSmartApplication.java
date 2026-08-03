package an.sp.main;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class AgriSmartApplication {

    public static void main(String[] args) {
        SpringApplication.run(AgriSmartApplication.class, args);
        System.out.println("AgriSmartApplication started successfully!");
    }

}