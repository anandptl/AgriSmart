package an.sp.main.service;

import org.springframework.scheduling.annotation.Async;

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

    @Async
    public void sendOtp(String to, String otp) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            // Set custom application name as sender
            helper.setFrom(new InternetAddress("yourgmail@gmail.com", "AgriSmart"));

            helper.setTo(to);
            helper.setSubject("AgriSmart Password Reset OTP");

//            String  text= "Your OTP is: " + otp + "\nValid for 5 minutes.";
           String text =
                    "<div style='font-family:Arial, sans-serif; line-height:1.6; color:#333;'>" +

                            "<h2 style='color:#e74c3c;'>🔒 Password Reset Request</h2>" +

                            "<p>Dear User,</p>" +

                            "<p>" +
                            "We received a request to reset your <b>AgriSmart</b> account password." +
                            "</p>" +

                            "<p>Please use the OTP below to verify your identity and continue:</p>" +

                            "<div style='margin:20px 0; padding:15px; background:#fdf2f2; border-radius:8px; text-align:center;'>" +
                            "<span style='font-size:24px; font-weight:bold; color:#e74c3c; letter-spacing:3px;'>" +
                            otp +
                            "</span>" +
                            "</div>" +

                            "<p>⏱ <b>This OTP is valid for 5 minutes only.</b></p>" +

                            "<p style='color:#777; font-size:14px;'>" +
                            "If you did not request a password reset, please ignore this email. " +
                            "Your account remains secure." +
                            "</p>" +

                            "<br>" +
                            "<p>Stay Secure 🌾<br>" +
                            "<b>— Team AgriSmart</b></p>" +

                            "</div>";


            helper.setText(text, true);

            mailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace();

        }
    }
    
    
    public void sendSignupOtp(String to, String otp) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            // Set custom application name as sender
            helper.setFrom(new InternetAddress("yourgmail@gmail.com", "AgriSmart"));

            helper.setTo(to);
            helper.setSubject("AgriSmart Email Verification OTP");
            
            String html =
            	    "<div style='font-family:Arial, sans-serif; line-height:1.6; color:#333;'>" +

            	    "<h2 style='color:#2ecc71;'>🌱 Welcome to AgriSmart!</h2>" +

            	    "<p>Dear User,</p>" +

            	    "<p>" +
            	    "Thank you for joining <b>AgriSmart</b> — your smart companion for modern agriculture." +
            	    "</p>" +

            	    "<p>Please verify your email using the OTP below:</p>" +

            	    "<div style='margin:20px 0;'>" +
            	    "<span style='font-size:22px; font-weight:bold; color:#2ecc71; letter-spacing:2px;'>" +
            	    "🔐 OTP: " + otp +
            	    "</span>" +
            	    "</div>" +

            	    "<p>⏱ <b>This OTP is valid for 5 minutes.</b></p>" +

            	    "<p style='color:#777; font-size:14px;'>" +
            	    "If you did not request this registration, please ignore this email." +
            	    "</p>" +

            	    "<br>" +
            	    "<p>Happy Farming! 🌾<br>" +
            	    "<b>— Team AgriSmart</b></p>" +

            	    "</div>";
            helper.setText(html, true);

            mailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace();

        }
    }
}
