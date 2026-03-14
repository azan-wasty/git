const express = require("express");
const router = express.Router();
const { sql, config } = require("./db");

router.post("/create_customer", async (req, res) => {

    const { customer_id, cust_name, city, grade, salesman_id } = req.body;

    try {

        const pool = await sql.connect(config);

        await pool.request()
            .input("customer_id", sql.Int, customer_id)
            .input("cust_name", sql.VarChar, cust_name)
            .input("city", sql.VarChar, city)
            .input("grade", sql.Int, grade)
            .input("salesman_id", sql.Int, salesman_id)
            .query(`
            INSERT INTO customers
            VALUES (@customer_id,@cust_name,@city,@grade,@salesman_id)
        `);

        res.send("Customer inserted");

    }
    catch (err) {
        res.send(err.message);
    }

});

module.exports = router;