const sql = require("mssql");

const config = {
    user: "sa",
    password: "12345678",
    server: "DESKTOP-I4HH826",
    database: "employees",
    options: {
        trustServerCertificate: true
    }
};

async function connectDB() {
    try {
        await sql.connect(config);
        console.log("Connected to SQL Server");
    }
    catch (err) {
        console.log(err);
    }
}

module.exports = { sql, config, connectDB };