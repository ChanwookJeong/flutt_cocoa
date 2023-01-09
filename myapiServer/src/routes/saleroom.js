const {Router} = require('express');
const router =Router();

const mysqlConnection = require('../database/database');

router.get('/', (req,res) =>{
    res.status(200).json('Server on port 3000 and database is connected');
});

router.get('/:saleroom',(req,res)=>{
    mysqlConnection.query('select * from saleroom;',(error,rows,fields) =>{
        if(!error){
            res.json(rows);
        }else{
            console.log(error);
        }
    });
});

router.get('/:saleroom/:id',(req,res)=>{
    const {id} = req.params;
    mysqlConnection.query('select * from saleroom where room_root_id = ?;',[id],(error,rows,fields)=>{
        if(!error){
            res.json(rows);
        }else{
            console.log(error);
        }
    });
});

router.post('/:users',(req,res)=>{
    const{id,username} = req.body;
    console.log(req.body);
    mysqlConnection.query('insert into user(id,username) values(?,?);',
    [id,username],(error,rows,fields)=>{
        if(!error){
            res.json({Status:'user saved'});
        }else{
            console.log(error);
        }
    });
});

router.put('/:users/:id',(req,res)=>{
    const{id,username} = req.body;
    console.log(req.body);
    mysqlConnection.query('update user set username = ? where id = ?;',
    [username,id],(error,rows,fields)=>{
        if(!error){
            res.json({Status:'user updated'});
        }else{
            console.log(error);
        }
    });
});

router.delete('/:users/:id',(req,res)=>{
    const{id}= req.params;
    mysqlConnection.query('delete from user where id = ?;',[id],(error,rows,fields) =>{
        if(!error){
            res.json({Status:'user deleted'});
        }else{
          res.json({Status:error});
        }
    });
});

module.exports =router;