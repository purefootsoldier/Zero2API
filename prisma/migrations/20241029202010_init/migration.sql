/*
  Warnings:

  - You are about to drop the `mesa` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `id_cliente` to the `Pedidos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_empleado` to the `Pedidos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_mesa` to the `Pedidos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tipo_pedido` to the `Pedidos` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `mesa` DROP FOREIGN KEY `Mesa_id_empleado_fkey`;

-- AlterTable
ALTER TABLE `pedidos` ADD COLUMN `id_cliente` INTEGER NOT NULL,
    ADD COLUMN `id_empleado` INTEGER NOT NULL,
    ADD COLUMN `id_mesa` INTEGER NOT NULL,
    ADD COLUMN `tipo_pedido` VARCHAR(191) NOT NULL;

-- DropTable
DROP TABLE `mesa`;

-- CreateTable
CREATE TABLE `Mesas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `capacidad` INTEGER NOT NULL,
    `numero` INTEGER NOT NULL,
    `estado` BOOLEAN NOT NULL,
    `id_empleado` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Reservas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `id_cliente` INTEGER NOT NULL,
    `id_mesa` INTEGER NOT NULL,
    `fecha` DATETIME(3) NOT NULL,
    `numero_personas` INTEGER NOT NULL,
    `confirmacion` BOOLEAN NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Clientes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `id_reserva` INTEGER NOT NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `telefono` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Permisos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Mesas` ADD CONSTRAINT `Mesas_id_empleado_fkey` FOREIGN KEY (`id_empleado`) REFERENCES `Empleados`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
