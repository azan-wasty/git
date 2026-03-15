const {sql, config} = require("./db");
const express = require("express");
const router = express.Router();

router.get("/sci-fi", async (req, res) => {
    const pool = await sql.connect(config);
    const after = req.query.after;
    let result;
    if (!after) {
        result = await pool.request()
        .input("Genre", sql.VarChar, "Sci-Fi")
        .query("SELECT * FROM Movies WHERE Genre = @Genre ORDER BY Rating");

    } else {
        result = await pool.request()
        .input("Genre", sql.VarChar, "Sci-Fi")
        .input("ReleaseYear", sql.Int, after)
        .query("SELECT * FROM Movies WHERE Genre = @Genre AND ReleaseYear > @ReleaseYear ORDER BY Rating");
    }
    res.json(result.recordset);
});

module.exports = router;