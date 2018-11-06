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

function get_board_name() {
  return window.location.pathname.replace(/\/boards\/|\//g, "")
}


// Channel handling
let channel = socket.channel(`board:${get_board_name()}`, {})

channel.on("paint_pixel", function ({ x, y, color }) {
  paint(x, y, color)
})

channel.on("paint_pixels", function ({ pixels }) {
  pixels.forEach(function ({ x, y, color }) {
    paint(x, y, color)
  })
})

channel.join()


// Handle painting pixels
$(document).ready(function () {
  const color = getRandomColor()

  $(".pixel").click(function ({ currentTarget: { dataset: { xcoord: x, ycoord: y } } }) {
    channel.push("paint_pixel", { x, y, color })
  })
})
