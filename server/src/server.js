// init project
const express = require('express');
const app = express();
const Ably = require('ably');
var realtime = new Ably.Realtime({key: "vZ7jrQ.pg_eEg:qVyepOstflFEOuEF"});
var rest = new Ably.Rest({key: "vZ7jrQ.pg_eEg:qVyepOstflFEOuEF"});

var uniqueId = function() {
    return 'id-' + Math.random().toString(36).substr(2, 16);
};

var myClientIdnow = uniqueId()

app.use(express.static('public'));

app.get('/', function(request, response) {
  response.send("This is your server home, navigate to \n/auth for authentication\n/device for publishing notifications using deviceId \n/client for publishing notifications using clientid \n/channel for publishing notifications via a realtime channel \n/deviceToken for publishing notifications using deviceToken");
});

// auth server endpoint
// you can use the API key with the required permissions within the rest var to be granted to the client
app.get('/auth', function(req, res){
  var tokenParams = {
    'clientId': myClientIdnow
  }; 
  rest.auth.createTokenRequest(tokenParams, function(err, tokenRequest) {
    if (err) {
      res.status(500).send('Error requesting token: ' + JSON.stringify(err));
    } else {
      res.setHeader('Content-Type', 'application/json');
      res.send(JSON.stringify(tokenRequest));
    }
  });
});

// push directly to device using deviceId
app.get('/push/device', function (req, res) {
  var recipient = {
    deviceId: '<YOUR-DEVICE-ID>'
  };
  var notification = {
    notification: {
      title: 'Hello from Ably!'
    }
  };
  realtime.push.admin.publish(recipient, notification, function(err) {
    if (err) {
      console.log('Unable to publish push notification; err = ' + err.message);
      return;
    }
    console.log('Push notification published');
    res.send("Push Sent");
  });
})

// push directly to device using clientId
app.get('/push/client', function (req, res) {
  var recipient = {
    clientId: '<YOUR-CLIENT-ID>'
  };
  var notification = {
    notification: {
      title: 'Hello from Ably!'
    }
  };
  realtime.push.admin.publish(recipient, notification, function(err) {
    if (err) {
      console.log('Unable to publish push notification; err = ' + err.message);
      return;
    }
    console.log('Push notification published');
    res.send("Push Sent");
  });
})

// push to device via a realtime channel
app.get('/push/channel', function (req, res) {
  var extras = {
    push: {
      notification: {
        title: 'Hello from Ably!',
        body: 'Example push notification from Ably.'
      },
      data: {
        foo: 'bar',
        baz: 'qux'
      }
    }
  };

  var channel = realtime.channels.get('<YOUR-PUSH-CHANNEL>');
  channel.publish({ name: 'example', data: 'data', extras: extras }, function(err) {
    if (err) {
      console.log('Unable to publish message with push notification; err = ' + err.message);
      return;
    }
    console.log('Message with push notification published');
    res.send("Push Sent");
  });
})

// push directly to device using deviceToken
app.get('/push/deviceToken', function (req, res) {
  var recipient = {
    transportType: 'apns',
    deviceToken: '<YOUR-DEVICE-TOKEN>'
  };
  var notification = {
    notification: {
      title: 'Hello from Ably!'
    }
  };
  realtime.push.admin.publish(recipient, notification, function(err) {
    if (err) {
      console.log('Unable to publish push notification; err = ' + err.message);
      return;
    }
    console.log('Push notification published');
    res.send("Push Sent");
  });
})

// listen for requests :)
const listener = app.listen(process.env.PORT, function() {
  console.log('Your app is listening on port ' + listener.address().port);
});
