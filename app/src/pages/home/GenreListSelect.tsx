import { useEffect, useState } from 'react';
import axios from 'axios';
import * as React from 'react';

import {
  Stack,
  MenuItem,
  Typography,
  Box,
  CircularProgress,
  FormControl,
  InputLabel,
  SelectChangeEvent,
  Select,
} from '@mui/material';
import GenreSettings from '../genreSettings/GenreSettings';

interface Genre {
  id: number;
  name: string;
  _links: {
    movies: {
      href: string;
    }
  }
}

interface GenreListSelectProps {
  setUrlMoviesHome?: (url : string) => void;
  urlMovies : string;
}

export default function GenreListSelect({setUrlMoviesHome,  urlMovies} : GenreListSelectProps ) {
  const [loadingData, setLoadingData] = useState(true);
  const [genreList, setGenreList] = useState<Genre[]>([]);

  useEffect(() => {
    async function getGenresData() {
      let genres_list: Genre[] = [];
      let nextLink = "/movies/api/v1/genres";

      while (true) {
        let responseGenres = await axios.get(nextLink);
        let _genres_list: Genre[] = responseGenres.data._embedded.genres;
        genres_list = genres_list.concat(_genres_list);
        if (responseGenres.data._links.next) {
          nextLink = responseGenres.data._links.next.href;
        }
        else
          break;
      }
      setGenreList(genres_list);
      setLoadingData(false);
    }
    getGenresData();
  }, [loadingData]);

  const handleChangeGenre = (event: SelectChangeEvent) => {
    setUrlMoviesHome?.(event.target.value as string);
  };

  return (
  <Stack direction="row" alignItems="center" justifyContent="space-between" spacing={3}>
      <Box sx={{ minWidth: 120 }}>
        <FormControl variant="standard" fullWidth>
          <InputLabel shrink htmlFor="genre-filter">
            Genre
          </InputLabel>
          <Select
            inputProps={{
              name: 'genre',
              id: 'genre-filter',
            }}
            displayEmpty
            value={loadingData? "" : urlMovies}
            label="genre"
            onChange={handleChangeGenre}
          >

            <MenuItem key="selectAll" value="/movies/api/v1/movies">All</MenuItem >
            {
              (loadingData) ?
                (<MenuItem key="loading"><Box sx={{ display: 'flex', m: 2 }}
                  justifyContent="center"
                  alignItems="center">
                  <CircularProgress /> <Typography sx={{ mx: 2 }}>Loading ...</Typography>
                </Box></MenuItem >) : genreList.map((genre) => <MenuItem key={"select" + genre.id.toString()} value={genre._links.movies.href}>{genre.name}</MenuItem >)
            }
          </Select>

        </FormControl>
      </Box>

      <GenreSettings reloadGenreList={setLoadingData}/>
    </Stack>)
}

