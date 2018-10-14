var admin = require("firebase-admin");
var serviceAccount = require("./mh-wiki-wiki-firebase-adminsdk-1pwou-e348577509.json");

exports.handler = (event, context, callback) => {
    // TODO implement
    
    context.callbackWaitsForEmptyEventLoop = false;  //<---Important
    
    var firebaseInstance = configFirebase();

    var params = event['params']['querystring'];
    var uid = decodeURI(params['uid']);
    var vote = decodeURI(params['vote']);
    var poll_id = decodeURI(params['poll_id']);

    var db = firebaseInstance.database();
    var ref = db.ref("votes").push();
    
    ref.set({
		uid: uid,
		poll_id: poll_id,
		vote: vote
	}).then(function(res){
	    var pollRef = db.ref("polls").child(poll_id);
    
        pollRef.once("value").then(function(snapshot){
            var count1 = snapshot.val()["count1"];
            var count2 = snapshot.val()["count2"];
            
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
                "voted": 1
            }).then(function(res){
                if (vote == 1) {
                    count1++;
                    var newRef = pollRef.child("option1_votes").push();
                    newRef.set({
                        "uid": uid
                    }).then(function(res){
                        pollRef.update({"count1": count1}).then(function(res){
                            callback(null, {
                                "count1": count1,
                                "count2": count2
                            });
                        });
                    });
                } else {
                    count2++;
                    var newRef = pollRef.child("option2_votes").push();
                    newRef.set({
                        "uid": uid
                    }).then(function(res){
                        pollRef.update({"count2": count2}).then(function(res){
                            callback(null, {
                                "count1": count1,
                                "count2": count2
                            });
                        });
                    })
                }
            });
        });
	});
        /*if (vote == 1) {
            var newRef = pollRef.child("option1_votes").push();
            newRef.set({
                "uid": uid
            }).then(function(res) {
                pollRef.once("value").then(function(snapshot){
                    var count1 = snapshot.val()["count1"];
                    count1++;
                    var option1 = snapshot.val()["option1"];
                    var option2 = snapshot.val()["option2"];
                    var question = snapshot.val()["question"];
                    pollRef.update({"count1": count1}).then(function(res){
                        var rff = db.ref("userInfo").child(uid).child("votes").push();
                        rff.set({
                            "poll_id": poll_id,
                            "option1": option1,
                            "option2": option2,
                            "question": question
                        }).then(function(res){
                            callback(null, uid + " voted for option " + vote + " on " + poll_id);
                        });
                    });
                });
            });
        } else {
            var newRef = pollRef.child("option2_votes").push();
            newRef.set({
                "uid": uid
            }).then(function(res) {
                pollRef.child("count2").once("value").then(function(snapshot){
                    var count2 = snapshot.val();
                    count2++;
                    pollRef.update({"count2": count2}).then(function(res){
                        callback(null, uid + " voted for option " + vote + " on " + poll_id);
                    });
                });
            });
        }
	    
	});
*/
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!')
    };

    //callback(null, "Option 1: " + option1 + ", Option 2: " + option2 + ", question: " + question);
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



