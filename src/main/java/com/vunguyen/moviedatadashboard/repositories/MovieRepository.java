package com.vunguyen.moviedatadashboard.repositories;

import com.vunguyen.moviedatadashboard.model.Movie;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.data.rest.core.annotation.RestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMethod;

@RepositoryRestResource
@CrossOrigin(origins = "*",
        methods = { RequestMethod.GET, RequestMethod.POST, RequestMethod.DELETE, RequestMethod.PUT },
        maxAge = 3600)
public interface MovieRepository extends JpaRepository<Movie, Integer>, PagingAndSortingRepository<Movie, Integer> {
    @RestResource(exported = false)
    Page<Movie> findAllByGenres_Id(Integer id, Pageable pageable);

    @RestResource(path="byTitle", rel = "searchByTitleKeyword")
    Page<Movie> findByTitleContainingIgnoreCase(@Param("keyword") String keyword, Pageable pageable);
}
