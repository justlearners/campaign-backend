const { v1: uuidv1 } = require('uuid');

var mysql = require('mysql');

var con = mysql.createPool({
  connectionLimit : 10,
  host: "localhost",
  user: "root",
  password: "password",
  database: "campaign"
});

module.exports = { 

saveConfig : function(config){
    return new Promise(function (resolve, reject) {
            console.log("Connected!");
            var sql = "INSERT INTO app_config (config_categ,config_key,config_value,is_active,created_by) VALUES ?";
            var values = [
                [config.categ,config.key,config.val,'y',config.createdBy]
            ];
            con.query(sql, [values], function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve("success");
                    console.log("Number of records inserted: " + result.affectedRows);
                }                
            });
        });
    },

 saveGroup : function(group){
    return new Promise(function (resolve, reject) {
            var gid=uuidv1();
            console.log('gid--',gid);
            console.log("Connected!");
            var sql = "INSERT INTO cgroup(gname,is_active,created_by) VALUES ?";
            var values = [
                [group.name,group.active,'admin']
            ];
            con.query(sql, [values], function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve("success");
                    console.log("Number of records inserted: " + result.affectedRows);
                }                
            });
      });
 },

 saveType : function(campaignTyp){
    return new Promise(function (resolve, reject) {
            var tid=uuidv1();
            console.log('tid--',tid);
            console.log("Connected!");
            var sql = "INSERT INTO campaign_type(tname,created_by) VALUES ?";
            var values = [
                [campaignTyp.name,'admin']
            ];
            con.query(sql, [values], function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve("success");
                    console.log("Number of records inserted: " + result.affectedRows);
                }                
            });
      });
 },
 saveCampaign : function(campaign){
    return new Promise(function (resolve, reject) {
            var cid=uuidv1();
            console.log('cid--',cid);
            console.log("Connected!");
            var sql = "INSERT INTO campaign (tid,name,shortDesc,is_active,created_by) VALUES ?";
            var values = [
                [campaign.typeId,campaign.name,campaign.shortDesc,'y',campaign.createdBy]
            ];
            con.query(sql, [values], function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve("success");
                    console.log("Number of records inserted: " + result.affectedRows);
                }                
            });
      });
 },

 saveCampaignGroup : function(cmpgngrp){
    return new Promise(function (resolve, reject) {
            var cgid=uuidv1();
            console.log('cgid--',cgid);
            console.log("Connected!");
            var sql = "INSERT INTO campaign_group (cid,gid) VALUES ?";
            var values = [
                [cmpgngrp.cid,cmpgngrp.gid]
            ];
            con.query(sql, [values], function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve("success");
                    console.log("Number of records inserted: " + result.affectedRows);
                }                
            });
      });
 },

 saveUser : function(user){
    return new Promise(function (resolve, reject) {
            var uid=uuidv1();
            console.log('uid--',uid);
            console.log("Connected!");
            var sql = "INSERT INTO user (uname,emailid,contact,address,city,country,created_by) VALUES ?";
            var values = [
                [user.uname,user.emailid,user.contact,user.address,user.city,user.country,user.createdBy]
            ];
            con.query(sql, [values], function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve(result.insertId);
                    console.log("Records inserted: " + result.affectedRows);
                }                
            });
      });
 },

 saveBooking : function(booking){
    return new Promise(function (resolve, reject) {            
            var uid=checkUsr(booking.usr).then(function(uid){ 
                var uNameFound=booking.usr.uname;
                if(!uid) {
                    if(!uNameFound) {
                        reject({ status: "error", message: "User not found.Please choose 'New User' option."});
                    } else {
                      con.getConnection(function(err, connection) {
                        connection.beginTransaction(function(err) {
                            if (err) {
                                reject({ status: "error", message: err.message});
                            } 
                            saveUsr(booking.usr,connection).then(function(uid) {
                                sveBooking(booking,uid,connection).
                                then(function(data){
                                    connection.commit(function(err) {
                                        if (err) { 
                                            con.rollback(function() {
                                            throw err;
                                          });
                                        }
                                        console.log('Transaction Complete.');
                                        connection.end();
                                      });
                                    resolve(data);
                                })
                                .catch(function (err) {
                                    reject(err);
                                })
                            })
                            .catch(function (err) {
                                console.log(err);
                                reject({ status: "error", message: err.message});
                            }); 
                            
                        });
                     });
                    }
                } else {
                    if(!uNameFound) {
                        sveBooking(booking,uid,con).
                            then(function(data){
                                resolve(data);
                            })
                            .catch(function (err) {
                                reject(err);
                            })                        
                    } else {
                        reject({ status: "error", message: "User already existing with this contact.Please change contact."});
                    }
                }      
              })
            .catch(function (err) {
                console.log(err);
                reject({ status: "error", message: err.message});
            });           
      });
 },

 getSlotList : function(){
    return new Promise(function (resolve, reject) {
            console.log("Connected!");
            var sql = "SELECT * FROM app_config where config_categ ='slot'";            
            con.query(sql,function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve(result);
                    console.log("Data: " + result);
                }                
            });
      });
 },

 getStateList : function(cntryId){
    return new Promise(function (resolve, reject) {
            console.log("Connected!");
            var sql = "SELECT * FROM state_list where country_id=?";  
            var values = [cntryId];   
            con.query(sql,[values],function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve(result);
                    console.log("Data: " + result);
                }                
            });
      });
 },


 getGroupList : function(){
    return new Promise(function (resolve, reject) {
            console.log("Connected!");
            var sql = "SELECT * FROM cgroup c where is_active ='y'";            
            con.query(sql,function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve(result);
                    console.log("Data: " + result);
                }                
            });
      });
 },

 getCampaignList : function(){
    return new Promise(function (resolve, reject) {
            console.log("Connected!");
            var sql = "SELECT * FROM campaign c where is_active ='y'";            
            con.query(sql,function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve(result);
                    console.log("Data: " + result);
                }                
            });
      });
 },

 getCampaignListByGrp : function(grpid){
    return new Promise(function (resolve, reject) {
            console.log("Connected!");
            var sql = "SELECT c.* FROM campaign c,campaign_group cg where c.cid=cg.cid and cg.gid='?' and c.is_active ='y'";            
            var values = [grpid];     
            con.query(sql,function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve(result);
                    console.log("Data: " + result);
                }                
            });
      });
 },
 getCampaign : function(cid){
    return new Promise(function (resolve, reject) {
            console.log("Connected!",cid);
            var sql = "SELECT c.*,"+
            "(select uname from user u where u.uid=c.contact_person_id1) contact1_name, "+
            "(select contact from user u where u.uid=c.contact_person_id1) contact1_contact, "+
            "(select uname from user u where u.uid=c.contact_person_id1) contact2_name, "+
            "(select contact from user u where u.uid=c.contact_person_id1) contact2_contact "+
            " FROM campaign c where is_active ='y'";   
            var values = [cid];          
            con.query(sql,[values],function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    console.log("Data rows: " + result.length);
                    if(result.length>0) {
                        resolve(result);
                    }else {
                        reject({ status: "error", message: "No Record Found"});
                    }
                }                
            });
      });
 },
 getBookings : function(cid){
    return new Promise(function (resolve, reject) {
            console.log("Connected!",cid);
            var sql = "SELECT * FROM booking where cid =?";  
            var values = [cid];          
            con.query(sql,[values],function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve(result);
                    console.log("Data: " + result);
                }                
            });
      });
 },
 getBookingsAndUsers : function(cid){
    return new Promise(function (resolve, reject) {
            console.log("Connected!",cid);
            var sql = "SELECT * FROM booking b,user u where b.cid =? and b.uid=u.uid";  
            var values = [cid];          
            con.query(sql,[values],function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve(result);
                    console.log("Data: " + result);
                }                
            });
      });
 },
 getBookingsFullDetails : function(cid){
    return new Promise(function (resolve, reject) {
            console.log("Connected!",cid);
            var sql = "SELECT b.*,u.*,st.state_name,config.id,config.config_key,config.config_value FROM booking b,user u,"+
                     " state_list st,app_config config where b.cid =? "+
                     " and b.uid=u.uid and b.slot=config.id and u.state=st.id order by b.booking_date,config.config_key";  
            var values = [cid];          
            con.query(sql,[values],function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    resolve(result);
                    console.log("Data: " + result);
                }                
            });
      });
 }
}

