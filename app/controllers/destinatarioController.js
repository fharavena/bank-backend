"use strict";
var pool = require('../config');

var controller = {
    add: (req, res) => {
        pool.getConnection((err, connection) => {
            if (err) {
                res.status(301).send("error de conexion base de datos");
                return 0;
            }
            const params = req.body;

            connection.query('INSERT into destinatario SET ?', params, (err, rows) => {
                connection.release()

                if (err) {
                    if (err.code == 'ER_DUP_ENTRY') {
                        res.status(300).send({
                            "status": "error",
                            "code": 300,
                            "msg": "Destinatario ya ha sido agregado anteriormente"
                        })
                    } else {
                        res.status(300).send({
                            "status": "error",
                            "code": 300,
                            "msg": "Error en consulta SQL"
                        })
                    }
                } else {
                    res.status(200).send({
                        "status": "success",
                        "code": 200,
                        "msg": "Destinatario agregado satisfactoriamente"
                    })
                }
            })
        })
    },
    // get User by Name
    getByName: (req, res) => {
        pool.getConnection((err, connection) => {
            var sql = 'SELECT '
            +' d.id,d.nombre,d.rut,d.banco_id,d.correo, t.valor as tipo_cuenta'
            +' from destinatario as d'
            +' join tipo_cuenta as t on t.id = d.tipo_cuentaid '
            +' WHERE nombre like ? '
            +' LIMIT 5';
            connection.query(sql, ['%' + req.params.name + '%'], (err, rows) => {
                connection.release()
                if (!err) {
                    if (!rows.length) {
                        res.status(204).send();
                    } else {
                        res.status(200).send({
                            "status": "success",
                            "code": 200,
                            "data": rows
                          })
                    }
                } else {
                    console.log(err);
                }
            })
        })
    },
}

module.exports = controller;