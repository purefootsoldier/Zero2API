/*
  Warnings:

  - Added the required column `stock` to the `Producto` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `producto` ADD COLUMN `stock` INTEGER NOT NULL;
