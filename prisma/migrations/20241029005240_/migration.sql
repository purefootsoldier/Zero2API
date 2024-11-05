BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[User] (
    [id] INT NOT NULL IDENTITY(1,1),
    [username] NVARCHAR(1000) NOT NULL,
    [password] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [User_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [User_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [User_username_key] UNIQUE NONCLUSTERED ([username])
);

-- CreateTable
CREATE TABLE [dbo].[Pedido] (
    [id_pedido] INT NOT NULL IDENTITY(1,1),
    [id_mesa] INT NOT NULL,
    [id_clientes] INT NOT NULL,
    [fecha] DATETIME2 NOT NULL,
    [total] FLOAT(53) NOT NULL,
    [id_empleado] INT NOT NULL,
    [tipo_pedido] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Pedido_pkey] PRIMARY KEY CLUSTERED ([id_pedido])
);

-- CreateTable
CREATE TABLE [dbo].[Ticket] (
    [id_ticket] INT NOT NULL IDENTITY(1,1),
    [id_pedido] INT NOT NULL,
    [id_metodo_pago] INT NOT NULL,
    [total] FLOAT(53) NOT NULL,
    CONSTRAINT [Ticket_pkey] PRIMARY KEY CLUSTERED ([id_ticket])
);

-- CreateTable
CREATE TABLE [dbo].[DetallePedido] (
    [id_detalle_pedido] INT NOT NULL IDENTITY(1,1),
    [id_pedido] INT NOT NULL,
    [id_menu] INT NOT NULL,
    [cantidad] INT NOT NULL,
    [subtotal] FLOAT(53) NOT NULL,
    CONSTRAINT [DetallePedido_pkey] PRIMARY KEY CLUSTERED ([id_detalle_pedido])
);

-- CreateTable
CREATE TABLE [dbo].[Pago] (
    [id] INT NOT NULL IDENTITY(1,1),
    [id_pedido] INT NOT NULL,
    [id_metodo_pago] INT NOT NULL,
    [fecha_pago] DATETIME2 NOT NULL CONSTRAINT [Pago_fecha_pago_df] DEFAULT CURRENT_TIMESTAMP,
    [total] FLOAT(53) NOT NULL,
    CONSTRAINT [Pago_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Menu] (
    [id_menu] INT NOT NULL IDENTITY(1,1),
    CONSTRAINT [Menu_pkey] PRIMARY KEY CLUSTERED ([id_menu])
);

-- CreateTable
CREATE TABLE [dbo].[Metodo_Pago] (
    [id_metodo_pago] INT NOT NULL IDENTITY(1,1),
    [nombre] NVARCHAR(1000),
    [tipo] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Metodo_Pago_pkey] PRIMARY KEY CLUSTERED ([id_metodo_pago])
);

-- AddForeignKey
ALTER TABLE [dbo].[Ticket] ADD CONSTRAINT [Ticket_id_pedido_fkey] FOREIGN KEY ([id_pedido]) REFERENCES [dbo].[Pedido]([id_pedido]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Ticket] ADD CONSTRAINT [Ticket_id_metodo_pago_fkey] FOREIGN KEY ([id_metodo_pago]) REFERENCES [dbo].[Metodo_Pago]([id_metodo_pago]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[DetallePedido] ADD CONSTRAINT [DetallePedido_id_pedido_fkey] FOREIGN KEY ([id_pedido]) REFERENCES [dbo].[Pedido]([id_pedido]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[DetallePedido] ADD CONSTRAINT [DetallePedido_id_menu_fkey] FOREIGN KEY ([id_menu]) REFERENCES [dbo].[Menu]([id_menu]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Pago] ADD CONSTRAINT [Pago_id_pedido_fkey] FOREIGN KEY ([id_pedido]) REFERENCES [dbo].[Pedido]([id_pedido]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Pago] ADD CONSTRAINT [Pago_id_metodo_pago_fkey] FOREIGN KEY ([id_metodo_pago]) REFERENCES [dbo].[Metodo_Pago]([id_metodo_pago]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
