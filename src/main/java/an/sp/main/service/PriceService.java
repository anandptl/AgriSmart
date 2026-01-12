package an.sp.main.service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class PriceService {
    @Value("${price.api.key}")
    private String apiKey;

    @Value("${price.api.url}")
    private String baseUrl;

    private final RestTemplate rest = new RestTemplate();

    @SuppressWarnings("unchecked")
    public Map<String, Object> fetchCropPrice(String crop) {
        if (crop == null || crop.trim().isEmpty()) {
            return null;
        }

        String encodedCrop = URLEncoder.encode(crop.trim(), StandardCharsets.UTF_8);

        String endpoint = baseUrl
                + "?api-key=" + URLEncoder.encode(apiKey, StandardCharsets.UTF_8)
                + "&filters[commodity]=" + encodedCrop
                + "&format=json"
                + "&limit=1"; // only latest/matching single record

        try {
            ResponseEntity<Map> resp = rest.getForEntity(endpoint, Map.class);
            return resp.getBody();
        } catch (Exception ex) {
            System.err.println("PriceService: request failed -> " + ex.getMessage());
            return null;
        }
    }
}
