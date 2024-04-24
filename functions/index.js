const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();



exports.sendNotificationSys2T = functions.database.ref('notification sys2 T/status').onUpdate(async (change, context) => {
    const payload = {
    notification: {
      title: 'Temperature Alert!',
      deviceId :'ESP32_Device_2',
      badge: '1',
      sound: 'default'
    }
  };

  const allToken = await admin.database().ref('fcm-token').once('value');
  if (allToken.val() && change.after.val() == 'true') {
    const tokens = Object.keys(allToken.val()).map(key => allToken.val()[key].token);
    const message = {
      data: payload.notification,
      token: tokens[0]
    };
    return admin.messaging().send(message);
  } else {
    console.log('No token available');
  }
});