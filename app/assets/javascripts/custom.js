// grid-system
    $("#hola-container").gridalicious({
      width: 150,
      gutter: 5,
      animate:true,
        animationOptions: {
        queue: true,
        speed: 100,
        duration: 300,
        effect: 'fadeInOnAppear',
        complete: onComplete,
      }
    });
function onComplete()
{
}
//  each item inside modal script
     $(document).ready(function(){
        $('.item').click(function(){
          $('.modal-body').html($(this).html());
        });
     });

// random splash on refresh
 $(document).ready(function(){
    var splash = parseInt(Math.random()*$('.random-imgs .bg-img').length);
    splash +=1;
    $('.bg-img').removeClass('active');
    $('.random-imgs .bg-img:nth-child('+splash+')').addClass('active');
 });

