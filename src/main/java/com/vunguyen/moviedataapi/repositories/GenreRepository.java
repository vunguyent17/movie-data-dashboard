package com.vunguyen.moviedataapi.repositories;

import com.vunguyen.moviedataapi.model.Genre;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GenreRepository extends JpaRepository<Genre, Integer> {
    List<Genre> findByName(String genreName);
}
