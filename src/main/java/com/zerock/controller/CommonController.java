
package com.zerock.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Log4j
@Controller
public class CommonController {

    @GetMapping("/accessError")
    public void accessDenied(Authentication auth, Model model){

        log.info("access Denied : "+ auth);

        model.addAttribute("msg","Access Denied");
    }

    @GetMapping("/customLogin")
    public String loginInput(String error, String logout, Model model){

        log.info("error : " + error);
        log.info("logout : "+ logout);

        if(error != null){
            model.addAttribute("error","Login Error check your Account");

        }

        if(logout != null){
            model.addAttribute("logout","Logout!!");

        }
        return "CustomSecurityLogin";

    }

    @GetMapping("/customLogout")
    public void logOutGet(){

        log.info("custom Logout");
    }



}
