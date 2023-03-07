import * as React from 'react';
import Box from '@mui/material/Box';
import FormControl from '@mui/material/FormControl';
import MovieDataNavBar from '../utilities/Navbar';
import { Button, CircularProgress, Container, Grid, Stack, TextField, Typography } from '@mui/material';
import axios from 'axios';
import { useCallback, useEffect, useState } from 'react';
import MovieGenreForm from './MovieGenreForm';
import { useLocation, useNavigate } from 'react-router-dom';


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
    },
    genres: {
      href: string;
    }
  };
  genres: string[];
}


export default function MovieForm() {
  const INPUT_LABELS = [
    { id: 'title', label: 'Title', type: "text", space: 12 },
    { id: 'year', label: 'Year', type: "number", space: 6 },
    { id: 'runtime', label: 'Runtime', type: "number", space: 6 },
    { id: 'director', label: 'Director', type: "text", space: 12 },
    { id: 'actors', label: 'Actors', type: "text", space: 12 },
    { id: 'plot', label: 'Plot', type: "text", space: 12, multiline: true }
  ];
  const movie_default: Movie = {
    id: 0,
    title: "",
    year: 0,
    runtime: 0,
    director: "",
    actors: "",
    plot: "",
    posterUrl: "",
    _links: {
      self: {
        href: ""
      },
      genres: {
        href: "",
      }
    },
    genres: [],
  };

  const [loadingData, setLoadingData] = useState(true);
  const [posterUrl, setPosterUrl] = useState<string>("");
  const [userInputs, setUserInputs] = useState<Movie>(movie_default);
  const location = useLocation();
  const navigate = useNavigate();

  useEffect(() => {
    async function getMovie() {
      let movie_id = location.state.movie_id;
      let responseMovie = await axios.get("/movies/api/v1/movies/" + movie_id);
      let movie_data: Movie = responseMovie.data;
      setUserInputs(movie_data);
      setPosterUrl(movie_data.posterUrl);
      setLoadingData(false);
    }
    if (location.state != null) {
      getMovie();
    }
    else {
      setLoadingData(false);
    }

  }, [location.state])

  // Xử lý khi người dùng điền form
  const onChangeInputHandler = useCallback(
    ({ target: { id, value } }: React.ChangeEvent<HTMLInputElement>) =>
      setUserInputs((state: any) => {
        if (id === "posterUrl") {
          setPosterUrl(value);
        }
        return {
          ...state,
          [id]: value,
        };
      }),
    []
  );

  const handleFormSubmit = async () => {

    const headers = {
      'Content-Type': 'text/uri-list'
    };
    if (window.location.pathname === "/movie/edit") {
      let responseUpdateMovieInfo = await axios.put(userInputs._links.self.href, userInputs);
      let dataUpdateGenre = userInputs.genres.join("\r\n") + "\r\n"
      let responseUpdateMovieGenre = await axios.put(userInputs._links.genres.href, dataUpdateGenre, { headers })

      let snackBarConfigState = {};
      if (responseUpdateMovieInfo.status !== 200) {
        snackBarConfigState = { state: { snackBarContent: "Error update movie info", snackBarStatus: responseUpdateMovieInfo.status } };
      }
      else if (responseUpdateMovieGenre.status !== 204) {
        snackBarConfigState = { state: { snackBarContent: "Error update movie genre", snackBarStatus: responseUpdateMovieGenre.status } };
      }
      else {
        snackBarConfigState = { state: { snackBarContent: "Successfully update movie", snackBarStatus: responseUpdateMovieGenre.status } };
      }
      navigate("/", snackBarConfigState);
    }

    if (window.location.pathname === "/movie/new") {
      let responseCreateMovie = await axios.post("/movies/api/v1/movies", userInputs);
      let snackBarConfigState = {
        state: {
          snackBarContent: responseCreateMovie.status !== 201 ?
            "Error creating new movie" :
            "Successfully creating new movie",
          snackBarStatus: responseCreateMovie.status
        }
      };
      navigate("/", snackBarConfigState);
    }
  }

  return (
    <>
      <title> Movie Form </title>
      <MovieDataNavBar />
      {(loadingData) ?
        <Box sx={{ display: 'flex', m: 2 }}
          justifyContent="center"
          alignItems="center">
          <CircularProgress /> <Typography sx={{ mx: 2 }}>Loading ...</Typography>
        </Box> :
        <Container>
          <Stack direction="row" alignItems="center" justifyContent="space-between" my={3}>
            <Typography>Thông tin phim</Typography>
          </Stack>
          <Grid container columnSpacing={4}>
            <Grid xs={8} item container columnSpacing={4} rowSpacing={4}>
              {INPUT_LABELS.map((input) => (
                <Grid item xs={input.space} key={input.label}>
                  <FormControl fullWidth variant="standard">
                    <TextField
                      id={input.id}
                      label={input.label}
                      type={input.type}
                      InputLabelProps={{
                        shrink: true,
                      }}
                      variant="standard"
                      multiline={input.multiline ? true : false}
                      defaultValue={userInputs[input.id as keyof Movie]}
                      onChange={onChangeInputHandler}
                    />
                  </FormControl>
                </Grid>
              ))
              }
              <Grid item xs={6}>
                <Button variant="contained" fullWidth onClick={handleFormSubmit}>Lưu thông tin phim</Button>
              </Grid>
            </Grid>
            <Grid container item xs={4}>
              <MovieGenreForm genresDataUrl={userInputs._links.genres.href} addGenresValue={setUserInputs} />
              <FormControl fullWidth variant="standard" sx={{ m: 2 }}>
                <TextField
                  id="posterUrl"
                  label="URL Image"
                  type="text"
                  InputLabelProps={{
                    shrink: true,
                  }}
                  variant="standard"
                  defaultValue={userInputs["posterUrl" as keyof Movie]}
                  onChange={onChangeInputHandler}
                />
              </FormControl>

              {posterUrl === "" ? (
                <Container maxWidth={false}
                  sx={{
                    m: 1,
                    height: 350,
                  }}
                  component="img"
                />) : (
                <Container
                  sx={{
                    m: 1,
                    height: 350,
                  }}
                  component="img"
                  alt="Movie poster"
                  src={posterUrl}
                />
              )
              }
            </Grid>
          </Grid>
        </Container>}
    </>
  );
}