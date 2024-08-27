CREATE DATABASE site_animemanga;
USE site_animemanga;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    role ENUM('user', 'moderador') NOT NULL,
    criacao_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizacao_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE moderadores (
    user_id INT PRIMARY KEY,
    permissoes JSON,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE animes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    lancamento DATE NOT NULL,
    episodios INT NOT NULL,
    sinopse TEXT,
    status VARCHAR(50) NOT NULL,
    imagem VARCHAR(255),
    criacao_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizacao_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE mangas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    lancamento DATE NOT NULL,
    capitulo INT NOT NULL,
    sinopse TEXT,
    status VARCHAR(50) NOT NULL,
    imagem VARCHAR(255),
    criacao_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizacao_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE avaliacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    anime_id INT NULL,
    manga_id INT NULL,
    nota INT NOT NULL,
    comentario TEXT,
    criacao_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizacao_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (anime_id) REFERENCES animes(id),
    FOREIGN KEY (manga_id) REFERENCES mangas(id)
);

CREATE TABLE genero (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE anime_genero (
    anime_id INT NOT NULL,
    genero_id INT NOT NULL,
    PRIMARY KEY (anime_id, genero_id),
    FOREIGN KEY (anime_id) REFERENCES animes(id),
    FOREIGN KEY (genero_id) REFERENCES genero(id)
);

CREATE TABLE manga_genero (
    manga_id INT NOT NULL,
    genero_id INT NOT NULL,
    PRIMARY KEY (manga_id, genero_id),
    FOREIGN KEY (manga_id) REFERENCES mangas(id),
    FOREIGN KEY (genero_id) REFERENCES genero(id)
);

CREATE TABLE favoritos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    anime_id INT NULL,
    manga_id INT NULL,
    criacao_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizacao_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (anime_id) REFERENCES animes(id),
    FOREIGN KEY (manga_id) REFERENCES mangas(id)
);