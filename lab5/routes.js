const {sql, config} = require("./db");
const express = require("express");
const router = express.Router();

router.get("/creatures", async (req, res) => {
    const pool = await sql.connect(config);
    const result = await pool.request()
        .query("SELECT * FROM Creature");
    res.json(result.recordset);
});

router.get("/ingredients", async (req, res) => {
    const pool = await sql.connect(config);
    const result = await pool.request()
        .query("SELECT * FROM Ingredient");
    res.json(result.recordset);
});

router.get("/powers", async (req, res) => {
    const pool = await sql.connect(config);
    const result = await pool.request()
        .query("SELECT * FROM Power");
    res.json(result.recordset);
});

router.get("/familyrelations", async (req, res) => {
    const pool = await sql.connect(config);
    const result = await pool.request()
    .query("SELECT * FROM FamilyRelation");
    res.json(result.recordset);
});

router.get("/fights", async (req, res) => {
    const pool = await sql.connect(config);
    const result = await pool.request()
    .query("SELECT * FROM Fight");
    res.json(result.recordset);
});

module.exports = router;