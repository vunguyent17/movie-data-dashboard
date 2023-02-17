package com.vunguyen.moviedataapi.controller;

import com.vunguyen.moviedataapi.model.ResponseObject;
import com.vunguyen.moviedataapi.repositories.GenreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path="/movies/api/v1/genre")
public class GenreController {
    @Autowired
    private GenreRepository repository;

    @GetMapping("")
    ResponseEntity<ResponseObject> findAllGenres()
    {
        return ResponseEntity.status(HttpStatus.OK).body(
                new ResponseObject("ok", "query complete successfully", repository.findAll())
        );
    }
}
