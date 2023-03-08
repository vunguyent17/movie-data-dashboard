import { useEffect, useState } from 'react';
import axios from 'axios';
import * as React from 'react';

import {
  IconButton,
  ListItem,
  List,
  ListItemText,
  ListItemIcon,
  Box,
  CircularProgress,
  Typography,
  DialogActions,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogContentText,
  Button,
  TextField,
} from '@mui/material';
import MovieIcon from '@mui/icons-material/Movie';
import DeleteIcon from '@mui/icons-material/Delete';
import SaveIcon from '@mui/icons-material/Save';
import ModeEditIcon from '@mui/icons-material/ModeEdit';
import SnackBarMovie from '../utilities/SnackBarMovie';

interface Genre {
  id: number;
  name: string;
  _links: {
    movies: {
      href: string;
    }
  }
}

interface GenreListDialogProps {
  urlGenreQuery: string;
}
export default function GenreListDialog({ urlGenreQuery }: GenreListDialogProps) {
  const [loadingData, setLoadingData] = useState(true);
  const [genreList, setGenreList] = useState<Genre[]>([]);
  const [deleteGenreId, setDeleteGenreId] = useState(-1);
  const [editGenreId, setEditGenreId] = useState(-1);
  const [editGenre, setEditGenre] = useState("");
  const [reloadData, setReloadData] = useState(0);

  const [messageSnackbar, setMessageSnackbar] = useState("");
  const [statusSnackbar, setStatusSnackbar] = useState(0);
  const [openSnackBar, setOpenSnackBar] = useState(false);

  const [openAlertDelete, setOpenAlertDelete] = React.useState(false);

  const handleEditGenre = (event: React.MouseEvent<HTMLElement>) => {
    let _idGenre = event.currentTarget.getAttribute('data-genre-id');
    if (_idGenre) {
      let idGenre = parseInt(_idGenre)
      setEditGenreId(idGenre);
      let genreTarget = genreList.find((genre) => genre.id === idGenre);
      if (genreTarget) {
        setEditGenre(genreTarget.name);
      }

    }
  };

  const handleDeleteGenre = async () => {
    setOpenAlertDelete(false);
    let responseGetGenreMovies = await axios.get(`/movies/api/v1/genres/${deleteGenreId}/movies`);
    if (responseGetGenreMovies.data.page.totalElements === 0) {
      let responseDeleteGenre = await axios.delete("/movies/api/v1/genres/" + deleteGenreId.toString());
      setMessageSnackbar(~~(responseDeleteGenre.status / 100) === 2 ?
        "Successfully delete genre" :
        "Error delete genre");
      setStatusSnackbar(responseDeleteGenre.status);
      setLoadingData(true);
      setReloadData((data) => data + 1);
    }
    else {
      setMessageSnackbar("Can't delete genre. There are movies that belong to this genre");
      setStatusSnackbar(404);
    }
    setOpenSnackBar(true);
    setDeleteGenreId(-1);

  }


  const handleClickOpenAlertDelete = (event: React.MouseEvent<HTMLElement>) => {
    let idGenre = event.currentTarget.getAttribute('data-genre-id');
    if (idGenre) {
      setDeleteGenreId(parseInt(idGenre));
      setOpenAlertDelete(true);
    }
  };

  const handleEditChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setEditGenre(event.target.value);
  }

  const handleUpdateGenre = async () => {
    let updateGenre = editGenre;
    let responseUpdateGenre = await axios.put("/movies/api/v1/genres/" + editGenreId.toString(), { name: updateGenre });
    setMessageSnackbar(~~(responseUpdateGenre.status / 100) === 2 ?
      "Successfully update genre" :
      "Error update genre");
    setStatusSnackbar(responseUpdateGenre.status);
    setOpenSnackBar(true);
    setEditGenreId(-1);
    setLoadingData(true);
    setReloadData((data) => data + 1);
  };

  const handleCloseAlertDelete = () => {
    setOpenAlertDelete(false);
  };


  useEffect(() => {
    async function getGenresData() {
      let genres_list: Genre[] = [];
      let nextLink = urlGenreQuery;

      setLoadingData(true);
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
  }, [reloadData, urlGenreQuery]);


  return <>
    <List sx={{
      bgcolor: 'background.paper',
      overflow: 'auto',
      height: 300,
      border: 1
    }}>
      {(loadingData) ?
        <Box sx={{ display: 'flex', m: 2 }}
          justifyContent="center"
          alignItems="center">
          <CircularProgress /> <Typography sx={{ mx: 2 }}>Loading ...</Typography>
        </Box> : genreList.map((genre) =>
          <ListItem key={"genre-" + genre.id.toString()}>
            <ListItemIcon>
              <MovieIcon />
            </ListItemIcon>
            {genre.id === editGenreId ?
              <TextField autoFocus value={editGenre}
                fullWidth
                variant="standard"
                onBlur={handleUpdateGenre}
                onChange={handleEditChange} />
              : <ListItemText primary={genre.name} />}
            <ListItemIcon>
              <IconButton data-genre-id={genre.id} onClick={handleClickOpenAlertDelete}>
                <DeleteIcon />
              </IconButton>
            </ListItemIcon>
            <ListItemIcon>
              {genre.id === editGenreId ?
                <IconButton data-genre-id={genre.id} onClick={handleUpdateGenre}>
                  <SaveIcon />
                </IconButton>
                : <IconButton data-genre-id={genre.id} onClick={handleEditGenre}>
                  <ModeEditIcon />
                </IconButton>}
            </ListItemIcon>
          </ListItem>,
        )}
    </List>
    <Dialog
      open={openAlertDelete}
      onClose={handleCloseAlertDelete}
      aria-labelledby="alert-dialog-title"
      aria-describedby="alert-dialog-description"
    >
      <DialogTitle id="alert-dialog-title">
        {"Delete genre?"}
      </DialogTitle>
      <DialogContent>
        <DialogContentText id="alert-dialog-description">
          Are you sure you want to delete this genre?
        </DialogContentText>
      </DialogContent>
      <DialogActions>
        <Button onClick={handleDeleteGenre}>Delete this genre</Button>
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