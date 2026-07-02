const { databaseConnection } = require('./database/connection');

databaseConnection();

const express = require('express');
const app = express();
const PORT = process.env.PORT || 3031;

const productRoute = require('./routes/productsRoute');

app.use(express.json());

app.use('/products', productRoute);

app.listen(PORT, () => {
    console.log(`Server is running on port http://localhost:${PORT}`);
});