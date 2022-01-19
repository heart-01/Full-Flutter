var express = require('express');
var router = express.Router();
const fileUpload = require('express-fileupload');

var book_phone = require("./book_phone");
router.use(fileUpload());

router.get('/get_All', book_phone.All);
router.post('/add_book', book_phone.Add_book);
router.put('/update_book/:id', book_phone.Update_book);
router.delete('/delete_book/:id', book_phone.bookDelete);
router.get('/Search_book/:keyword', book_phone.bookSearch);
router.delete('/remove/photos/:id', book_phone.deletePhoto);

router.post('/upload', function(req, res) {
    if (!req.files || Object.keys(req.files).length === 0) {
        return res.status(400).send('No files were uploaded.');
    }

    // The name of the input field (i.e. "sampleFile") is used to retrieve the uploaded file
    let sampleFile = req.files.sampleFile;
    //console.log(sampleFile)

    // Use the mv() method to place the file somewhere on your server
    sampleFile.mv('./public/pic/' + sampleFile.name, function(err) {
        if (err)
            return res.status(500).send(err.message);
        res.send({ status: 'File uploaded!', name: sampleFile.name });
    });
});

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: 'Express' });
});

module.exports = router;