import { useState } from 'react';
import axios from 'axios';
import * as React from 'react';

import {
  Button,
  IconButton,
  DialogActions,
  Dialog,
  DialogTitle,
  TextField,
  DialogContent,
  Box,
  styled,
  InputBase,
  alpha,
  Stack,
} from '@mui/material';
import AddIcon from '@mui/icons-material/Add';
import SettingsIcon from '@mui/icons-material/Settings';
import MovieIcon from '@mui/icons-material/Movie';
import SearchIcon from '@mui/icons-material/Search';
import GenreListDialog from './GenreListDialog';
import SnackBarMovie from '../utilities/SnackBarMovie';

interface GenreSettingsProps {
  reloadGenreList?: (activate: boolean) => void;
}

const StyledInputBase = styled(InputBase)(({ theme }) => ({
  color: 'inherit',
  '& .MuiInputBase-input': {
    padding: theme.spacing(1, 1, 1, 0),
    // vertical padding + font size from searchIcon
    paddingLeft: `calc(1em + ${theme.spacing(4)})`,
    transition: theme.transitions.create('width'),
    width: '100%',
    [theme.breakpoints.up('sm')]: {
      width: '14ch',
      '&:focus': {
        width: '20ch',
      },
    },
  },
}));

const Search = styled('div')(({ theme }) => ({
  position: 'relative',
  borderRadius: theme.shape.borderRadius,
  border: 1,
  backgroundColor: alpha(theme.palette.common.black, 0.05),
  '&:hover': {
    backgroundColor: alpha(theme.palette.common.black, 0.10),
  },
  marginLeft: 0,
  width: '100%',
  [theme.breakpoints.up('sm')]: {
    marginLeft: theme.spacing(1),
    width: 'auto',
  },
}));

const SearchIconWrapper = styled('div')(({ theme }) => ({
  padding: theme.spacing(0, 2),
  height: '100%',
  position: 'absolute',
  pointerEvents: 'none',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
}));


export default function GenreSettings(props: GenreSettingsProps) {
  const [newGenre, setNewGenre] = useState("");
  const [openGenreDialog, setOpenGenreDialog] = useState(false);
  const [messageSnackbar, setMessageSnackbar] = useState("");
  const [statusSnackbar, setStatusSnackbar] = useState(0);
  const [openSnackBar, setOpenSnackBar] = useState(false);

  const [urlGenreQuery, setUrlGenreQuery] = useState("/movies/api/v1/genres");

  const [reloadListDialog, setReloadListDialog] = useState(Date.now());

  const handleSearchGenreName = (event: React.ChangeEvent<HTMLInputElement>) => {
    let keyword = event.target.value;
    if (keyword !== "") {
      setUrlGenreQuery("/movies/api/v1/genres/search/byKeyword?keyword=" + event.target.value);
    }
    else {
      setUrlGenreQuery("/movies/api/v1/genres");
    }
  }

  const handleOpenGenreDialog = () => {
    setOpenGenreDialog(true);
  };

  const handleCloseGenreDialog = () => {
    setOpenGenreDialog(false);
    if (props.reloadGenreList) {
      props.reloadGenreList(true);
    }
  };

  const handleInputNewGenre = (event: React.ChangeEvent<HTMLInputElement>) => {
    setNewGenre(event.target.value);
  }

  const handleSaveNewGenre = async () => {
    if (newGenre === "")
    {
      setMessageSnackbar("Please type a genre name");
      setStatusSnackbar(404);
    }
    else
    {
      let responseSave = await axios.post("/movies/api/v1/genres", { "name": newGenre });
      if (responseSave.status === 201) {
        setMessageSnackbar("Save new genre successfully");
        setReloadListDialog(Date.now());
      }
      else {
        setMessageSnackbar("Error ... Fail to save new genre ...");
      }
      setStatusSnackbar(responseSave.status);
    }
    setOpenSnackBar(true);
  }

  return (
    <div>
      <div>
        <IconButton size="large" color="inherit" onClick={handleOpenGenreDialog}>
          <SettingsIcon />
        </IconButton>

        <Dialog open={openGenreDialog} onClose={handleCloseGenreDialog} maxWidth="md" fullWidth>
          <DialogTitle sx={{ color: 'primary.main', fontWeight: 'medium' }} >Genre Settings</DialogTitle>
          <DialogContent>
            <Stack direction="row" alignItems="center" justifyContent="space-between" sx={{ mb: 3 }}>
              <Box sx={{ display: 'flex', alignItems: 'flex-end' }}>
                <MovieIcon sx={{ color: 'action.active', mr: 1, mb: 0.5 }} />
                <TextField
                  sx={{ mr: 2 }}
                  margin="dense"
                  id="genre-name"
                  label="Type new genre name ..."
                  type="text"
                  variant="standard"
                  onChange={handleInputNewGenre}
                />
                <Button variant="text" size="small" onClick={handleSaveNewGenre} startIcon={<AddIcon />}>Add</Button>
              </Box>
              <Search>
                <SearchIconWrapper>
                  <SearchIcon />
                </SearchIconWrapper>
                <StyledInputBase
                  placeholder="Search genre ..."
                  inputProps={{ 'aria-label': 'search' }}
                  onChange={handleSearchGenreName}
                />
              </Search>

            </Stack>
            <GenreListDialog key={reloadListDialog} urlGenreQuery={urlGenreQuery} />

          </DialogContent>
          <DialogActions>
            <Button sx={{ m: 2 }} variant="contained" onClick={handleCloseGenreDialog}>Close</Button>
          </DialogActions>
        </Dialog>
      </div>
      <SnackBarMovie messageSnackbar={messageSnackbar}
        statusSnackbar={statusSnackbar}
        openSnackBar={openSnackBar}
        setOpenSnackBar={setOpenSnackBar} />
    </div>)
}

