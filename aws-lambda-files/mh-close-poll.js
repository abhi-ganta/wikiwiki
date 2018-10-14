var admin = require("firebase-admin");
var serviceAccount = require("./mh-wiki-wiki-firebase-adminsdk-1pwou-e348577509.json");

exports.handler = (event, context, callback) => {
    // TODO implement
    
    context.callbackWaitsForEmptyEventLoop = false;  //<---Important
    
    var firebaseInstance = configFirebase();

    var params = event['params']['querystring'];
    var poll_id = decodeURI(params['poll_id']);

    var db = firebaseInstance.database();
    var pollRef = db.ref("polls").child(poll_id);

    pollRef.update({
		active:0
	}).then(function(res){
	    pollRef.once("value").then(function(snapshot){
            var count1 = snapshot.val()["count1"];
            var count2 = snapshot.val()["count2"];
            var option1 = snapshot.val()["option1"];
            var option2 = snapshot.val()["option2"];
            var question = snapshot.val()["question"];
           
            callback(null, {
                "poll_id": poll_id,
                "count1": count1,
                "count2": count2,
                "option1": option1,
                "option2": option2,
                "question": question
            });
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



