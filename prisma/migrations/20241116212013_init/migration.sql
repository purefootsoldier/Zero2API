/*
  Warnings:

  - The primary key for the `metodo_pago` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id_metodo_pago` on the `metodo_pago` table. All the data in the column will be lost.
  - You are about to drop the column `tipo` on the `metodo_pago` table. All the data in the column will be lost.
  - You are about to alter the column `fecha_hora` on the `reservas` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - Added the required column `id` to the `Metodo_Pago` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ultima_actualizacion` to the `Metodo_Pago` table without a default value. This is not possible if the table is not empty.
  - Made the column `nombre` on table `metodo_pago` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `pago` DROP FOREIGN KEY `Pago_id_metodo_pago_fkey`;

-- DropForeignKey
ALTER TABLE `ticket` DROP FOREIGN KEY `Ticket_id_metodo_pago_fkey`;

-- AlterTable
ALTER TABLE `metodo_pago` DROP PRIMARY KEY,
    DROP COLUMN `id_metodo_pago`,
    DROP COLUMN `tipo`,
    ADD COLUMN `activo` BOOLEAN NOT NULL DEFAULT true,
    ADD COLUMN `cargo_adicional` DOUBLE NULL DEFAULT 0.0,
    ADD COLUMN `descripcion` VARCHAR(191) NULL,
    ADD COLUMN `fecha_creacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `ultima_actualizacion` DATETIME(3) NOT NULL,
    MODIFY `nombre` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `reservas` MODIFY `fecha_hora` TIMESTAMP NOT NULL;

-- AddForeignKey
ALTER TABLE `Ticket` ADD CONSTRAINT `Ticket_id_metodo_pago_fkey` FOREIGN KEY (`id_metodo_pago`) REFERENCES `Metodo_Pago`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pago` ADD CONSTRAINT `Pago_id_metodo_pago_fkey` FOREIGN KEY (`id_metodo_pago`) REFERENCES `Metodo_Pago`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
