/*
  Warnings:

  - You are about to drop the `categoria` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `menu` DROP FOREIGN KEY `Menu_id_categoria_fkey`;

-- DropTable
DROP TABLE `categoria`;

-- CreateTable
CREATE TABLE `Categorias` (
     `id` INTEGER NOT NULL AUTO_INCREMENT,
     `nombre` VARCHAR(191) NOT NULL,
+    UNIQUE INDEX `Categorias_nombre_key` (`nombre`),
+    INDEX `Categorias_nombre_idx` (`nombre`)
     PRIMARY KEY (`id`)
 ) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Menu` ADD CONSTRAINT `Menu_id_categoria_fkey` FOREIGN KEY (`id_categoria`) REFERENCES `Categorias`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
