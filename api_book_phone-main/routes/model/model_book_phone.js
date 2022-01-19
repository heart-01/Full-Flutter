const sequelize = require("../config");
const {
    DataTypes
} = require('sequelize');

const Book_phone = sequelize.define("phone", {
    nickname: {
        type: DataTypes.STRING(255)
    },
    name: {
        type: DataTypes.STRING(255),
    },
    tel: {
        type: DataTypes.STRING(255),
    },
    avatar: {
        type: DataTypes.STRING(255),
    },
    id_line: {
        type: DataTypes.STRING,
    }
});

// Book_phone.sync({
//     alter: true,
// });

module.exports = Book_phone;