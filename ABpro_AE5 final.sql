CREATE DATABASE ABpro_AE5;
USE ABpro_AE5;
CREATE USER 'ADMIN_AE52'@'localhost' IDENTIFIED BY '123456278';
GRANT ALL PRIVILEGES ON ABpro_AE5.* TO 'ADMIN_AE5'@'localhost';
FLUSH PRIVILEGES;

CREATE TABLE usuarios (
id_usuario INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
contrasena VARCHAR(12) NOT NULL,
zona_horaria VARCHAR(50) NOT NULL DEFAULT 'UTC-3',
genero VARCHAR(20) NOT NULL,
telefono_contacto VARCHAR(20) NOT NULL
);

CREATE TABLE registro_ingreso (
id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
id_usuario INT NOT NULL,
FH_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

ALTER TABLE usuarios MODIFY zona_horaria VARCHAR(50) DEFAULT 'UTC-2';

INSERT INTO usuarios (nombre, apellido, contrasena, genero, telefono_contacto) VALUES 
  ('Juan', 'Pérez', '123456', 'M', '+56912345678'),
  ('María', 'García', 'qwerty', 'F', '+56987654321'),
  ('Pedro', 'Martínez', 'abc123', 'M', '+56911111111'),
  ('Sofía', 'Sánchez', '87654321', 'F', '+56922222222'),
  ('Carlos', 'Rodríguez', 'a1b2c3', 'M', '+56933333333'),
  ('Laura', 'Hernández', '098765', 'F', '+56944444444'),
  ('Miguel', 'González', 'pass123', 'M', '+56955555555'),
  ('Ana', 'López', 'abcxyz', 'F', '+56966666666');

INSERT INTO registro_ingreso (id_usuario) VALUES
('1'), ('2'), ('5'), ('1'), ('5'), ('1'), ('7'), ('8');

/* Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?

R: si bien, es posible definir los tipos de datos de formas variadas,
en este caso por practicidad no se ahonda de forma especifica en el tipo de dato
(ej. en columna genero es posible definirle alternativas preestablecidas)
de modo que optamos por el tipo de dato que cumpliera lo establecido en por el criterio del ejercicio,
y no una forma "perfecta", sino aceptando datos amplios, funcional y optima.*/

CREATE TABLE contactos (
id_contacto INT AUTO_INCREMENT PRIMARY KEY,
id_usuario INT NOT NULL,
numero_telefono VARCHAR (20) NOT NULL,
correo VARCHAR (50) NOT NULL
/*FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)*/
);

-- agregamos una restriccion UNIQUE a la columna telefono_contacto de la tabla usuarios--
ALTER TABLE usuarios
ADD CONSTRAINT UC_telefono_contacto UNIQUE (telefono_contacto);

-- vamos a modificar la llave primaria de la tabla usuarios -- 
ALTER TABLE usuarios
DROP PRIMARY KEY, ADD PRIMARY KEY(id_usuario, telefono_contacto);

-- agregamos la nueva clave foranea compuesta a la tabla contactos para crear el vinculo -- 

ALTER TABLE contactos 
ADD CONSTRAINT FK_usuario_telefono_contacto FOREIGN KEY (id_usuario, numero_telefono) REFERENCES usuarios(id_usuario, telefono_contacto);
 
