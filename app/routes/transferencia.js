"use strict";

var express = require("express");
var transferenciaController = require("../controllers/transferenciaController");

var router = express.Router();

router.post("/", transferenciaController.add);
router.get("/", transferenciaController.getAll);

module.exports = router;