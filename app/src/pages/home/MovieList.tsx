import { useEffect, useState } from 'react';
import axios from 'axios';
import * as React from 'react';
import { styled } from '@mui/material/styles';
import { TooltipProps, tooltipClasses } from '@mui/material/Tooltip';
// @mui
import {
  Link,
  Card,
  Table,
  Stack,
  Popover,
  TableRow,
  MenuItem,
  TableBody,
  TableCell,
  Typography,
  IconButton,
  TableContainer,
  TablePagination,
  TableHead,
  Box,
  CircularProgress,
  Tooltip,
  DialogActions,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogContentText,
  Button,
} from '@mui/material';
import MoreVertIcon from '@mui/icons-material/MoreVert';
import AccessTimeIcon from '@mui/icons-material/AccessTime';
import ShowMoreText from "react-show-more-text";
import { useLocation, useNavigate } from 'react-router-dom';
import SnackBarMovie from '../utilities/SnackBarMovie';


const TABLE_HEAD = [
  { id: 'no_header', label: 'Id', alignRight: false },
  { id: 'movie_info_header', label: 'Movie Info', alignRight: false },
  { id: 'genre_header', label: 'Genre', alignRight: false },
  { id: 'director_header', label: 'Director', alignRight: false },
  { id: 'actors_header', label: 'Actors', alignRight: false },
  { id: 'plot_header', label: 'Plot', alignRight: false },
  { id: 'posterUrl_header', label: 'Poster', alignRight: false },
  { id: 'action_header' },
];

interface Page {
  size: number;
  totalElements: number;
  totalPages: number;
  number: number;
}


interface Genre {
  id: number;
  name: string;
  _links: {
    movies: {
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
      href: string,
    }
    genres: {
      href: string;
    }
  };
  genres_list: Genre[];
}

