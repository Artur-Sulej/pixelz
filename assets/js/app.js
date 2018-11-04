// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

let channel = socket.channel("board:lobby", {})

channel.on("shout", function (payload) { // listen to the 'shout' event
  console.log("Boom", payload)
});

channel.join(); // join the channel.

document.addEventListener("click", function (event) {
  channel.push("shout", { // send the message to the server on "shout" channel
    some_stuff: "trololol"
  });
});
