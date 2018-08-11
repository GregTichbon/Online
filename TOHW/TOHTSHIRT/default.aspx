<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TOHW.TOHTSHIRT._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!--
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />

       -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous" />
    <style>
        /*
        div.slider {
            background: black;
            color: white;
            border-radius: 1em;
            padding: 1em;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-right: -50%;
            transform: translate(-50%, -50%)
        }

        img {
            height: auto;
            width: auto;
            max-width: 600px;
            max-height: 600px;

        }
            */
        .fillwidth {
            width: 400px;
            height: auto;
        }

        .fillheight {
            height: 400px;
            width: auto;
        }

.greg {
    width: 600px;
    height: 600px;
    position: absolute;
    top:0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
    background-color:red;
}

    </style>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
    <!--<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>-->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script src="../Scripts/Resize-Center/jquery.image-cover.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            /*
              $('.slider').slick({
                  dots: true,
                  infinite: true,
                  speed: 500,
                  fade: true,
                  cssEase: 'linear',
                  adaptiveHeight: true,
                  autoplay: true
              });
              */
            /*
            $(".d-block").imageCover({
                carousel: "#carouselExampleControls"
            });
            */
            $('.carousel-item').each(function () {
                alert($(this).height() + "," + $(this).width());
                var fillClass = ($(this).height() < $(this).width())
                    ? 'fillheight'
                    : 'fillwidth';
                $(this).find('img').addClass(fillClass);
            });



        });
    </script>
</head>
<body>
    <form id="form1" runat="server">


        <!--
        <div class="slider">
            <div>
					<div class="image">
						<img src="images\10379304_762910207083055_2055503312_n.jpg" />
					</div>
				</div>
				<div>
					<div class="image">
						<img src="images\10385069_762910203749722_279961301_n.jpg" />
					</div>
				</div>
        </div>
        -->
        <div class="greg">

            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img class="d-block w-100" src="images\10379304_762910207083055_2055503312_n.jpg" alt="First slide" />
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="images\10385069_762910203749722_279961301_n.jpg" alt="Second slide" />
                    </div>

                </div>
            </div>

        </div>
        <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>






    </form>
</body>
</html>
