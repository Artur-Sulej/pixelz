import "phoenix_html"
import $ from "jquery"
import socket from "./socket"


// Functions
function getRandomColor() {
  return "#" + Math.floor(Math.random() * 16 ** 6).toString(16).padStart(6, "0")
}

function paint(x, y, color) {
  const pixel = $(`[data-xcoord='${x}'][data-ycoord='${y}']`)
  pixel.css("background-color", color)
}


// Channel handling
let channel = socket.channel("board:lobby", {})

channel.on("paint_pixel", function ({ x, y, color }) { // listen to the 'paint_pixel' event
  paint(x, y, color)
})

channel.join()


// Handle painting pixels
$(document).ready(function () {
  const color = getRandomColor()

  $(".pixel").click(function ({ currentTarget: { dataset: { xcoord: x, ycoord: y } } }) {
    channel.push("paint_pixel", { x, y, color })
  })
})
