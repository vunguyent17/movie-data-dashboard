import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Home from './home/Home';
import MovieForm from './movieSettings/MovieForm';
import SearchMovies from './movieSettings/SearchMovies';

export default function Router(){ 
  return (
    <BrowserRouter>
      <div>
        <Routes>
          <Route index element={<Home />} />
          <Route path="/movie/new" element={<MovieForm />} />
          <Route path="/movie/edit" element={<MovieForm />} />
          <Route path="/movie/search" element={<SearchMovies />} />
        </Routes> 
      </div>
    </BrowserRouter>
  );
};