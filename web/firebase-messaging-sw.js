importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyAV5W29iTF-9vyGmSptUm8liM2VYV5eYCo',
  appId: '1:1049350208959:android:a76dd84dbd870b1c43350a',
  messagingSenderId: '1049350208959',
  projectId: 'insigh-trding',
  authDomain: 'insigh-trding.firebaseapp.com',
  databaseURL:
      'https://insigh-trding-default-rtdb.firebaseio.com',
  storageBucket: 'insigh-trding.appspot.com',
  measurementId: 'G-7BH00GNXFC',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});
