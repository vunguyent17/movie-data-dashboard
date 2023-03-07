import { useState } from 'react';
// @mui
import {
  Container,
  Typography,
} from '@mui/material';
import MovieDataNavBar from '../utilities/Navbar';
import MovieList from '../home/MovieList';
import { useLocation } from 'react-router-dom';


export default function SearchMovies() {
  const [urlMovies, setUrlMovies] = useState("");
  const location = useLocation();
  let keyword= location.state.keywordMovie ? location.state.keywordMovie : "";
  let urlSearch = "/movies/api/v1/movies/search/byTitle?keyword="+keyword;
  if (urlMovies !== urlSearch)
  {
    setUrlMovies(urlSearch);
  }

  return (
    <>
      <title> Movie data </title>
      <MovieDataNavBar />
        <Container> 
          <Typography sx={{my : 3}} variant="h4" gutterBottom>Movie search result for "<b>{keyword}</b>"</Typography>
          <MovieList urlMoviesList={urlMovies}/>
        </Container>
    </>
  );
}
