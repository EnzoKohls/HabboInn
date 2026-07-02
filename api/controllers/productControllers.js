const { pool } = require('../database/connection');

async function getItems(req, res) {
    try {
        const [products] = await pool.query('SELECT * FROM quartos;');
        return res.status(200).json(products);
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            error: "Error getting products"
        });
    }
};

async function getItemById(req, res) {
    try {
        const [products] = await pool.query('SELECT * FROM quartos WHERE id = ?', [req.params.id]);
        return res.status(200).json(products);
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            error: "Error getting product"
        });
    }
};

async function createItem(req, res) {
    try {
        const [products] = await pool.query('INSERT INTO quartos (nome_quarto, tipo, preco_cambios, avaliacao) VALUES (?, ?, ?, ?)',
            [req.body.name_quarto, req.body.tipo, req.body.preco_cambios, req.body.avaliacao]);
        return res.status(201).json({
            massage: "Product created successfully",
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            error: "Error creating product"
        });
    }
};

async function updateItem(req, res) {
    try {
        const [products] = await pool.query('UPDATE quartos SET nome_quarto = ?, tipo = ?, preco_cambios = ?, avaliacao = ? WHERE id = ?',
            [req.body.name_quarto, req.body.tipo, req.body.preco_cambios, req.body.avaliacao, req.params.id]);
        return res.status(200).json({
            massage: "Product updated successfully",
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            error: "Error updating product"
        });
    }
};

async function deleteItem(req, res) {
    try {
        const [products] = await pool.query('DELETE FROM quartos WHERE id = ?', [req.params.id]);
        return res.status(200).json({
            massage: "Product deleted successfully",
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            error: "Error deleting product"
        });
    }
};

module.exports = {
    getItems,
    getItemById,
    createItem,
    updateItem,
    deleteItem
};

