const { Op } = require("sequelize");
const book_phone = require("./model/model_book_phone");

exports.All = async (req, res, next) => {
    res.send(await book_phone.findAll());
};

exports.Add_book = async (req, res, next) => {
    res.send(await book_phone.create(req.body));
};

exports.Update_book = async (req, res, next) => {
    res.send(await book_phone.update(req.body, { where: { id: req.params.id } }));
};

exports.bookDelete = async (req, res, next) => {
    res.json(
        await book_phone.destroy({
            where: {
                id: req.params.id,
            },
        })
    );
};

exports.bookSearch = async (req, res, next) => {
    res.send(
        await book_phone.findAll({
            where: {
                [Op.or]: [{
                    nickname: {
                        [Op.like]: "%" + req.params.keyword + "%",
                    },
                },
                {
                    tel: {
                        [Op.like]: "%" + req.params.keyword + "%",
                    },
                },
                ],
            },
        })
        // await sequelize.query("SELECT * FORM phons")
    );
};

exports.deletePhoto = async (req, res, next) => {
    require("fs").rm('./public/pic/'+req.params.id , function () {
        res.send({
            status: "200",
            responseType: "string",
            response: "success"
        });
    });
};