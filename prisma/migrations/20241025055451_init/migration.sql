/*
  Warnings:

  - Added the required column `id_categoria` to the `Menu` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable


+ ALTER TABLE `Menu` ADD COLUMN `id_categoria` INTEGER NOT NULL DEFAULT 1;
+ -- Then remove the default after data migration

-- CreateTable
CREATE TABLE `Categorias` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Menu` ADD CONSTRAINT `Menu_id_categoria_fkey` FOREIGN KEY (`id_categoria`) REFERENCES `Categoria`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
