package com.vunguyen.moviedatadashboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RouteController {

    @RequestMapping(value = "/{path:[^\\.]*}")
    public String redirectSingle() {

        return "forward:/index.html";
    }

    @GetMapping("/*/{path:[^\\.]*}")
    public String redirectNested() {

        return "forward:/index.html";
    }

}
