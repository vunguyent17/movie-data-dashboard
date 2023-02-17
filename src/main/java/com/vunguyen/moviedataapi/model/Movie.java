package com.vunguyen.moviedataapi.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Entity
@Data
@Table(name="movies_movie")
public class Movie {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO) // AUTO-INCREMENT
    private Integer id;

    @Column(nullable = false)
    private String title;
    private Integer year;
    private Integer runtime;
    private String director;
    private String actors;

    private String plot;

    @ManyToMany(fetch = FetchType.LAZY, targetEntity = Genre.class,
            cascade = {
                    CascadeType.PERSIST,
                    CascadeType.MERGE})
    @JoinTable(name="movies_movie_genres",
    joinColumns = @JoinColumn(name = "movie_id"),
    inverseJoinColumns = @JoinColumn(name = "genre_id"))
    @JsonIgnoreProperties("movies")
    private List<Genre> genres = new ArrayList<Genre>();;
    @Column(name="posterUrl")
    private String posterUrl;

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", genre='" + genres.stream()
                .map(Genre::getName).collect(Collectors.joining(", ")) + '\'' +
                '}';
    }

}
