package com.nettech.ticket;

import com.nettech.ticket.role.Role;
import com.nettech.ticket.role.RoleRepository;
import com.nettech.ticket.user.User;
import com.nettech.ticket.user.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Arrays;
import java.util.HashSet;

@SpringBootApplication
public class TicketApplication {

    public static void main(String[] args) {
        SpringApplication.run(TicketApplication.class, args);
    }

    @Bean
    public CommandLineRunner initData(UserRepository userRepository, RoleRepository roleRepository){
        return args -> {
            System.out.println("Creating default user and roles...");
            System.out.println("Creating Role:");
            System.out.println("1- ROLE_ADMIN\n2- ROLE_EMPLOYEE");
            Role roleAdmin = roleRepository.save(new Role("ROLE_ADMIN"));
            roleRepository.save(new Role("ROLE_EMPLOYEE"));

            System.out.println("Creating admin user...");
            System.out.println("User: admin");
            User user = new User();
            user.setFirstname("Administrator");
            user.setLastname("Administrator");
            user.setEmail("admin@administrator.com");
            user.setPassword(new BCryptPasswordEncoder().encode("admin"));
            user.setRoles(new HashSet<>(Arrays.asList(roleAdmin)));
            userRepository.save(user);
        };
    }

}
