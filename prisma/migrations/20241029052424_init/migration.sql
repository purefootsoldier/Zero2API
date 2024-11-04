-- CreateTable
CREATE TABLE `Mesa` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `capacidad` INTEGER NOT NULL,
    `numero` INTEGER NOT NULL,
    `estado` BOOLEAN NOT NULL,
    `id_empleado` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Empleados` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `puesto` VARCHAR(191) NOT NULL,
    `salario` DOUBLE NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Mesa` ADD CONSTRAINT `Mesa_id_empleado_fkey` FOREIGN KEY (`id_empleado`) REFERENCES `Empleados`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
