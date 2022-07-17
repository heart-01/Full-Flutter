const {
    Sequelize
} = require('sequelize');

const sequelize = new Sequelize('db_book_phone', 'root', '', {
    host: 'localhost',
    dialect: 'mysql'
});

module.exports = sequelize;