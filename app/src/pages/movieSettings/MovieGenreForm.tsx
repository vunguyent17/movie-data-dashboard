import * as React from 'react';
import Box from '@mui/material/Box';
import { Autocomplete, CircularProgress, TextField, Typography } from '@mui/material';
import axios from 'axios';
import { useCallback, useEffect, useState } from 'react';
import GenreSettings from '../genreSettings/GenreSettings';

interface Genre {
  id: number;
  name: string;
  _links: {
    movies: {
      href: string;
    },
    self: {
      href: string;
    }
  }
}

interface Movie {
  id: number;
  title: string;
  year: number;
  runtime: number;
  director: string;
  actors: string;
  plot: string;
  posterUrl: string;
  _links: {
    self: {
      href: string;
    }
    genres: {
      href: string;
    }
  };
  genres: string[];
}


interface MovieGenreFormProps {
  addGenresValue: (movieData: React.SetStateAction<Movie>) => void;
  genresDataUrl: string;
}

export default function MovieGenreForm({ addGenresValue, genresDataUrl }: MovieGenreFormProps) {
  const [loadingData, setLoadingData] = useState(true);
  const [genreList, setGenreList] = useState<Genre[]>([]);
  const [genreIdSelected, setGenreIdSelected] = useState<number[]>([]);

  const handleGenresChange = useCallback((e: React.SyntheticEvent, value: Genre[]) => {
    setGenreIdSelected(value.map((genre) => genre.id));
    addGenresValue((state: Movie) => {
      return {
        ...state,
        'genres': value.map((genre) => genre._links.self.href),
      };
    });
  }, [addGenresValue]);


  useEffect(() => {
    let isFetching = true;
    async function getGenresData() {
      let genres_list: Genre[] = [];
      let next_link = "/movies/api/v1/genres";

      while (true) {
        let responseGenres = await axios.get(next_link);
        let _genres_list: Genre[] = responseGenres.data._embedded.genres;
        genres_list = genres_list.concat(_genres_list);
        if (responseGenres.data._links.next) {
          next_link = responseGenres.data._links.next.href;
        }
        else
          break;
      }
      


      if (genresDataUrl !== "" && genreIdSelected.length === 0) {
        let responseGenreIdSelected = await axios.get(genresDataUrl);
        let genres_select_list: Genre[] = responseGenreIdSelected.data._embedded.genres;
        let genres_select: Genre[] = genres_select_list
          .filter((selectGenre: Genre) => genres_list.map((genre)=>genre.id).includes(selectGenre.id));

        addGenresValue((state: Movie) => {
          return {
            ...state,
            'genres': genres_select.map((genre: Genre) => genre._links.self.href),
          };
        });
        setGenreIdSelected(genres_select.map((genre: Genre) => genre.id));
      }

      setGenreList(genres_list);
      if (genreIdSelected.length !== 0) {
        setGenreIdSelected((idList: number[]) => idList.filter((id) => genres_list.map((genre) => genre.id).includes(id)));
      }
    }

    if (isFetching)
    {
      getGenresData();
      setLoadingData(false);
    }
      
    return ()=>{
      isFetching = false;
    }
   
  }, [loadingData, genresDataUrl, addGenresValue, genreIdSelected.length]);

  return (loadingData) ? (
    <Box sx={{ display: 'flex', m: 2 }}
      justifyContent="center"
      alignItems="center">
      <CircularProgress /> <Typography sx={{ mx: 2 }}>Loading ...</Typography>
    </Box>) :
    (<>
      <Autocomplete
        value={genreList.filter((genre) => genreIdSelected.includes(genre.id))}
        onChange={handleGenresChange}
        multiple
        id="tags-outlined"
        options={genreList}
        getOptionLabel={(option: Genre) => option.name}
        fullWidth={true}
        filterSelectedOptions
        renderInput={(params) => (
          <TextField
            {...params}
            label="Genres"
            placeholder="Type and select genres ..."
          />
        )}
      />
      <GenreSettings reloadGenreList={setLoadingData} />
    </>)
}
