package com.vunguyen.moviedatadashboard.repositories;

import com.vunguyen.moviedatadashboard.model.Genre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.data.rest.core.annotation.RestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;
@RepositoryRestResource
@CrossOrigin(origins = "*",
        methods = { RequestMethod.GET, RequestMethod.POST, RequestMethod.DELETE, RequestMethod.PUT },
        maxAge = 3600)
public interface GenreRepository extends JpaRepository<Genre, Integer>, PagingAndSortingRepository<Genre, Integer> {
    @RestResource(path="byKeyword", rel = "customFindMethod")
    List<Genre> findByNameContainingIgnoreCase(@Param("keyword") String keyword);
}
