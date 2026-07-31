package an.sp.main.controller;

import java.time.LocalDateTime;

import an.sp.main.service.ContactService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import an.sp.main.entities.ContactMessage;

@RestController
@RequestMapping("/contact")
public class ContactController {

    @Autowired
    private ContactService service;

    @PostMapping("/send")
    public String sendMessage(@RequestBody ContactMessage msg){
        System.out.println("Message Received: " + msg.getName());
        msg.setCreatedAt(LocalDateTime.now());
        service.saveMessage(msg);

        return "Message sent successfully";
    }

}