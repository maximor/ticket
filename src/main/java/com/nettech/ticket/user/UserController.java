package com.nettech.ticket.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
    @RequestMapping("/login")
    public String login(Model model){
        return "login";
    }
}
