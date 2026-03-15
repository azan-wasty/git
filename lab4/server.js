require('dotenv').config()

const express = require("express");
const { connectDB } = require("./db");
const routes = require("./routes");

const app = express();

app.use(express.json());

connectDB();

app.use("/", routes);

app.listen(5000, () => {
    console.log("Server running on port 5000");
});