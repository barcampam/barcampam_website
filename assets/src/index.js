import $ from 'jquery'
import 'bootstrap'
// import 'phoenix'
import 'phoenix_html'
import './index.scss'
// import '../../lib/**/*.{css,scss,sass}'
// import '../../lib/**/*.js'

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

$('#speakers-see-more').click(function () {
  $('#speakers').css("height", "")
  $('#speakers-see-more').css("display", "none")
  $('#speakers-see-less').css("display", "")
})

$('#speakers-see-less').click(function () {
  $('#speakers').css("height", "380px")
  $('#speakers-see-more').css("display", "")
  $('#speakers-see-less').css("display", "none")
})

$('#special-speakers-see-more').click(function () {
  $('#special-speakers').css("height", "")
  $('#special-speakers-see-more').css("display", "none")
  $('#special-speakers-see-less').css("display", "")
})

$('#special-speakers-see-less').click(function () {
  $('#special-speakers').css("height", "380px")
  $('#special-speakers-see-more').css("display", "")
  $('#special-speakers-see-less').css("display", "none")
})

$(document).ready(function () {
  $("#livestream").carousel("pause")

  $("#_big_hall").click(function () {
    $("#livestream").carousel(1);
  })

  $("#_308E").click(function () {
    $("#livestream").carousel(2);
  })

  $("#_208E").click(function () {
    $("#livestream").carousel(3);
  })

  $("#_213W").click(function () {
    $("#livestream").carousel(4);
  })

  $("#_214W").click(function () {
    $("#livestream").carousel(5);
  })

  $("#_114W").click(function () {
    $("#livestream").carousel(6);
  })

  $("#_113W").click(function () {
    $("#livestream").carousel(7);
  })
})
