package an.sp.main.service;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class PriceService {

    public Map<String, Object> getCropPrice(String crop) {
        String apiUrl = "https://mandiapi.onrender.com/price?crop=" + crop;

        RestTemplate rest = new RestTemplate();
        Map<String, Object> response =
                rest.getForObject(apiUrl, Map.class);

        return response;
    }
}

