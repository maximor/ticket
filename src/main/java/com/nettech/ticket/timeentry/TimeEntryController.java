package com.nettech.ticket.timeentry;

import com.nettech.ticket.ticket.Ticket;
import com.nettech.ticket.ticket.TicketRepository;
import com.nettech.ticket.user.User;
import com.nettech.ticket.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.crypto.spec.PSource;
import java.lang.reflect.Array;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.*;

@Controller
public class TimeEntryController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    TimeEntryRepository timeEntryRepository;

    @Autowired
    TicketRepository ticketRepository;

    private User currentUser;

    @RequestMapping("/timeentry/{idTicket}")
    public String timeEntryCreate(Principal principal, Model model, @PathVariable Integer idTicket){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());
        model.addAttribute("users", userRepository.findAll());

        try{
            Optional<Ticket> ticket = Optional.ofNullable(ticketRepository.findById(idTicket)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Ticket Id: " + idTicket)));

            model.addAttribute("ticket", ticket.get());
        }catch (Exception e){
            System.out.println(e.getMessage());
            model.addAttribute("error", "Error, Invalid Ticket Id "+ idTicket);
        }
        return "timeentry/timeentry-create";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/timeentry/{idTicket}")
    public String timeEntryCreate(Principal principal, Model model, @PathVariable Integer idTicket,
                                  @RequestParam("idEmployee") Integer idEmployee,
                                  @RequestParam("initialDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime initialDate,
                                  @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
                                  @RequestParam("note") String note){


        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());
        model.addAttribute("users", userRepository.findAll());

        try{
            User employee = userRepository.findById(idEmployee).get();
            Ticket ticket = ticketRepository.findById(idTicket).get();

            System.out.println("date: " + initialDate);
            if(ticket.getTimeEntries().size() > 0){
                ticket.getTimeEntries().add(new TimeEntry(initialDate, endDate, note, Arrays.asList(employee), ticket));
            }else{
                List<TimeEntry> timeEntries = new ArrayList<>();
                timeEntries.add(new TimeEntry(initialDate, endDate, note, Arrays.asList(employee), ticket));
                ticket.setTimeEntries(timeEntries);
            }
            ticketRepository.save(ticket);
            model.addAttribute("ticket", ticket);
            model.addAttribute("message", "Time Entry saved successfully for Ticket #"+ticket.getId());

        }catch (Exception e){
            System.out.println(e.getMessage());
            e.getStackTrace();
        }

        return "timeentry/timeentry-create";
    }

    @RequestMapping("/timeentry-edit/{id}")
    public String timeEntryTicket(Principal principal, Model model, @PathVariable Integer id){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());
        model.addAttribute("users", userRepository.findAll());

        try{
            TimeEntry timeEntry = timeEntryRepository.findById(id).get();
            model.addAttribute("timeentry", timeEntry);
        }catch (Exception e){
            model.addAttribute("error", "Error, Invalid Time Entry Id "+ id);
        }

        return "timeentry/timeentry-edit";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/timeentry-edit/{id}")
    public String timeEntryTicket(Principal principal, Model model, @PathVariable Integer id,
                                  @RequestParam("idEmployee") Integer idEmployee,
                                  @RequestParam("initialDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime initialDate,
                                  @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
                                  @RequestParam("note") String note){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());
        model.addAttribute("users", userRepository.findAll());

        try{
            TimeEntry timeEntry = timeEntryRepository.findById(id).get();
            if(timeEntry.getEmployees().get(0).getId() != idEmployee){
                timeEntry.getEmployees().clear();
                List<User> users = new ArrayList<>();
                users.add(userRepository.findById(idEmployee).get());
                timeEntry.setEmployees(users);
            }else if(timeEntry.getInitialDate() != initialDate){
                timeEntry.setInitialDate(initialDate);
            }else if(timeEntry.getEndDate() != endDate){
                timeEntry.setEndDate(endDate);
            }
            timeEntry.setNote(note);

            timeEntry = timeEntryRepository.save(timeEntry);
            model.addAttribute("timeentry", timeEntry);
            model.addAttribute("message", "Time Entry Updated successfully");
        }catch (Exception e){
            System.out.println(e.getMessage());
            model.addAttribute("error", "Error, Invalid Time Entry Id "+ id);
        }
        return "timeentry/timeentry-edit";
    }
}
