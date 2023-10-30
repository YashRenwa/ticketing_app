// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
const { logger } = require("firebase-functions");
const { onRequest } = require("firebase-functions/v2/https");
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { setGlobalOptions } = require("firebase-functions/v2");
// The Firebase Admin SDK to access Firestore.
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");
const { CloudTasksClient } = require("@google-cloud/tasks");

initializeApp();
setGlobalOptions({ maxInstances: 10 });

exports.sendTicketNotification = onRequest(async (req, res) => {
  const ticketName = req.body.ticketName;
  const tokens = req.body.tokens;
  try {
    for (const token of tokens) {
      const message = {
        notification: {
          title: "New ticket Raised",
          body: ticketName,
        },
        token: token,
      };

      getMessaging()
        .send(message)
        .then((response) => {
          logger.log("Successfully sent message:", response);
        })
        .catch((error) => {
          logger.log("Error sending message:", error);
          return error;
        });
    }
    res.send(200);
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
});

exports.sendTicketNotificationSchedule = onDocumentCreated(
  "/tickets/{ticketId}",
  async (event) => {
    const ticketName = event.data.data().problemTitle;

    // Get all tokens from tokens collection.
    const db = getFirestore();
    const snapshot = await db.collection("tokens").doc("all_tokens").get();

    const tokens = snapshot.data().tokens;

    const expiresIn = 60;
    // Schedule Code
    const expirationAtSeconds = Date.now() / 1000 + expiresIn;

    const project = "ticketing-app-bb9d8";
    const location = "us-central1";
    const queue = "notification-scheduler";

    const tasksClient = new CloudTasksClient();
    const queuePath = tasksClient.queuePath(project, location, queue);

    const url = `https://${location}-${project}.cloudfunctions.net/sendTicketNotification`;
    const payload = { tokens: tokens, ticketName: ticketName };

    const task = {
      httpRequest: {
        httpMethod: "POST",
        url,
        body: Buffer.from(JSON.stringify(payload)).toString("base64"),
        headers: {
          "Content-Type": "application/json",
        },
      },
      scheduleTime: {
        seconds: expirationAtSeconds,
      },
    };

    const [response] = await tasksClient.createTask({
      parent: queuePath,
      task,
    });

    const expirationTask = response.name;
  }
);
