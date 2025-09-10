--drop database [Practica_01]

USE [master]
go
CREATE DATABASE [Practica_01]
GO
USE [Practica_01]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Detalles_Facturas](
	[id_detalle] [int] NOT NULL,
	[id_factura] [int] NOT NULL,
	[id_articulo] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio] [float] NOT NULL,
 CONSTRAINT [PK_Detalles_Factura] PRIMARY KEY CLUSTERED 
(
	[id_detalle] ASC,
	[id_factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Facturas](
	[id_factura] [int] IDENTITY(1,1) NOT NULL,
	[cliente] [varchar](50) NOT NULL,
	[fecha] [datetime] NOT NULL,
	
 CONSTRAINT [PK_T_Facturas] PRIMARY KEY CLUSTERED 
(
	[id_factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[T_Articulos](
	[id_articulo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[stock] [int] NOT NULL,
	[precio] [float] NULL,
 CONSTRAINT [PK_T_Articulos] PRIMARY KEY CLUSTERED 
(
	[id_articulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--
CREATE TABLE [dbo].[T_FormasPago](
	[id_forma_pago] [int] IDENTITY(1,1) NOT NULL,
	[descripcion][varchar](50) NOT NULL,
	
 CONSTRAINT [PK_T_FormasPago] PRIMARY KEY CLUSTERED 
(
	[id_forma_pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
      IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
      ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T_Facturas]
ADD id_forma_pago INT NOT NULL
    CONSTRAINT FK_Facturas_FormasPago FOREIGN KEY (id_forma_pago)
    REFERENCES [dbo].[T_FormasPago] (id_forma_pago);
GO
INSERT INTO T_FormasPago (descripcion) VALUES ('Efectivo');
INSERT INTO T_FormasPago (descripcion) VALUES ('Tarjeta de crédito');
INSERT INTO T_FormasPago (descripcion) VALUES ('Transferencia bancaria');
go
--
INSERT [dbo].[T_Detalles_Facturas] ([id_detalle], [id_factura], [id_articulo], [cantidad], [precio]) VALUES (1, 1, 1, 10, 1000)
GO
INSERT [dbo].[T_Detalles_Facturas] ([id_detalle], [id_factura], [id_articulo], [cantidad], [precio])  VALUES (1, 2, 1, 1, 5000)
GO
INSERT [dbo].[T_Detalles_Facturas] ([id_detalle], [id_factura], [id_articulo], [cantidad], [precio]) VALUES (2, 1, 2, 5, 2000)
GO
SET IDENTITY_INSERT [dbo].[T_Facturas] ON 
GO
INSERT [dbo].[T_Facturas] ([id_factura], [cliente], [fecha],[id_forma_pago]) VALUES (1, N'Cliente 1', CAST(N'2025-09-02T16:58:03.200' AS DateTime),1)
GO
INSERT [dbo].[T_Facturas] ([id_factura], [cliente], [fecha],[id_forma_pago]) VALUES (2, N'Cliente 2', CAST(N'2025-09-02T17:08:18.470' AS DateTime),2)
GO
SET IDENTITY_INSERT [dbo].[T_facturas] OFF
GO
SET IDENTITY_INSERT [dbo].[T_Articulos] ON 
GO
INSERT [dbo].[T_Articulos] ([id_articulo], [nombre], [stock],[precio]) VALUES (1, N'Coca Cola Zero 2.25 L', 200, 4599.99)
GO
INSERT [dbo].[T_Articulos] ([id_articulo], [nombre], [stock],[precio])  VALUES (2, N'Pritty Limón 3L', 150, 2346.75)
GO
INSERT [dbo].[T_Articulos] ([id_articulo], [nombre], [stock],[precio])  VALUES (3, N'Paso de los Toros Pomelo 1.5L', 250, 2279.25)
GO
INSERT [dbo].[T_Articulos] ([id_articulo], [nombre], [stock],[precio])  VALUES (4, N'7up Lima Limón', 225, 1823.4)
GO
INSERT [dbo].[T_Articulos] ([id_articulo], [nombre], [stock],[precio])  VALUES (5, N'Schweppes Zero Pomelo', 250,  2990)
GO
SET IDENTITY_INSERT [dbo].[T_Articulos] OFF
GO

ALTER TABLE [dbo].[T_Detalles_Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Factura_T_Factura] FOREIGN KEY([id_factura])
REFERENCES [dbo].[T_Facturas] ([id_factura])
GO
ALTER TABLE [dbo].[T_Detalles_Facturas] CHECK CONSTRAINT [FK_Detalles_Factura_T_Factura]
GO
ALTER TABLE [dbo].[T_Detalles_Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Factura_T_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[T_Articulos] ([id_articulo])
GO
ALTER TABLE [dbo].[T_Detalles_Facturas] CHECK CONSTRAINT [FK_Detalles_Factura_T_Articulos]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GUARDAR_ARTICULO]
@id_articulo int ,
@nombre varchar(20),
@precio float,
@stock int
AS
BEGIN 
	IF @id_articulo = 0
		BEGIN
			insert into T_Articulos(nombre,precio, stock) 
			values (@nombre,@precio,@stock)	
		END
	ELSE
		BEGIN
			update T_Articulos
			set nombre = @nombre, precio= @precio, stock= @stock 
			where id_articulo=@id_articulo
		END
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INSERTAR_DETALLE] 
    @id_detalle int,
	@id_factura int,
	@id_articulo int,
	@cantidad int,
	@precio float

AS
BEGIN
	INSERT INTO T_Detalles_Facturas(id_detalle, id_factura, id_articulo, cantidad, precio) VALUES (@id_detalle, @id_factura,@id_articulo , @cantidad, @precio);
	
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INSERTAR_MAESTRO] 
	@cliente varchar(50),
	@id_factura int output
AS
BEGIN
	INSERT INTO T_Facturas(cliente, fecha) VALUES (@cliente, GETDATE());
	SET @id_factura= SCOPE_IDENTITY();
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RECUPERAR_FACTURA_POR_ID]
	@id_factura int
AS
BEGIN
	SELECT f.*, df.precio, df.cantidad, a.*
	  FROM T_Facturas f
	  INNER JOIN T_Detalles_Facturas df ON df.id_factura =f.id_factura
	  INNER JOIN T_Articulos a ON (a.id_articulo= df.id_articulo)
	  WHERE f.id_factura = @id_factura;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RECUPERAR_FACTURAS]
AS
BEGIN
	SELECT f.*, df.precio, df.cantidad, a.*
	  FROM T_Facturas f
	  INNER JOIN T_Detalles_Facturas df ON df.id_factura =f.id_factura
	  INNER JOIN T_Articulos a ON (a.id_articulo= df.id_articulo)

	  ORDER BY a.id_articulo;
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RECUPERAR_ARTICULO_POR_CODIGO]
	@id_articulo int
AS
BEGIN
	SELECT * FROM T_Articulos WHERE id_articulo = @id_articulo;
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RECUPERAR_ARTICULOS] 
AS
BEGIN
	SELECT * FROM T_Articulos
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------me falta esta activo de tabla !!
--CREATE PROCEDURE [dbo].[SP_REGISTRAR_BAJA_ARTICULOS] 
--	@id_articulo int 

--AS
--BEGIN
--	UPDATE T_Articulos SET esta_activo = 0 WHERE id_articulo = @id_articulo;
--END
--GO
--USE [master]
--GO
ALTER DATABASE [Practica_01] SET  READ_WRITE 
GO


select *from T_Facturas
