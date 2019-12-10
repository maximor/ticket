package com.nettech.ticket.user;

import com.nettech.ticket.role.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.security.Principal;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Optional;

@Controller
public class UserController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;

    private User currentUser;

    @RequestMapping("/login")
    public String login(Model model){
        return "login";
    }

    @RequestMapping("/employee/view")
    public String employeeView(Principal principal, Model model){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());
        model.addAttribute("users", userRepository.findAll());

        return "employee/employee-view";

    }

    @RequestMapping("/employee/create")
    public String employeeCreate(Principal principal, Model model){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());

        return "employee/employee-create";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/employee/create")
    public String employeeCreatePost(Principal principal, Model model, User user){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());

        try {
            user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
            user.setRoles(new HashSet<>(Arrays.asList(roleRepository.findByName("ROLE_EMPLOYEE"))));
            userRepository.save(user);
            model.addAttribute("message", "Employee saved successfully");
        }catch (DataIntegrityViolationException e){
            model.addAttribute("error", "Error, The new Email you want to use already exists!");
            e.getStackTrace();
        }

        return "employee/employee-create";
    }

    @RequestMapping("/employee/{id}")
    public String employeeShow(Principal principal, Model model, @PathVariable Integer id){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());
        try{
            Optional<User> user = Optional.ofNullable(userRepository.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid User Id: " + id)));

            model.addAttribute("user", user.get());
        }catch (Exception e){
            System.out.println(e.getMessage());
            model.addAttribute("error", "Error, Invalid User Id "+id);
        }

        return "employee/employee-edit";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/employee/{id}")
    public String employeeUpdate(Principal principal, Model model, User user, @PathVariable Integer id){
        currentUser = userRepository.findByEmail(principal.getName());
        model.addAttribute("currentUserName", currentUser.getFirstname()+" "+currentUser.getLastname());

        try{
            Optional<User> userw = Optional.ofNullable(userRepository.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid User Id: " + id)));
            if(user.getFirstname() != null && !user.getFirstname().equals(userw.get().getFirstname())){
                userw.get().setFirstname(user.getFirstname());
            }else if(user.getLastname() != null && !user.getLastname().equals(userw.get().getLastname())){
                userw.get().setLastname(user.getLastname());
            }else if(user.getEmail() != null && !user.getEmail().equals(userw.get().getEmail())){
                userw.get().setEmail(user.getEmail());
            }else if(user.isStatus() != userw.get().isStatus()){
                userw.get().setStatus(user.isStatus());
            }
            userRepository.save(userw.get());
            model.addAttribute("message", "Employee Updated successfully");
        } catch (DataIntegrityViolationException e){
            System.out.println(e.getMessage());
            model.addAttribute("error", "Error, The new Email you want to use already exists!");
        } catch (Exception e){
            System.out.println(e.getMessage());
            model.addAttribute("error", "Error, Invalid User Id "+id);
        }

        return "employee/employee-edit";
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/employee/{id}/delete")
    public String employeeDelete(@PathVariable Integer id, Model model){
        try{
            Optional<User> user = userRepository.findById(id);
            if(!user.get().getRoles().iterator().next().getName().equals("ROLE_ADMIN")){
                userRepository.delete(user.get());
            }
            return "redirect:/employee/view";
        }catch (NullPointerException e){
            System.out.println(e.getMessage());
        }
        return "redirect:/employee/view";
    }
}
