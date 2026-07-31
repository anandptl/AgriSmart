package an.sp.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import an.sp.main.entities.CropEntity;
import an.sp.main.service.CropService;

@Controller
@RequestMapping("/admin/crop")
public class CropController {

    @Autowired
    private CropService cropService;

    @PostMapping("/save")
    public String saveCrop(@ModelAttribute CropEntity crop, @RequestParam("imageFile") MultipartFile file, RedirectAttributes redirectAttributes) {
        try {
            cropService.saveCrop(crop, file);
            redirectAttributes.addFlashAttribute("Successfull", "Crop Added Successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("Error", e.getMessage());
        }

        return "redirect:/Manage-Crops";
    }

    @GetMapping("/fetch")
    @ResponseBody
    public Map<String, Object> fetchCrop(@RequestParam String cropName) {

        Map<String, Object> response = new HashMap<>();

        CropEntity crop = cropService.getCropByName(cropName);

        if (crop == null) {
            response.put("status", "error");
            response.put("message", "Crop not found");
            return response;
        }

        response.put("status", "success");
        response.put("id", crop.getId());
        response.put("minPrice", crop.getMinPrice());
        response.put("maxPrice", crop.getMaxPrice());
        response.put("cropImageName", crop.getCropImageName());

        return response;
    }

    // update crop ...
    @PostMapping("/update")
    @ResponseBody
    public Map<String, String> updateCrop(
            @RequestParam Long id,
            @RequestParam Double minPrice,
            @RequestParam Double maxPrice,
            @RequestParam(required = false) MultipartFile imageFile) {

        Map<String, String> response = new HashMap<>();

        try {
            cropService.updateCrop(id, minPrice, maxPrice, imageFile);
            response.put("status", "success");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
        }

        return response;
    }


    // fetch use for delete crop 
    @GetMapping("/del-fetch")
    @ResponseBody
    public Map<String, Object> delfetchCrop(@RequestParam String cropName) {

        Map<String, Object> response = new HashMap<>();

        CropEntity crop = cropService.getCropByName(cropName);

        if (crop == null) {
            response.put("status", "error");
            response.put("message", "Crop not found");
            return response;
        }

        response.put("status", "success");
        response.put("deleteCropId", crop.getId());

        return response;
    }

    // delete crop data 
    @DeleteMapping("/delete")
    @ResponseBody
    public Map<String, String> deletecrop(@RequestParam Long id){

        Map<String, String> response = new HashMap<>();

        boolean deleted = cropService.deleteCropById(id);

        if (deleted) {
            response.put("status", "success");
            response.put("message", "Crop deleted successfully");
        } else {
            response.put("status", "error");
            response.put("message", "Crop not found");
        }

        return response;
    }


//  find the crop image for suggestion...
    @GetMapping("/image/{id}")
    @ResponseBody
    public ResponseEntity<byte[]> getCropImage(@PathVariable Long id) {

        CropEntity crop = cropService.getById(id);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_TYPE, "image/jpeg")
                .body(crop.getCropImage());
    }


}
