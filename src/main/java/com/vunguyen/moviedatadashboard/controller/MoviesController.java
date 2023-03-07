package com.vunguyen.moviedatadashboard.controller;

import com.vunguyen.moviedatadashboard.model.Movie;
import com.vunguyen.moviedatadashboard.repositories.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.rest.webmvc.PersistentEntityResourceAssembler;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(maxAge = 3600)
@RepositoryRestController
public class MoviesController {
    private PagedResourcesAssembler<Movie> pagedAssembler;

    @Autowired
    private MovieRepository repository;

    @Autowired
    public MoviesController(PagedResourcesAssembler<Movie> pagedAssembler) {
        this.pagedAssembler = pagedAssembler;
    }


    @RequestMapping(method=RequestMethod.GET,path="genres/{id}/movies", produces = "application/hal+json")
    public ResponseEntity<Page<Movie>> getAccountsHal( @PathVariable Integer id,  Pageable pageRequest, PersistentEntityResourceAssembler assembler){
        return new ResponseEntity(pagedAssembler.toModel(repository.findAllByGenres_Id(id, pageRequest), (RepresentationModelAssembler) assembler), HttpStatus.OK);
    }
}