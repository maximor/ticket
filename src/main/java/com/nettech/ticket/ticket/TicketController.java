package com.nettech.ticket.ticket;

import com.nettech.ticket.user.User;
import com.nettech.ticket.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

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

        model.addAttribute("tickets", ticketRepository.findAll());
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

    @RequestMapping("/ticket/{id}")
    public String ticketDetails(Principal principal, Model model, @PathVariable Integer id){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());


        try{
            Optional<Ticket> ticket = Optional.ofNullable(ticketRepository.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Ticket Id: " + id)));

            model.addAttribute("ticket", ticket.get());
        }catch (Exception e){
            System.out.println(e.getMessage());
            model.addAttribute("error", "Error, Invalid Ticket Id "+ id);
        }

        return "ticket/ticket-details";
    }

    @RequestMapping("/ticket-edit/{id}")
    public String ticketEdit(Principal principal, Model model, @PathVariable Integer id){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());
        model.addAttribute("users", userRepository.findAllByStatusTrue());
        try{
            Optional<Ticket> ticket = Optional.ofNullable(ticketRepository.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Ticket Id: " + id)));

            model.addAttribute("ticket", ticket.get());
        }catch (Exception e){
            System.out.println(e.getMessage());
            model.addAttribute("error", "Error, Invalid Ticket Id "+ id);
        }
        return "ticket/ticket-edit";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/ticket-edit/{id}")
    public String ticketEdit(Principal principal, Model model, Ticket ticket, @PathVariable Integer id){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());
        model.addAttribute("users", userRepository.findAllByStatusTrue());

        try{
            Ticket ticketSave = ticketRepository.findById(id).get();

            if(!ticket.getSubject().equals(ticketSave.getSubject())){
                ticketSave.setSubject(ticket.getSubject());
            }else if(!ticket.getDescription().equals(ticketSave.getDescription())){
                ticketSave.setDescription(ticket.getDescription());
            }else if(!ticket.getEmployeesfield().equals(ticketSave.getEmployeesfield())){
                if(ticket.getEmployeesfield().length() > ticketSave.getEmployeesfield().length()){
                    ticketSave.setEmployeesfield(ticket.getEmployeesfield());
                    ticketSave = addEmployeeToTicket(ticketSave);
                }else{
                    ticketSave.setEmployeesfield(ticket.getEmployeesfield());
                    ticketSave = deleteEmployeeFromTicket(ticketSave);
                }
            }


            model.addAttribute("ticket", ticketRepository.save(ticketSave));
            model.addAttribute("message", "Ticket Updated successfully");
        }catch (Exception e){
            System.out.println(e.getMessage());
            model.addAttribute("error", "Error, Invalid Ticket Id "+ id);
        }

        return "ticket/ticket-edit";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/ticket/{id}/close")
    public String ticketClose(@PathVariable Integer id, Model model){
        Ticket ticket = ticketRepository.findById(id).get();
        try{
            ticket.setStatus(false);
            ticketRepository.save(ticket);
        }catch (Exception e){
            System.out.println(e.getMessage());
        }

        return "redirect:/ticket/"+id;
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/ticket/{id}/delete")
    public String ticketDelete(@PathVariable Integer id, Model model){
        try{
            Optional<Ticket> ticket = ticketRepository.findById(id);
            ticketRepository.delete(ticket.get());
        }catch (NullPointerException e){
            System.out.println(e.getMessage());
        }

        return "redirect:/ticket/view";
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/ticket/{id}/employee/{idEmployee}/delete")
    public String ticketEmployeeDelete(@PathVariable Integer id, @PathVariable Integer idEmployee, Model model){
        Ticket ticket = ticketRepository.findById(id).get();
        User user = userRepository.findById(idEmployee).get();

        ticket.getEmployees().remove(user);
        ticketRepository.save(ticket);
        return "redirect:/ticket/"+id;

    }

    private Ticket deleteEmployeeFromTicket(Ticket ticket){
        if(ticket.getEmployeesfield().length() > 0){
            ticket.getEmployees().clear();
            List<User> users = new ArrayList<>();
            List<String> emails = Arrays.asList(ticket.getEmployeesfield().trim().split(","));
            for(int i = 0; i < emails.size(); i++){
                if(!emails.get(i).equals("")){
                    users.add(userRepository.findByEmail(emails.get(i).trim()));
                }
            }
            ticket.setEmployees(users);
        }else{
            if(ticket.getEmployees().size() > 0){
                ticket.getEmployees().clear();
            }
        }
        return ticket;
    }

    private Ticket addEmployeeToTicket(Ticket ticket){
        if(ticket.getEmployeesfield().length() > 0){
            List<User> users = new ArrayList<>();
            List<String> emails = Arrays.asList(ticket.getEmployeesfield().trim().split(","));
            ticket.getEmployees().clear();
            for(int i = 0; i < emails.size(); i++){
                if(!emails.get(i).equals("")){
                    users.add(userRepository.findByEmail(emails.get(i).trim()));
                }
            }
            ticket.setEmployees(users);
        }

        return ticket;
    }

}
