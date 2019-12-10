package com.nettech.ticket.application;

import com.nettech.ticket.user.User;
import com.nettech.ticket.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
public class ApplicationController {
    @Autowired
    UserRepository userRepository;

    @RequestMapping("/")
    public String index(Principal principal, Model model){
        User user = userRepository.findByEmail(principal.getName());

        model.addAttribute("currentUserName", user.getFirstname()+" "+user.getLastname());
        return "index";
    }
}
