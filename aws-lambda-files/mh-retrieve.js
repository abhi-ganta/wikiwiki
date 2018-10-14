var admin = require("firebase-admin");
var http = require("http");
var serviceAccount = require("./mh-wiki-wiki-firebase-adminsdk-1pwou-e348577509.json");
var querystring = require('querystring');

const THRESHHOLD = 0.5;

const REG_IP = "35.227.40.233";
const POWER_IP = "35.237.248.197";

exports.handler = (event, context, callback) => {
    // TODO implement
    
    context.callbackWaitsForEmptyEventLoop = false;  //<---Important
    
    var firebaseInstance = configFirebase();

    var params = event['params']['querystring'];
    var uid = decodeURI(params['uid']);

    var db = firebaseInstance.database();
    
    var active_poll_arr = [];
    
    var pollDict = {};
    
    var ref = db.ref("polls");
    ref.once("value").then(function(snapshot) {
        var snapshotVal = snapshot.val();
        for (var key in snapshotVal) {
            if(snapshotVal.hasOwnProperty(key)){
                var pollObj = snapshotVal[key];
                if (pollObj["active"] == 1 && pollObj["uid"] != uid) {
                    var ss = pollObj["data"];
                    ss["poll_id"] = key;
                    active_poll_arr.push(ss);
                    pollDict[key] = pollObj;
                }
            }
        }
    });
    
    var voteObjArr = [];
    var userInfoRef = db.ref("userInfo").child(uid).child("votes");
    userInfoRef.once("value").then(function(snapshot) {
        var snapshotVal = snapshot.val();
        for (var key in snapshotVal) {
            if(snapshotVal.hasOwnProperty(key)) {
                var voteObj = snapshotVal[key]
                voteObjArr.push(voteObj);
            }
        }
        
        var jsonStringify = JSON.stringify({"old": voteObjArr, "new": active_poll_arr});
        
        var postOptions = {
            hostname: REG_IP,
            port: "8000",
            path: '/optimizeFeed/',
            method: 'POST',
            headers: {
                'Content-Length': Buffer.byteLength(jsonStringify),
                'Content-Type': 'application/json'
            }
        };
        
        var postReq = http.request(postOptions, function(res) {
            
            res.setEncoding('utf8');
            
            var all_chunks = "";
            
            res.on('data', function (chunk) {
                all_chunks += chunk;
            });
            
            res.on('end', function(){
                var dt = JSON.parse(all_chunks)["predictions"]
                
                var finalCardArr = [];
                
                for (var i = 0; i < dt.length; i++) {
                    var obj = dt[i];
                    
                    var thisPollId = obj["poll_id"];
                    var probability = obj["probability"];
                    
                    if (probability > THRESHHOLD) {
                        var thisOd = pollDict[thisPollId];
                        thisOd["prob"] = probability
                        thisOd["poll_id"] = thisPollId;
                        finalCardArr.push(thisOd);
                    }
                }
                
                callback(null, {"finalCardArr": finalCardArr});
            });
        });
        
        postReq.on('error', function(e) {
            callback('problem with request: ' + e.message);
        });
        
        postReq.write(jsonStringify);
        postReq.end();
    });
};


function configFirebase(){
    var adminConfig = {
        credential: admin.credential.cert(serviceAccount),
        databaseURL: "https://mh-wiki-wiki.firebaseio.com"
    }

    //Only the initial admin app should exist. If statement prevents duplicate
    //apps for the user.
    if(admin.apps.length < 1){
        return admin.initializeApp(adminConfig, 'abc');
    }else{
        for(var x=0; x<admin.apps.length; x++){
            var thisApp = admin.apps[x];
            if(thisApp.name == 'abc'){
                return thisApp;
            }
        }
        return admin.initializeApp(adminConfig, 'abc');
    }
}



