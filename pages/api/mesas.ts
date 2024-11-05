import { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default async function Mesas(
    req: NextApiRequest,
    res: NextApiResponse
) {
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3001');
    res.setHeader('Access-Control-Allow-Methods', 'GET,POST,OPTIONS,DELETE');
    if (req.method === 'GET'){
        try{
            const Mesas = await prisma.mesas.findMany();
            res.status(200).json(Mesas)
        }catch(error){
            res.status(500).json({message:'Error al obtener las mesas', error});
        }
    } else if (req.method === 'POST'){
        
        const { numero, is_temp  } = req.body
        //aqui poner un if is temp entonces que se ejecute esto
        try{
            const mesa = await prisma.mesa.create({
                data:{
                    numero_mesa: numero,
                    estado_mesa: 2
                },
            })

            //programamos la mesa para que se elimine automaticamente en cierto tiempo
            setTimeout(async () => {
                await prisma.mesa.delete({
                    where: { id: mesa.id },
                })
                console.log('mesa ${mesa.id} eliminada automaticamente')
            }, 1000 * 60 * 60) //eliminará la mesa en una hora
        } catch{

        }

        //aqui el else y se ejecuta lo de abajo

        const { capacidad_mesa, numero_mesa, estado_mesa, id_empleado } = req.body;
        if (!capacidad_mesa || !numero_mesa || !estado_mesa || !id_empleado){
            return res.status(400).json({message: 'Faltan campos requeridos'})
        }

        try{
            const newMesa = await prisma.mesas.create({
                data: {
                    capacidad_mesa: parseInt(capacidad_mesa),
                    numero_mesa: parseInt(numero_mesa),
                    estado_mesa: parseInt(estado_mesa),
                    id_empleado: parseInt(id_empleado)
                },
            });
            res.status(201).json(newMesa);
        }catch(error){
            res.status(500).json({message: 'Error al crear la mesa', error});
        }
    }else if(req.method === 'PUT'){
        const { id_mesa, capacidad_mesa, numero_mesa, estado_mesa, id_empleado } = req.body;
        if (!capacidad_mesa || !numero_mesa || !estado_mesa || !id_empleado){
            return res.status(400).json({message: 'Faltan campos requeridos'})
        }

        try{
            
            const updateMesa = await prisma.mesas.update({
                where: {id_mesa: parseInt(id_mesa)},
                data: {
                    capacidad_mesa: parseInt(capacidad_mesa),
                    numero_mesa: parseInt(numero_mesa),
                    estado_mesa: parseInt(estado_mesa),
                    id_empleado: parseInt(id_empleado)
                },
            });
            res.status(201).json(updateMesa);
        }catch(error){
            res.status(500).json({message: 'Error al actualizar la mesa', error});
        }

    } else if(req.method === 'DELETE'){
        const {id_mesa} = req.query;

        if (!id_mesa){
            return res.status(400).json({message: 'El id del producto es requerido'});
        }

        try{
            //esto me va a servir para eliminar el producto por ID
            const deleteMesa = await prisma.mesas.delete({
                where: {id_mesa: parseInt(id_mesa as string)},
            });
            res.status(200).json(deleteMesa);
        }catch (error){
            res.status(500).json({message: 'Error al eliminar la mesa', error});
        }
    } else {
        res.status(405).json({message: 'Método no permitido'});
    }
    
}