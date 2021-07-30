const express = require('express')
const bodyParser = require('body-parser')
var mysql = require('mysql')
const app = express()
const port = 3000

//Here we are configuring express to use body-parser as middle-ware.
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());


var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'detail'
})

connection.connect()

app.post('/login', (request, response) => {
    let username = request.body.email;
    let password = request.body.password;
    console.log(username);
    if (username && password) {
        connection.query('SELECT * FROM flutter_login WHERE UserName = ? AND password = ?', [username, password], function (error, results, fields) {
            if (results.length > 0) {
                response.json({ 'msg': 'Sucessfull' });
            } else {
                response.json({ 'msg': 'Incorrect' });
            }
            response.end();
        });
    } else {
        response.json({ 'msg': 'Not valid' });
        response.end();
    }
});


app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})

