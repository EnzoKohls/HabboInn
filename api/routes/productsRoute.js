const express = require('express');
const router = express.Router();

const productController = require('../controllers/productControllers');

router.get('/', productController.getItems);

router.get('/:id', productController.getItemById);

router.post('/', productController.createItem);

router.put('/:id', productController.updateItem);

router.delete('/:id', productController.deleteItem);

module.exports = router;