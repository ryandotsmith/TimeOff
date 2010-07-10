var tut500 = '#featvid h2';
var tut750 = '#signup p.trial';
var tut999 = '#featvid h2 strong';
var slogan   = '#signup p.slogan';
var slogan_b = '#signup p strong';

Cufon.replace(tut500,  { fontFamily: 'Titillium_500', textShadow: '#fff 1px 1px, #fff 2px 2px' });
Cufon.replace(tut750,  { fontFamily: 'Titillium_750' });
Cufon.replace(tut999,  { fontFamily: 'Titillium_999', textShadow: '#fff 1px 1px, #fff 2px 2px' });
Cufon.replace(slogan,  { fontFamily: 'Titillium_500', color: '-linear-gradient(0=#fff, 1=#cfcfcf)', textShadow: '#111 1px 1px, #111 1px 1px' });
Cufon.replace(slogan_b,{ fontFamily: 'Titillium_999', color: '-linear-gradient(0=#fff, 1=#cfcfcf)', textShadow: '#111 1px 1px, #111 1px 1px' });

$(function(){
  $('#signup p.button').signup();
  $("a[rel=screenshots]").fancybox();
});

(function($) {

  $.fn.signup = function(){
    if (this.length == 0){
      return $(this);
    }
    var hvon = function(){
      $(this).parent().addClass('hv');
    }
    var hvof = function(){
      $(this).parent().removeClass('hv').removeClass('cl');
    }
    var mdfn = function(){
      $(this).parent().addClass('cl');
    }
    var mufn = function(){
      $(this).parent().removeClass('cl');
    }
    $(this).children('a').hover(hvon, hvof).mousedown(mdfn).mouseup(mufn);
    return $(this);
  }

})(jQuery);

$(document).ready(function(){
  $("a[rel=screenshots]").fancybox();
});
