CREATE DATABASE compra_venta;

USE mercadolibre;

CREATE TABLE usuarios (
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40),
    fecha_nacimiento DATE,
    dni INT NOT NULL UNIQUE
);

CREATE TABLE rubros (
	id_rubro INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rubro VARCHAR(30) NOT NULL
    );
    
CREATE TABLE metodos_pago (
	id_metodopago INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(40) NOT NULL
    );

CREATE TABLE direcciones (
	id_direccion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    codigo_postal INT,
    provincia VARCHAR(40),
    localidad VARCHAR(40),
    calle VARCHAR(40),
    numero INT,
    usuario INT,
    FOREIGN KEY(usuario) REFERENCES usuarios(id_usuario)
    );

CREATE TABLE envios (
	id_envio INT AUTO_INCREMENT PRIMARY KEY,
    direccion INT NOT NULL,
    especificaciones VARCHAR(100),
    FOREIGN KEY(direccion) REFERENCES direcciones(id_direccion)
    );

CREATE TABLE articulos (
	id_articulo INT AUTO_INCREMENT PRIMARY KEY,
    vendedor INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    cantidad_disponible INT DEFAULT(1),
    rubro INT,
    FOREIGN KEY(vendedor) REFERENCES usuarios(id_usuario),
    FOREIGN KEY(rubro) REFERENCES rubros(id_rubro)
    );

CREATE TABLE c_v_detalle (
	id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    articulo INT NOT NULL,
    cantidad INT DEFAULT(1),
    monto_total DECIMAL(10, 2) NOT NULL,
    metodo_pago INT NOT NULL,
    envio INT,
    FOREIGN KEY(articulo) REFERENCES articulos(id_articulo),
    FOREIGN KEY(metodo_pago) REFERENCES metodos_pago(id_metodopago),
    FOREIGN KEY(envio) REFERENCES envios(id_envio)
    );

CREATE TABLE compra_venta (
	id_compraventa INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL,
    comprador INT NOT NULL,
    vendedor INT NOT NULL,
    detalle INT NOT NULL,
    FOREIGN KEY(comprador) REFERENCES usuarios(id_usuario),
    FOREIGN KEY(vendedor) REFERENCES usuarios(id_usuario),
    FOREIGN KEY(detalle) REFERENCES c_v_detalle(id_detalle)
    );