var pushNotification;

function onDeviceReady() {
    try
    {
        pushNotification = window.plugins.pushNotification;
        if (device.platform == 'android' || device.platform == 'Android' || device.platform == 'amazon-fireos' ) {
            pushNotification.register(successHandler, errorHandler, {"senderID":"592196293895","ecb":"onNotification"});
        } else {
            pushNotification.register(tokenHandler, errorHandler, {"badge":"true","sound":"true","alert":"true","ecb":"onNotificationAPN"});	// required!
        }
    }
    catch(err)
    {
        txt="There was an error on this page.\n\n";
        txt+="Error description: " + err.message + "\n\n";
        alert(txt);
    }
}

// handle APNS notifications for iOS
function onNotificationAPN(e) {
    if (e.alert) {
        alert('<li>push-notification: ' + e.alert + '</li>');
        // showing an alert also requires the org.apache.cordova.dialogs plugin
        navigator.notification.alert(e.alert);
    }

    if (e.sound) {
        // playing a sound also requires the org.apache.cordova.media plugin
        var snd = new Media(e.sound);
        snd.play();
    }

    if (e.badge) {
        pushNotification.setApplicationIconBadgeNumber(successHandler, e.badge);
    }
}
function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
    }
    return "";
}
// handle GCM notifications for Android
function onNotification(e){
    //alert("3");
    switch( e.event )
    {
        case 'registered':
            if ( e.regid.length > 0 )
            {
                if(window.location.host == "www.holachef.com" || window.location.host == "holachef.com")
                    var customUrl = "http://reports.holachef.com/android/register.php";
                else
                    var customUrl = "http://reports.holachef.com/qa/android/register.php";

                //alert(customUrl);
                var sendData ={};
                sendData['regId'] =  e.regid;
                if(document.cookie.indexOf('user_mobile') != -1)
                    sendData['mobile'] = getCookie('user_mobile');

                //alert("ajax"+e.regid);

                $.ajax({
                    type: "POST",
                    url: customUrl,
                    data: sendData,
                    success: function(data){
                        alert(data);
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        alert("Status: " + textStatus); alert("Error: " + errorThrown);
                    }
                });
                alert("beforeajax");
                window.location='/mobile'
            }
            break;

        case 'message':
            // if this flag is set, this notification happened while we were in the foreground.
            // you might want to play a sound to get the user's attention, throw up a dialog, etc.
            if (e.foreground)
            {
                console.log('<li>--INLINE NOTIFICATION--' + '</li>');
            }
            else
            {	// otherwise we were launched because the user touched a notification in the notification tray.
                if (e.coldstart)
                    console.log('<li>--COLDSTART NOTIFICATION--' + '</li>');
                else
                    console.log('<li>--BACKGROUND NOTIFICATION--' + '</li>');
            }

            console.log('<li>MESSAGE -> MSG: ' + e.payload.message + '</li>');
            //android only
            console.log('<li>MESSAGE -> MSGCNT: ' + e.payload.msgcnt + '</li>');
            //amazon-fireos only
            console.log('<li>MESSAGE -> TIMESTAMP: ' + e.payload.timeStamp + '</li>');
            break;

        case 'error':
            console.log('<li>ERROR -> MSG:' + e.msg + '</li>');
            break;

        default:
            console.log('<li>EVENT -> Unknown, an event was received and we do not know what it is</li>');
            break;
    }
}

function tokenHandler (result) {}

function successHandler (result) {}

function errorHandler (error) {}

document.addEventListener('deviceready', onDeviceReady, true);