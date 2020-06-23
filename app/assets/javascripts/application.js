// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(function() {
	function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function (e) {
		$('#img_prev').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
		}
	}
	$("#post_post_img").change(function() {
	$('#img_prev').removeClass('hidden');
	readURL(this);
	});
});

//ハンバーガーメニュー
$(function(){
  $('.el_humburger').on('click',function(){
    spNavInout();
  });
});
 
//spナビ開く処理
function spNavIn(){
  $('body').removeClass('js_humburgerClose');
  $('body').addClass('js_humburgerOpen');
  $(".navigation").addClass("js_appear");
  $(".navigation").css({opacity:0});
  $(".navigation").animate({
    opacity: 1
  },200);
  scrollBlocker(true);
}
 
//spナビ閉じる処理
function spNavOut(){
  $(".navigation").animate({
    opacity: 0
  },200)
  $('body').removeClass('js_humburgerOpen');
  $('body').addClass('js_humburgerClose');
  setTimeout(function(){
    $(".navigation").removeClass("js_appear");
  },200);
  scrollBlocker(false);
}
 
//spナビ開閉処理
function spNavInout(){
  if($('body.spNavFreez').length){
    return false;
  }
  if($('body').hasClass('js_humburgerOpen')){
   spNavOut();
  } else {
   spNavIn();
  }
}
 
//ナビ向けスクロール無効化処理
 
var scrollBlockerFlag;
 
function scrollBlocker(flag){
  if(flag){
    scrollpos = $(window).scrollTop();
    $('body').addClass('js_fixed').css({'top': -scrollpos});
    scrollBlockerFlag = true;
  } else {
    $('body').removeClass('js_fixed').css({'top': 0});
    window.scrollTo( 0 , scrollpos );
    scrollBlockerFlag = false;
  }
}