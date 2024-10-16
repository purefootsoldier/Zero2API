/*
  Warnings:

  - You are about to alter the column `age` on the `user` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.

*/
-- AlterTable
ALTER TABLE `user` MODIFY `age` INTEGER NOT NULL;
