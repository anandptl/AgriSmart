package an.sp.main.service;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@Service
public class PlantDiseaseService {

    @Value("${disease.api.key}")
    private String apiKey;

    @Value("${disease.api.url}")
    private String healthUrl;

    @Value("${plant.api.url}")
    private String identifyUrl;

    public Map<String,String> detectDisease(MultipartFile file) {

        Map<String,String> result = new HashMap<>();

        try {

            byte[] imageBytes = file.getBytes();
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);

            RestTemplate restTemplate = new RestTemplate();
            ObjectMapper mapper = new ObjectMapper();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("Api-Key", apiKey);

            // 1️⃣ Plant Identification
            String identifyBody = """
                    {
                      "images": ["%s"],
                      "plant_details": ["common_names"]
                    }
                    """.formatted(base64Image);

            HttpEntity<String> identifyRequest = new HttpEntity<>(identifyBody, headers);

            ResponseEntity<String> identifyResponse =
                    restTemplate.postForEntity(identifyUrl, identifyRequest, String.class);

            JsonNode plantRoot = mapper.readTree(identifyResponse.getBody());

            String cropName = "Unknown";

            if (plantRoot.path("suggestions").size() > 0) {
                cropName = plantRoot
                        .path("suggestions")
                        .get(0)
                        .path("plant_name")
                        .asText();
            }

            // 2️⃣ Disease Detection
            String healthBody = """
                    {
                      "images": ["%s"],
                      "modifiers": ["health_all"],
                      "language": "en",
                      "disease_details": ["description","treatment"]
                    }
                    """.formatted(base64Image);

            HttpEntity<String> healthRequest = new HttpEntity<>(healthBody, headers);

            ResponseEntity<String> healthResponse =
                    restTemplate.postForEntity(healthUrl, healthRequest, String.class);

            JsonNode root = mapper.readTree(healthResponse.getBody());

            JsonNode disease =
                    root.path("health_assessment")
                            .path("diseases")
                            .get(0);

            String diseaseName = disease.path("name").asText();
            String confidence =
                    String.format("%.2f", disease.path("probability").asDouble() * 100);

            JsonNode treatment =
                    disease.path("disease_details")
                            .path("treatment");

            // organic
            StringBuilder organic = new StringBuilder();
            for(JsonNode item : treatment.path("biological")){
                organic.append("• ").append(item.asText()).append("<br>");
            }

            // chemical
            StringBuilder chemical = new StringBuilder();
            for(JsonNode item : treatment.path("chemical")){
                chemical.append("• ").append(item.asText()).append("<br>");
            }

            // prevention
            StringBuilder prevention = new StringBuilder();
            for(JsonNode item : treatment.path("prevention")){
                prevention.append("• ").append(item.asText()).append("<br>");
            }

            result.put("crop", cropName);
            result.put("disease", diseaseName);
            result.put("confidence", confidence);
            result.put("organic", organic.toString());
            result.put("chemical", chemical.toString());
            result.put("prevention", prevention.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}