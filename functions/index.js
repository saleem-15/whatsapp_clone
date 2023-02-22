// const functions = require('firebase-functions');
// const admin = require('firebase-admin');
// admin.initializeApp();

// exports.sendNotifications = functions.firestore.document('chats/{chatId}/messages/{messageId}')
//   .onCreate(async (snapshot, context) => {
//     // Get the chat document
//     const chatId = context.params.chatId;
//     const chatRef = admin.firestore().collection('chats').doc(chatId);
//     const chatSnapshot = await chatRef.get();
//     const chatData = chatSnapshot.data();

//     // Get the message document
//     const message = snapshot.data();
//     const senderId = message.senderId;
//     const senderName = message.senderName;
//     const type = message.type;
//     const text = message.text;

//     // Get the FCM tokens of all the members of the chat, except the sender
//     const members = chatData.members;
//     const tokens = [];
//     for (const member of members) {
//       if (member.id !== senderId) {
//         if (member.fcmToken) {
//           tokens.push(member.fcmToken);
//         }
//       }
//     }

//     // Send the notifications to all the members
//     if (tokens.length > 0) {
//       let body;
//       let data = {
//         chatId: chatId,
//         messageId: message.id,
//         senderId: senderId,
//         senderName: senderName,
//         type: type
//       };
//       switch (type) {
//         case 'text':
//           body = text;
//           data.text = text;
//           break;
//         case 'image':
//           body = 'Photo';
//           data.imageUrl = message.imageUrl;
//           break;
//         case 'video':
//           body = 'Video';
//           data.width = message.width;
//           data.height = message.height;
//           data.videoName = message.videoName;
//           data.videoUrl = message.videoUrl;
//           break;
//         case 'audio':
//           body = 'Audio';
//           data.audioUrl = message.audioUrl;
//           data.fileName = message.fileName;
//           break;
//         case 'file':
//           body = 'File';
//           data.fileUrl = message.fileUrl;
//           data.fileName = message.fileName;
//           data.fileSize = message.fileSize;
//           break;
//         default:
//           body = 'New Message';
//           break;
//       }
//       const payload = {
//         notification: {
//           title: `${senderName} sent a message`,
//           body: body,
//         },
//         data: data
//       };
//       return admin.messaging().sendToDevice(tokens, payload);
//     }
//     return null;
//   });


const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { Timestamp } = require('firebase-admin/firestore');
admin.initializeApp();


exports.sendNotification = functions.firestore
  .document('chats/{chatId}/messages/{messageId}')
  .onCreate((snap, context) => {
    const message = snap.data();
    const messageId = snap.id;
    const chatId = context.params.chatId;

    /// Add the chatId to the message contents (chatId does not exist in the message document in firestore)
    message['chatId'] = chatId;
    message['messageId'] = messageId;

    // Fetch members from the chat
    return admin
      .firestore()
      .collection('chats')
      .doc(chatId)
      .get()
      .then(doc => {
        const members = doc.data().members;
        const senderId = message.senderId;
        const senderName = message.senderName;
        const messageType = message.type;

        console.log('message id=======>', messageId);

        let body;
        // let data = {
        //   chatId: chatId,
        //   messageId: messageId,
        //   senderId: senderId,
        //   senderName: senderName,
        //   type: messageType
        // };

        // Convert all values in the `message` object to strings
        // because in payload all entries must be a string
        //it will delete any property in the message object that has a value of null.

        for (const [key, value] of Object.entries(message)) {
          if (value instanceof admin.firestore.Timestamp) {
            message[key] = value.toDate().toISOString();
          } else if (value !== null && value !== undefined) {
            message[key] = value.toString();
          }else {
            delete message[key];
          }
        }
        
    
        
        // Set notification body based on message type
        switch (messageType) {
          case 'text':
            body = message.text;
            break;
          case 'image':
            body = 'Photo';
            break;
          case 'video':
            body = 'Video';
            break;
          case 'audio':
            body = 'Audio';
            break;
          case 'file':
            body = 'File';
            break;
          default:
            body = 'New message';
        }

        // Filter out the sender from the members list
        const filteredMembers = members.filter(id => id !== senderId);

        // Fetch FCM tokens for all members except the sender
        return admin
          .firestore()
          .collection('users')
          .where(admin.firestore.FieldPath.documentId(), 'in', filteredMembers)
          .get()
          .then(snapshot => {
            // Collect FCM tokens
            const tokens = [];
            snapshot.forEach(doc => {
              tokens.push(doc.data().fcmToken);
            });

            // Create the notification payload
            const payload = {
              // notification: {
              //   title: senderName,
              //   body: body,
              //   click_action: 'FLUTTER_NOTIFICATION_CLICK',
              //   // clickAction: 'FLUTTER_NOTIFICATION_CLICK',
              //   playSound: 'true',
              // },
              data: message
            };

            // Send notifications to all members except the sender
            return admin
              .messaging()
              .sendToDevice(tokens, payload)
              .then(response => {
                return console.log('Notifications sent successfully:', response);
              })
              .catch(error => {
                return console.error('Error sending notifications:', error);
              });
          });
      });
  });

