import { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default async function name(
    req: NextApiRequest,
    res: NextApiResponse
) {
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3001');
    res.setHeader('Access-Control-Allow-Methods', 'GET,POST,OPTIONS,DELETE');
    if (req.method === 'GET'){
        try{
            const ordenes = await prisma.ordenes_cocina.findMany();
            res.status(200).json(ordenes)
        }catch(error){
            res.status(500).json({message:'Error al obtener los ordenes', error});
        }
    } else if (req.method === 'POST'){
        const { id_pedidos, id_menu, cantidad, estado } = req.body;
        if (!id_pedidos || !id_menu || !cantidad || !estado){
            return res.status(400).json({message: 'Faltan campos requeridos'})
        }

        try{
            const newOrden = await prisma.ordenes_cocina.create({
                data: {
                    id_pedidos: parseInt(id_pedidos),
                    id_menu: parseInt(id_menu),
                    cantidad: parseInt(cantidad),
                    estado: estado
                },
            });
            res.status(201).json(newOrden);
        }catch(error){
            res.status(500).json({message: 'Error al actualizar el ordenes', error});
        }
    }else if(req.method === 'PUT'){
        const { id, id_pedidos, id_menu, cantidad, estado } = req.body;
        if (!id_pedidos || !id_menu || !cantidad || !estado){
            return res.status(400).json({message: 'Faltan campos requeridos'})
        }

        try{
            const updateOrden = await prisma.ordenes_cocina.update({
                where: {id_ordenes_cocina: parseInt(id)},
                data: {
                    id_pedidos: parseInt(id_pedidos),
                    id_menu: parseInt(id_menu),
                    cantidad: parseInt(cantidad),
                    estado: estado
                },
            });
            res.status(201).json(updateOrden);
        }catch(error){
            res.status(500).json({message: 'Error al crear el ordenes', error});
        }

    } else if(req.method === 'DELETE'){
        const {id} = req.query;

        if (!id){
            return res.status(400).json({message: 'El id del ordenes es requerido'});
        }

        try{
            //esto me va a servir para eliminar el ordenes por ID
            const deleteOrden = await prisma.ordenes_cocina.delete({
                where: {id_ordenes_cocina: parseInt(id as string)},
            });
            res.status(200).json(deleteOrden);
        }catch (error){
            res.status(500).json({message: 'Error al eliminar el ordenes', error});
        }
    } else {
        res.status(405).json({message: 'Método no permitido'});
    }
    
}