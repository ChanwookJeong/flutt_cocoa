const express = require('express');
const app = express();

//settings
app.set('port',process.env.PORT || 3000);

//Middlewares
app.use(express.json());

//Routes
app.use(require('./routes/saleroom'));

//Starting the server
app.listen(app.get('port'),()=>{
    console.log('Server on port',app.get('port'));
});
