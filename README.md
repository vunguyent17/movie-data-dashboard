# Movie Data Dashboard Website

<img src="https://github.com/vunguyent17/movie-data-dashboard/blob/main/Screenshots/MovieDataDashboard_1.png" data-canonical-src="https://github.com/vunguyent17/movie-data-dashboard/blob/main/Screenshots/MovieDataDashboard_1.png" style="display:block; margin-left: auto; margin-right: auto; width: 80%" alt="Trang chủ" />

## Giới thiệu / Introduction

Movie Data Dashboard Website là ứng dụng website cho phép quản lý dữ liệu phim trên cơ sở dữ liệu.
<br/>

Movie Data Dashboard Website is a web application that allows users to browse and manage movie information database.
The website is a Spring Boot application as back end with simple UI using React.js

### Chức năng của ứng dụng / Functionality:
- Hiển thị danh sách phim, thể loại phim. Hiển thị phim theo thể loại
- Thêm, xóa, sửa phim, thể loại phim trong cơ sở dữ liệu
- Tìm kiếm phim theo tiêu đề và hiển thị kết quả phim. 

 <br/>

- Display all movies and genres. Display movies by genres
- Add, delete, modify movies and genres database
- Search movie by title keywords


### Công nghệ sử dụng / Tech stack:
- Programming Language: Java, TypeScript
- Database: PostgreSQL
- Backend API: Spring Boot Application (using Spring Data JPA, Spring Data REST, Thymeleaf)
- Frontend: ReactJS, Material UI library component


## Demo
[Link website application](https://movie-data-dashboard.onrender.com/)
<br/>
[Link API](https://movie-data-dashboard.onrender.com/movies/api/v1)

## Set up project locally
### Prerequisites
- Node.js
- Java 17
- PostgreSQL, pgAdmin 4
- (Optional) IntelliJ
- (Optional) Docker

### Installation

1. Clone the repo

2. Create file env in root folder
```
DATABASE_HOST=host.docker.internal
DATABASE_PORT=5432
DATABASE_NAME=MovieData
DATABASE_USERNAME=<your database username here>
DATABASE_PASSWORD=<your database password here>
```

2. Create database
- Connect pgAdmin to local PostgreDB Database. Create PostgreSQL Database `MovieData` on local.
- Restore database from file BinhLuanPhim.sql

3. To run on Docker:
- Run `docker build -t docker_movie_data_api .` to build static files
- Run `docker run -p 8080:8080 --env-file .env docker_movie_data_api` to run web server at localhost:8080 

4. To run on IntelliJ:
- Run `./mvnw clean package -DskipTests` to build static files
- Run application on IntelliJ

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
