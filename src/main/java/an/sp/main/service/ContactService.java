package an.sp.main.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import an.sp.main.entities.ContactMessage;
import an.sp.main.repository.ContactRepository;

@Service
public class ContactService {

    @Autowired
    private ContactRepository repo;

    public void saveMessage(ContactMessage msg){
        repo.save(msg);
    }

}