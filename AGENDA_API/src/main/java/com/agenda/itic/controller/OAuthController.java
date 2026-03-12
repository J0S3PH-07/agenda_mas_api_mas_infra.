package com.agenda.itic.controller;

import org.springframework.security.core.Authentication;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.agenda.itic.model.User;
import com.agenda.itic.service.UserService;

import jakarta.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.GetMapping;


@RestController
@RequestMapping("/oauth/google")
@CrossOrigin(origins = "*")
public class OAuthController {
    
    @Autowired
    UserService userService;
    
    @GetMapping("/home")
    public void home(Authentication authentication, HttpServletResponse response) {
        OAuth2User authUser = (OAuth2User) authentication.getPrincipal();
        String email = authUser.getAttribute("email");
        String name = authUser.getAttribute("name");
        
        User user = userService.findByEmail(email).orElse(null);
        if (user == null) {
            user = new User();
            user.setEmail(email);
            user.setName(name);
            user.setRole("PUBLIC"); // Default role
            user = userService.save(user);
        }

        if (user == null) {
            try {
                response.sendRedirect("http://localhost:8085/home");
            } catch (IOException e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            return;
        }

        try {
            response.sendRedirect("http://localhost:8081?token=" );
        } catch (IOException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }   

}
