var admin = require("firebase-admin");
var serviceAccount = require("./mh-wiki-wiki-firebase-adminsdk-1pwou-e348577509.json");

exports.handler = (event, context, callback) => {
    // TODO implement
    
    context.callbackWaitsForEmptyEventLoop = false;  //<---Important
    
    var firebaseInstance = configFirebase();

    var params = event['params']['querystring'];
    var poll_id = decodeURI(params['poll_id']);
    var uid = decodeURI(params['uid']);

    var db = firebaseInstance.database();
    var pollRef = db.ref("polls").child(poll_id);
    
    pollRef.once("value").then(function(snapshot){
        var data = snapshot.val()["data"];
        var c0 = data["c0"];
        var c1 = data["c1"];
        var c2 = data["c2"];
        var c3 = data["c3"];
        var c4 = data["c4"];
        var c5 = data["c5"];
        var c6 = data["c6"];
        
        var qLen = data["qLen"];
        var aLen = data["aLen"];
        
        var rff = db.ref("userInfo").child(uid).child("votes").push();
        rff.set({
            "poll_id": poll_id,
            "c0": c0,
            "c1": c1,
            "c2": c2,
            "c3": c3,
            "c4": c4,
            "c5": c5,
            "c6": c6,
            "qLen": qLen,
            "aLen": aLen,
            "voted": 0
        }).then(function(res){
            callback(null, uid + " successfully skipped " + poll_id);
        });
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



