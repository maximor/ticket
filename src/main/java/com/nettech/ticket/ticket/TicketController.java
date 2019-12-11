package com.nettech.ticket.ticket;

import com.nettech.ticket.user.User;
import com.nettech.ticket.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
public class TicketController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    TicketRepository ticketRepository;

    private User currentUser;

    @RequestMapping("/ticket/view")
    public String ticketView(Principal principal, Model model){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());

        model.addAttribute("tickets", ticketRepository.findAllByStatusTrue());
        return "ticket/ticket-view";
    }

    @RequestMapping("/ticket/create")
    public String ticketCreate(Principal principal, Model model){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());

        model.addAttribute("users", userRepository.findAllByStatusTrue());
        return "ticket/ticket-create";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/ticket/create")
    public String ticketCreate(Principal principal, Model model, Ticket ticket){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());
        model.addAttribute("users", userRepository.findAllByStatusTrue());

        try{
            List<User> users = new ArrayList<>();
            List<String> emails = Arrays.asList(ticket.getEmployeesfield().trim().split(","));
            for(int i=0; i < emails.size(); i++){
                if(!emails.get(i).equals("")){
                    User user = userRepository.findByEmail(emails.get(i).trim());
                    users.add(user);
                }
            }
            ticket.setEmployees(users);
            ticketRepository.save(ticket);
            model.addAttribute("message", "Ticket saved successfully");
        }catch (Exception e){
            e.getStackTrace();
        }
        return "ticket/ticket-create";
    }

}