function checkUsr(user){
    return new Promise(function (resolve, reject) {
            var uid=uuidv1();
            console.log('uid--',uid);
            console.log("Connected!");
            var selectSql = "SELECT uid FROM user u where u.contact=?"; 
            var value = [user.contact];
            con.query(selectSql,[value],function (err, result) {
                if (err) {
                    reject({ status: "error", message: err.message});
                } else {
                    if(result.length>0){
                        var data=(result[0]);
                        console.log("User Exists: " + data);
                        console.log("uid: " + data.uid);
                        resolve(data.uid);
                    } else {
                        resolve(''); 
                    }                    
                }                
            });
      });
 }

 function saveUsr(user,connection){
    return new Promise(function (resolve, reject) {
            var uid=uuidv1();
            console.log('uid--',uid);
            console.log("Connected!");
            var sql = "INSERT INTO user (uname,emailid,contact,address,city,state,country,created_by) VALUES ?";
            var values = [
                [user.uname,user.email,user.contact,user.address,user.city,user.state,user.country,user.createdBy]
            ];
            connection.query(sql, [values], function (err, result) {
                if (err) {
                    connection.rollback(function() {
                        reject({ status: "error", message: err.message});
                      });
                } else {
                    resolve(result.insertId);
                    console.log("Records inserted: " + result.affectedRows);
                }                
            });
      });
 }

 function sveBooking(booking,uid,connection){
    return new Promise(function (resolve, reject) {
    var sql = "INSERT INTO booking (cid,uid,booking_date,slot,created_by) VALUES ?";
    var values = [
        [booking.cid,uid,booking.booking_date,booking.slot,booking.createdBy]
    ];
    connection.query(sql, [values], function (err, result) {
        if (err) {
            connection.rollback(function() {
                reject({ status: "error", message: err.message});
              });
        } else {
            resolve({ status: "success", message: "success"});
            console.log("Number of records inserted: " + result.affectedRows);
        }                
    });
 });
}

