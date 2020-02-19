<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Slideshow.aspx.cs" Inherits="DataInnovations.Raffles.Slideshow" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-113505480-1"></script>
    <script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-113505480-1');
    </script>

    <title>North Island Secondary Schools Photos</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <style>
        .container {
            width: 1200px;
            height: 600px;
            border: 10px solid red;
        }
       

    </style>



    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script type="text/javascript">
   

        $(document).ready(function () {

         $("#slideshow > img:gt(0)").hide();
            //$("#slideshow > div:gt(0)").hide();

            $('img').each(function(i, item) {
                var width = $(item).width();
                var height = $(item).height();
//alert('1=' + width + ',' + height);
                var widthratio = 1200 / width;
                var heightratio = 600 / height;
                if (widthratio > heightratio) {
                    $(item).css({'width': 'auto', 'height': '600px'});
//alert('2=' + $(item).width() + ',' + $(item).height());
                    var newMargin = (1200 - $(item).width()) / 2 + 'px';
                    $(item).css({'margin-left': newMargin});
                    //var ratio = heightratio;
                } else { 
                    $(item).css({'width': '1200px', 'height': 'auto'});
//alert('3=' + $(item).width() + ',' + $(item).height());
                    var newMargin = (600 - $(item).height()) / 2 + 'px';
                    $(item).css({'margin-top': newMargin });
                    //var ratio = widthratio;
                }
            });

/*
        img {
            width: 100%;
            height: auto;
        }
*/

/*
 $('img').each(function(i, item) {
    var img_height = $(item).height();
    var div_height = 600; //$(item).parent().height();
    if(img_height < div_height){
        //IMAGE IS SHORTER THAN CONTAINER HEIGHT - CENTER IT VERTICALLY
        var newMargin = (div_height-img_height)/2+'px';
        $(item).css({'margin-top': newMargin });
    }else if(img_height>div_height){
        //IMAGE IS GREATER THAN CONTAINER HEIGHT - REDUCE HEIGHT TO CONTAINER MAX - SET WIDTH TO AUTO  
        $(item).css({'width': 'auto', 'height': '100%'});
        //CENTER IT HORIZONTALLY
        var img_width = $(item).width();
        var div_width = $(item).parent().width();
        var newMargin = (div_width-img_width)/2+'px';
        $(item).css({'margin-left': newMargin});
    }
});
*/
          
            if(1 == 2) {
                setInterval(function() { 
                    $('#slideshow > img:first')
                    .fadeOut(2000)
                    .next()
                    .fadeIn(2000)
                    .end()
                    .appendTo('#slideshow');
                },  4000);
            }

            if(1 == 2) {
                setInterval(function() { 
                    $('#slideshow > div:first')
                    .fadeOut(2000)
                    .next()
                    .fadeIn(2000)
                    .end()
                    .appendTo('#slideshow');
                },  4000);
            }
           if(1 == 2) {
                setInterval(function() { 
                    obj = $('#slideshow > img:first');
                    //console.log(obj);
                    obj.next();
                },  2000);
            }
            if(1 == 1) {
                setInterval(function() { 
                    $('#slideshow > img:first')
                    .hide()
                    .next()
                    .show()
                    .end()
                    .appendTo('#slideshow');
                },  4000);
            }

            }); //document.ready
    </script>

</head>
<body>
    <form id="form1" runat="server">

        <div id="slideshow" class="container">
            <img id="1" src="https://scontent.fakl1-2.fna.fbcdn.net/v/t1.0-9/28471480_1617633878283980_3515017228388934910_n.jpg?oh=0e6135ee6f13c7a0cefd3c66458db302&oe=5B3FE77E" />
            <img id="2" src="https://scontent.fakl1-2.fna.fbcdn.net/v/t31.0-8/28516010_1618384914875543_6356660018532325049_o.jpg?oh=fddb236dfe125f53724e7afd7c41a1aa&oe=5B468799" />
            <img id="3" src="https://scontent.fakl1-2.fna.fbcdn.net/v/t31.0-8/28337167_1616167681763933_2149117955115379744_o.jpg?oh=00635c3a4a8b3d5c23f6cf28e869c691&oe=5B3B0700" />
            <img id="4" src="https://scontent.fakl1-2.fna.fbcdn.net/v/t31.0-8/28423665_1616655531715148_5429578332323294245_o.jpg?oh=70c2641c61e9a8c3c60cff41f11c509e&oe=5B4BAAE9" />
        </div>
    </form>
</body>
</html>


