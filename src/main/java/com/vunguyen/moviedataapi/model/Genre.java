package com.vunguyen.moviedataapi.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
@Table(name="movies_genre")
public class Genre {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO) // AUTO-INCREMENT
    private Integer id;
    private String name;

    @ManyToMany(fetch = FetchType.LAZY,
            cascade = {
                    CascadeType.ALL
            }, mappedBy = "genres")
    @JsonIgnoreProperties("genres")
    private List<Movie> movies = new ArrayList<Movie>();

    @Override
    public String toString() {
        return "Genre{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", movies='" + movies.stream()
                .map(Movie::getTitle).collect(Collectors.joining(", ")) + '\'' +
                '}';
    }
}
