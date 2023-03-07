import { useState } from 'react';
// @mui
import {
  Stack,
  Button,
  Container,
} from '@mui/material';
import MovieDataNavBar from '../utilities/Navbar';
import GenreListSelect from './GenreListSelect';

import AddIcon from '@mui/icons-material/Add';
import MovieList from './MovieList';


export default function Home() {

  const [urlMovies, setUrlMovies] = useState("/movies/api/v1/movies");

  return (
    <>
      <title> Movie data </title>
      <MovieDataNavBar />
        <Container> 
          <Stack direction="row" alignItems="center" justifyContent="space-between" my={3}>
            <GenreListSelect setUrlMoviesHome={setUrlMovies} urlMovies={urlMovies} />
            <Button variant="contained" href="/movie/new" startIcon={<AddIcon />}>
              New Movie
            </Button>
          </Stack>
          <MovieList urlMoviesList={urlMovies}/>
        </Container>
    </>
  );
}
