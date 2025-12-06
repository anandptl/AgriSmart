package an.sp.main.service;

import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendOtp(String to, String otp) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            // Set custom application name as sender
            helper.setFrom(new InternetAddress("yourgmail@gmail.com", "AgriSmart App"));

            helper.setTo(to);
            helper.setSubject("AgriSmart Password Reset OTP");

            String text = "Your OTP is: " + otp + "\nValid for 5 minutes.";

            helper.setText(text);

            mailSender.send(message);

        } catch (Exception e) {
            System.out.print(e);
        }
    }
}
