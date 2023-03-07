package com.vunguyen.moviedatadashboard;

import com.vunguyen.moviedatadashboard.model.Genre;
import com.vunguyen.moviedatadashboard.model.Movie;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.web.servlet.config.annotation.CorsRegistry;


@SpringBootApplication
public class MovieDataDashboardApplication implements RepositoryRestConfigurer {
	public static void main(String[] args) {
		SpringApplication.run(MovieDataDashboardApplication.class, args);
	}

	@Override
	public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config, CorsRegistry cors) {
		config.exposeIdsFor(Movie.class);
		config.exposeIdsFor(Genre.class);
		cors.addMapping("/movies")
				.allowedOrigins("*")
				.allowedMethods("PUT", "DELETE","GET","POST")
				.allowCredentials(false).maxAge(3600);
	}
}

