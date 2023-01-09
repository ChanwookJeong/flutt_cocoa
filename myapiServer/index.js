//nodejs 설치

var express = require("express");
var app = express();
app.get("/",(req,res) => {
    var userHeader = req.headers["user-header"];
    console.log(userHeader);
    if(userHeader === undefined){
        return res.json({
        "key":"ERR"
    });
    }
    if(userHeader === "1234"){
        return res.json({
            "key":"value"
        });
    }
    return res.json({
        "key":"check header"
    });
    
    // res.send(
    //     "<p>안녕하세요</p>"
    // );
});

app.listen(3000,(err) => {
    console.log(3000);
});