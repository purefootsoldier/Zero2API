-- AddForeignKey
ALTER TABLE `Pedidos` ADD CONSTRAINT `Pedidos_id_mesa_fkey` FOREIGN KEY (`id_mesa`) REFERENCES `Mesas`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pedidos` ADD CONSTRAINT `Pedidos_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `Clientes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pedidos` ADD CONSTRAINT `Pedidos_id_empleado_fkey` FOREIGN KEY (`id_empleado`) REFERENCES `Empleados`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
