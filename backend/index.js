const express = require('express')
var mysql = require('mysql')
const app = express()
const port = 3000


const bodyParser  = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));
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
        connection.query('SELECT * FROM flutter_login WHERE UserName = ? AND Password = ?', [username, password], function (error, results, fields) {
            if (results.length > 0) {
                response.send('success');
            } else {
                response.send("Not successful");
            }
            response.end();
        });
    } else {
        response.send("Not valid");
        response.end();
    }
});


app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})

