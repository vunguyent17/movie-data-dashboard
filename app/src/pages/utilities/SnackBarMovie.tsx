import * as React from 'react';

// @mui
import {
  IconButton,
  Snackbar,
} from '@mui/material';

import CloseIcon from '@mui/icons-material/Close';
import MuiAlert, { AlertProps } from '@mui/material/Alert';
 interface SnackBarMovieProps {
  messageSnackbar: string,
  statusSnackbar: number,
  openSnackBar: boolean,
  setOpenSnackBar:(_activate: boolean) => void
}

export default function SnackBarMovie({messageSnackbar, statusSnackbar,  openSnackBar, setOpenSnackBar }: SnackBarMovieProps) {

  const Alert = React.forwardRef<HTMLDivElement, AlertProps>(function Alert(
    props,
    ref,
  ) {
    return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
  });

  const handleCloseSnackBar = (event: React.SyntheticEvent | Event, reason?: string) => {
    if (reason === 'clickaway') {
      return;
    }
    setOpenSnackBar(false);
  };

  const action = (
    <React.Fragment>
      <IconButton
        size="small"
        aria-label="close"
        color="inherit"
        onClick={handleCloseSnackBar}
      >
        <CloseIcon fontSize="small" />
      </IconButton>
    </React.Fragment>
  );

  return (
    <Snackbar
      open={openSnackBar}
      autoHideDuration={6000}
      onClose={handleCloseSnackBar}
      action={action}>
      <Alert onClose={handleCloseSnackBar} severity={~~(statusSnackbar / 100) === 2 ? 'success' : 'error'} sx={{ width: '100%' }}>
        {messageSnackbar}
      </Alert>
    </Snackbar>
  )
}