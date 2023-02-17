package com.vunguyen.moviedataapi.repositories;

import com.vunguyen.moviedataapi.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MovieRepository extends JpaRepository<Movie, Integer> {
    List<Movie> findByTitle(String movieTitle);
    List<Movie> findByYear(Integer year);
    List<Movie> findByGenres(String genre_name);
}