interface MovieListProps {
  urlMoviesList: string,
}
export default function MovieList({ urlMoviesList }: MovieListProps) {
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(20);
  const [pageData, setPageData] = useState<Page>({
    size: 0,
    totalElements: 0,
    totalPages: 0,
    number: 0
  } as Page);
  const [loadingData, setLoadingData] = useState(true);
  const [openMenu, setOpenMenu] = useState(null);
  const [targetMovieId, setTargetMovieId] = useState<number>(-1);
  const [movieList, setMovieList] = useState<Movie[]>([]);

  const [urlMovies, setUrlMovies] = useState("");
  const [urlMoviesWithPagination, setUrlMoviesWithPagination] = useState("");

  const [messageSnackbar, setMessageSnackbar] = useState("");
  const [statusSnackbar, setStatusSnackbar] = useState(0);
  const [openSnackBar, setOpenSnackBar] = useState(false);

  const [openAlertDelete, setOpenAlertDelete] = React.useState(false);

  const location = useLocation();

  const navigate = useNavigate();
  const handleChangePage = (event: any, newPage: number) => {
    setPage(newPage);
    let maxRecord = newPage * rowsPerPage + rowsPerPage;
    if (movieList.length < pageData.totalElements && movieList.length < maxRecord) {
      let queryQuotation = urlMovies.includes("?")? "&" : "?";
      setUrlMoviesWithPagination(urlMovies + queryQuotation + `page=${Math.ceil(maxRecord / 20) - 1}&size=20`);
      setLoadingData(true);
    }
  }

  const handleEdit = () => {
    navigate("/movie/edit", { state: { movie_id: targetMovieId, title: "Sửa thông tin phim" } })
  }

  const handleDeleteMovie = async () => {
    let responseDeleteMovie = await axios.delete("/movies/api/v1/movies/" + targetMovieId.toString());
    if (responseDeleteMovie.status !== 204) {
      setMessageSnackbar("Error ... Fail to delete movie...");
    }
    else {
      setMessageSnackbar("Delete movie successfully");
      setMovieList(movieList.slice(0, page * rowsPerPage));
      getMoviesAfterDelete(urlMoviesWithPagination);
    }
    setStatusSnackbar(responseDeleteMovie.status);
    setOpenSnackBar(true);
    setOpenAlertDelete(false);
  }

  const handleClickOpenAlertDelete = (event: React.MouseEvent<HTMLElement>) => {
      handleCloseMenu();
      setOpenAlertDelete(true);
  }

  const handleCloseAlertDelete = () => {
    setOpenAlertDelete(false);
  }

  const handleChangeRowsPerPage = (event: any) => {
    setPage(0);
    setRowsPerPage(parseInt(event.target.value, 10));
  }

  const handleOpenMenu = (event: any): void => {
    setOpenMenu(event.currentTarget);
    setTargetMovieId(parseInt(event.currentTarget.getAttribute("data-movie")));
  }

  const HtmlTooltip = styled(({ className, ...props }: TooltipProps) => (
    <Tooltip {...props} classes={{ popper: className }} />
  ))(({ theme }) => ({
    [`& .${tooltipClasses.tooltip}`]: {
      backgroundColor: '#f5f5f9',
      color: 'rgba(0, 0, 0, 0.87)',
      maxWidth: 220,
      fontSize: theme.typography.pxToRem(12),
      border: '1px solid #dadde9',
    },
  }));


  const handleCloseMenu = () => {
    setOpenMenu(null);
    setTargetMovieId(-1);
  };
  if (urlMoviesList !== urlMovies) {
    setUrlMovies(urlMoviesList);
    setUrlMoviesWithPagination(urlMoviesList);
    setMovieList([]);
    setPage(0);
  }

  const getMoviesAfterDelete = async (url: string) => {
    let responseMovies = await axios.get(url);
    setPageData(responseMovies.data.page);
    let new_movie_list: Movie[] = responseMovies.data._embedded.movies;
    for (const movie of new_movie_list) {
      let movie_genres_res = await axios.get(movie._links.genres.href);
      let _movie_genres_list: Genre[] = movie_genres_res.data._embedded.genres;
      movie.genres_list = _movie_genres_list;
    }
    setMovieList((_list) => _list === new_movie_list ? _list : [..._list, ...new_movie_list]);
    setLoadingData(false);
  }

  useEffect(() => {
    let isFetching = true;
    const handleMovieFormSnackBar = () => {
      if (location.state && location.state.snackBarContent) {
        setMessageSnackbar(location.state.snackBarContent);
        setStatusSnackbar(location.state.snackBarStatus);
        setOpenSnackBar(true);

        const state = location.state;
        delete state.snackBarContent;
        delete state.snackBarStatus;
        window.history.replaceState(state, document.title);
      }
    }
    const getMoviesData = async () => {
      setLoadingData(true);
      let responseMovies = await axios.get(urlMoviesWithPagination);
      if (isFetching) {
        setPageData(responseMovies.data.page);
        let new_movie_list: Movie[] = responseMovies.data._embedded.movies;
        for (const movie of new_movie_list) {
          let movie_genres_res = await axios.get(movie._links.genres.href);
          let _movie_genres_list: Genre[] = movie_genres_res.data._embedded.genres;
          movie.genres_list = _movie_genres_list;
        }
        setMovieList((_list) => _list === new_movie_list ? _list : [..._list, ...new_movie_list]);
        setLoadingData(false);
        handleMovieFormSnackBar();
      }
    }
    getMoviesData();
    return () => {
      isFetching = false;
    }
  }, [location.state, urlMoviesWithPagination]);

  return (loadingData) ?
    <Box sx={{ display: 'flex', m: 2 }}
      justifyContent="center"
      alignItems="center">
      <CircularProgress /> <Typography sx={{ mx: 2 }}>Loading ...</Typography>
    </Box> :
    <>
      <Card>
        <TableContainer sx={{ minWidth: 800 }}>
          <Table>
            <TableHead sx={{
              "& th": {
                color: "white",
                backgroundColor: "#2196f3",
                fontWeight: "bold"
              }
            }}>
              <TableRow>
                {TABLE_HEAD.map((headCell) => (
                  <TableCell
                    key={headCell.id}
                    align={headCell.alignRight ? 'right' : 'left'}
                  >
                    {headCell.label}
                  </TableCell>
                ))}
              </TableRow>
            </TableHead>
            <TableBody>
              {
                pageData.totalElements === 0 ?
                  <Box sx={{ display: 'flex', m: 2 }}
                    justifyContent="center"
                    alignItems="center">
                    Sorry, no movie info
                  </Box> :
                  movieList.slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage).map((movie) => {
                    return (
                      <TableRow hover key={movie._links.self.href} tabIndex={-1} role="checkbox">
                        <TableCell align="left">{movie.id}</TableCell>

                        <TableCell align="left">
                          <Typography variant="h6">{movie.title}</Typography>
                          <Stack direction="row" spacing={2} >
                            <Typography variant="caption">{movie.year}</Typography>
                            <Typography variant="caption">
                              <div style={{
                                display: 'flex',
                                alignItems: 'center',
                                flexWrap: 'wrap',
                              }}>
                                <AccessTimeIcon fontSize="small" />
                                <Typography variant="caption" sx={{ mx: 1 }}> {movie.runtime}'</Typography>
                              </div>
                            </Typography>
                          </Stack>
                        </TableCell>

                        <TableCell align="left">{
                          movie.genres_list.map((genre) => <Typography key={"genre" + genre.id.toString() + "movie" + movie.id.toString()} variant="body2">{genre.name}</Typography>)}</TableCell>

                        <TableCell align="left" sx={{ width: 100, maxWidth: 100 }}>
                          {movie.director}
                        </TableCell>

                        <TableCell align="left" sx={{ width: 200, maxWidth: 200 }}>
                          <ShowMoreText
                            lines={2}
                            more="[Show more]"
                            less="[Show less]"
                            className="content-css"
                            anchorClass="show-more-less-clickable"
                            truncatedEndingComponent={"... "}
                            width={200}
                          >{movie.actors}
                          </ShowMoreText></TableCell>

                        <TableCell align="left">


                          <HtmlTooltip
                            title={
                              <React.Fragment>
                                <Typography color="inherit"><b>{movie.title}</b> <em>({movie.year})</em></Typography>
                                {movie.plot}
                              </React.Fragment>
                            }
                          >
                            <Link href="#" variant="body2">Show plot</Link>
                          </HtmlTooltip>

                        </TableCell>

                        <TableCell align="left">
                          <HtmlTooltip
                            title={
                              <React.Fragment>
                                <img src={movie.posterUrl} alt={movie.title} height="300" />
                              </React.Fragment>
                            }
                          >
                            <Link href="#" variant="body2">Show poster</Link>
                          </HtmlTooltip>
                        </TableCell>

                        <TableCell align="right">
                          <IconButton size="large" color="inherit" data-movie={movie.id} onClick={handleOpenMenu}>
                            <MoreVertIcon />
                          </IconButton>
                        </TableCell>

                      </TableRow>)
                  }
                  )}
            </TableBody>
          </Table>
        </TableContainer>
        <TablePagination
          rowsPerPageOptions={[5, 10, 20]}
          component="div"
          count={pageData.totalElements}
          rowsPerPage={rowsPerPage}
          page={page}
          onPageChange={handleChangePage}
          onRowsPerPageChange={handleChangeRowsPerPage}
        />

      </Card>
      <Popover
        open={Boolean(openMenu)}
        anchorEl={openMenu}
        onClose={handleCloseMenu}
        anchorOrigin={{ vertical: 'top', horizontal: 'left' }}
        transformOrigin={{ vertical: 'top', horizontal: 'right' }}
        PaperProps={{
          sx: {
            p: 1,
            width: 140,
            '& .MuiMenuItem-root': {
              px: 1,
              typography: 'body2',
              borderRadius: 0.75,
            },
          },
        }}
      >
        <MenuItem key={"edit" + targetMovieId.toString()} onClick={handleEdit}>
          Edit
        </MenuItem>

        <MenuItem key={"delete" + targetMovieId.toString()} sx={{ color: 'error.main' }} onClick={handleClickOpenAlertDelete}>
          Delete
        </MenuItem>
      </Popover>

      <Dialog
        open={openAlertDelete}
        onClose={handleCloseAlertDelete}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogTitle id="alert-dialog-title">
          {"Delete movie?"}
        </DialogTitle>
        <DialogContent>
          <DialogContentText id="alert-dialog-description">
            Are you sure you want to delete this movie?
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleDeleteMovie}>Delete this movie</Button>
          <Button onClick={handleCloseAlertDelete} autoFocus>
            Cancel
          </Button>
        </DialogActions>
      </Dialog>

      <SnackBarMovie messageSnackbar={messageSnackbar}
        statusSnackbar={statusSnackbar}
        openSnackBar={openSnackBar}
        setOpenSnackBar={setOpenSnackBar} />
    </>
}