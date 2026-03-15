const {sql, config} = require("./db");
const express = require("express");
const router = express.Router();

router.get("/race", async (req, res) => {
    const pool = await sql.connect(config);
    const location = req.query.location;
    let result;
    if (!location) {
        result = await pool.request()
        .query("SELECT * FROM Race ORDER BY Race_Date");

    } else {
        result = await pool.request()
        .input("location", sql.VarChar, location)
        .query("SELECT * FROM Race WHERE Location = @location ORDER BY Race_Date");
    }
    res.json(result.recordset);
});

module.exports = router;