package com.nettech.ticket.application;

import com.nettech.ticket.timeentry.TimeEntry;
import com.nettech.ticket.timeentry.TimeEntryRepository;
import com.nettech.ticket.user.User;
import com.nettech.ticket.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Controller
public class ApplicationController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    TimeEntryRepository timeEntryRepository;

    @RequestMapping("/")
    public String index(Principal principal, Model model){
        User user = userRepository.findByEmail(principal.getName());

        model.addAttribute("currentUserName", user.getFirstname()+" "+user.getLastname());
        return "redirect:/ticket/view";
    }

    @RequestMapping("/report")
    public String report(Principal principal, Model model){
        User user = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", user.getFirstname()+" "+user.getLastname());

        return "report";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/report")
    public String report(Principal principal,
                         Model model,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date initialDate,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date endDate){
        User user = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", user.getFirstname()+" "+user.getLastname());
        System.out.println("initialDate: " + initialDate);
        System.out.println("endDate: " + endDate);
        if(initialDate != null && endDate != null){
            List<TimeEntry> timeEntries = timeEntryRepository.findAllByInitialDateGreaterThanEqualAndEndDateLessThanEqual(
                    convertToLocalDateTimeViaInstant(initialDate),
                    convertToLocalDateTimeViaInstant(endDate));

            if(timeEntries != null){
                float totalHours = 0.0f;
//                calculate the hours between dates
                for(int i = 0; i < timeEntries.size(); i++){
                    timeEntries.get(i).setHours(convertDatesToHours(
                            timeEntries.get(i).getInitialDate(),
                            timeEntries.get(i).getEndDate()
                    ));
                    totalHours += timeEntries.get(i).getHours();
                }

                model.addAttribute("timeEntries", timeEntries);
                model.addAttribute("totalHours", totalHours);
            }
        }
        return "report";

    }

    public LocalDateTime convertToLocalDateTimeViaInstant(Date dateToConvert){
        return dateToConvert.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
    }

    public Date convertToDateViaInstant(LocalDateTime dateToConvert){
        return Date.from(dateToConvert.atZone(ZoneId.systemDefault()).toInstant());
    }

    public float convertDatesToHours(LocalDateTime initialDate, LocalDateTime endDate){

        Date d1 = null;
        Date d2 = null;

        try{
            d1 = convertToDateViaInstant(initialDate);
            d2 = convertToDateViaInstant(endDate);

            //in milliseconds
            float diff = d2.getTime() - d1.getTime();

            float diffMinutes = diff / (60 * 1000) % 60;
            float diffHours = diff / (60 * 60 * 1000) % 24;
            int diffDays = (int) (diff / (24 * 60 * 60 * 1000));
            return (diffDays*24) + diffHours + (diffMinutes/60);

        }catch (Exception e){
            e.printStackTrace();
        }

        return -1;
    }
}
