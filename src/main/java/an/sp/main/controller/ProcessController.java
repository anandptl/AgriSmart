package an.sp.main.controller;

import an.sp.main.service.InorganicService;
import an.sp.main.service.OrganicService;
import an.sp.main.wrapper.InOrganicProcessWrapper;
import an.sp.main.wrapper.OrganicProcessWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/process")
public class ProcessController {
    @Autowired
    private OrganicService organicService;
    @Autowired
    private InorganicService inorganicService;


//    Organic controller...
    @PostMapping("/organic/save-all")
    public String saveAll(
            @ModelAttribute OrganicProcessWrapper wrapper,
            RedirectAttributes redirectAttributes) {

        organicService.saveAll(wrapper);

        redirectAttributes.addFlashAttribute(
                "Successfull",
                "All Organic Stages Saved Successfully!"
        );

        return "redirect:/Admin-Organic-Process";
    }

//    delete crop by ID..
    @PostMapping("/organic/delete-all")
    public String deleteAllStages(
            @RequestParam Long cropId,
            RedirectAttributes redirectAttributes){

        organicService.deleteAllCropId(cropId);

        redirectAttributes.addFlashAttribute(
                "Successfull",
                "All Organic Stages Deleted Successfully!"
        );

        return "redirect:/Admin-Organic-Process";
    }


//    Inorganice controller....
    @PostMapping("/inorganic/save-all")
    public String saveAll(
            @ModelAttribute InOrganicProcessWrapper wrapper,
            RedirectAttributes redirectAttributes){

        inorganicService.saveAll(wrapper);

        redirectAttributes.addFlashAttribute(
                "Successfull",
                "All Inorganic Stages Saved Successfully!"
        );

        return "redirect:/Admin-Inorganic-Process";
    }

//  delete inorganic crop record by id.
    @PostMapping("/inorganic/delete-all")
    public String InorganicDeleteAllStages(
            @RequestParam Long cropId,
            RedirectAttributes redirectAttributes){

        inorganicService.deleteAllCropId(cropId);

        redirectAttributes.addFlashAttribute(
                "Successfull",
                "All Organic Stages Deleted Successfully!"
        );

        return "redirect:/Admin-Inorganic-Process";
    }



}
