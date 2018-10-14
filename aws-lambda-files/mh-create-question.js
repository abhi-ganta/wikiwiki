var admin = require("firebase-admin");
var serviceAccount = require("./mh-wiki-wiki-firebase-adminsdk-1pwou-e348577509.json");

exports.handler = (event, context, callback) => {
    // TODO implement
    
    context.callbackWaitsForEmptyEventLoop = false;  //<---Important
    
    var firebaseInstance = configFirebase();

    var params = event['params']['querystring'];
    var option1 = decodeURI(params['option1']);
    var option2 = decodeURI(params['option2']);
    var question = decodeURI(params['question']);
    
    var c0 = parseInt(decodeURI(params['c0']));
    var c1 = parseInt(decodeURI(params['c1']));
    var c2 = parseInt(decodeURI(params['c2']));
    var c3 = parseInt(decodeURI(params['c3']));
    var c4 = parseInt(decodeURI(params['c4']));
    var c5 = parseInt(decodeURI(params['c5']));
    var c6 = parseInt(decodeURI(params['c6']));

    var uid = decodeURI(params['uid']);

    var db = firebaseInstance.database();
    var ref = db.ref("polls").push();

    var charCountQ = question.length;
    var charCountA = option1.length + option2.length;

    ref.set({
		option1: option1,
		option2: option2,
		question: question,
		count1: 0,
		count2: 0,
		active: 1,
		uid: uid,
		data: {
		    c0: c0,
		    c1: c1,
		    c2: c2,
		    c3: c3,
		    c4: c4,
		    c5: c5,
		    c6: c6,
		    qLen: charCountQ,
		    aLen: charCountA
		}
	}).then(function(res){
	    const response = {
            statusCode: 200,
            body: ref.key
        };
	    callback(null, response);
	});

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


