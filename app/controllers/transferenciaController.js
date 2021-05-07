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

            connection.query('INSERT into transferencia SET ?', params, (err, rows) => {
                connection.release()

                if (err) {
                    res.status(300).send({
                        "status": "error",
                        "code": 300,
                        "msg": "Error en consulta SQL"
                    })
                } else {
                    res.status(200).send({
                        "status": "success",
                        "code": 200,
                        "msg": "Transferencia agregada satisfactoriamente"
                    })
                }
            })
        })
    },
    getAll: (req, res) => {
        pool.getConnection((err, connection) => {
            var sql = 'SELECT '
            +' d.nombre,d.rut,d.banco_id,tc.valor,t.monto'
            +' from transferencia as t'
            +' join destinatario as d on t.destinatarioid = d.id '
            +' join tipo_cuenta as tc on tc.id = d.tipo_cuentaid ';
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