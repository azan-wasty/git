const cors = require('cors');
const express = require('express');

const app = express();
const PORT = 6767;

app.use(cors());

app.get('/', (req, res) => {

    const items = [
        { id: 1, name: 'Blood Meridian' },
        { id: 2, name: 'Neo Lancer' },
        { id: 3, name: 'Moth Flame' }
    ];

    res.json(items);
});

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});