package com.vunguyen.moviedataapi.controller;

import com.vunguyen.moviedataapi.model.Movie;
import com.vunguyen.moviedataapi.model.ResponseObject;
import com.vunguyen.moviedataapi.repositories.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping(path="/movies/api/v1/movie")
public class MovieController {

    @Autowired
    private MovieRepository repository;

    @GetMapping("")
    ResponseEntity<ResponseObject>findAllMovies()
    {
        return ResponseEntity.status(HttpStatus.OK).body(
                new ResponseObject("ok", "query complete successfully", repository.findAll())
        );
    }

    @GetMapping("/{id}")
    ResponseEntity<ResponseObject>findById(@PathVariable Integer id) {
        Optional<Movie> foundMovie = repository.findById(id);
        if (foundMovie.isPresent()) {
            return ResponseEntity.status(HttpStatus.OK).body(
                    new ResponseObject("ok", "query complete successfully", foundMovie)
            );
        }
        else {
            return ResponseEntity.status(HttpStatus.OK).body(
                    new ResponseObject("ok", "Cannot find movie with id = " + id, ""));
        }
    }
}
