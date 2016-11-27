<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Online.WMC.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,600,700,300' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Merriweather:400,700' rel='stylesheet' type='text/css'>
    <title></title>

    <link href="styling.css" rel="stylesheet" />
    <script src="modernizr.js"></script>

    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
        ga('create', 'UA-37689824-1', 'warmemorialcentre.co.nz');
        ga('send', 'pageview');
    </script>
</head>
<body>
    <header>
        <a class="homelink" href="/">
            <img src="banner-image.png" />
        </a>
        <nav class="group">
            <h3 class="visible-1000 responsive-button menu-closed">Menu</h3>
            <ul>
                <li class="">
                    <a href="/our-services">Our Services</a>
                </li>
                <li class="">
                    <a href="/facilities">Facilities</a>
                </li>
                <li class="">
                    <a href="/about">About</a>
                </li>
                <li class="">
                    <a href="/whats-on">What&#39;s On</a>
                </li>
                <li class="">
                    <a href="/contact">Contact</a>
                </li>
                <li class="">
                    <a href="/booking">Booking</a>
                </li>
            </ul>

            <div class="search-box">
                <form action="/search" method="get">
                    <input class="search-field" type="search" placeholder="Search" name="q" />
                    <input class="search-submit" type="image" src="/Content/Images/search-icon.png" alt="Submit Form" />
                </form>
            </div>
        </nav>
    </header>

    <main class="group">
            
<div class="page-home">
    <div class="banner"></div>

    <div class="carousel">
        <ul>
                <li><img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/118" alt="Wanganui War Memorial" /></li>
                <li><img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/149" alt="Wanganui War Memorial" /></li>
                <li><img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/191" alt="Wanganui War Memorial" /></li>
                <li><img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/152" alt="Cannon" /></li>
                <li><img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/153" alt="Tables" /></li>
                <li><img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/154" alt="Main Hall" /></li>
        </ul>
            
        <a href="#" class="jcarousel-control-prev inactive" data-jcarouselcontrol="true"></a>
        <a href="#" class="jcarousel-control-next" data-jcarouselcontrol="true"></a>
    </div>
        

    <div class="rich">
        <p>The Whanganui War Memorial Centre (WWMC) is a wonderful multi-purpose venue nestled in the very heart of the Whanganui CBD. Its versatility allows it to cater for small groups from 10 to 1300 people with free parking for&nbsp;70 cars.</p>

<p>Both foyers benefit from natural light, filtered through beautifully designed stained glass windows. Easy access to all areas of the Centre is provided by the front stairs, lift and rear serviceways, and a host of extras including FREE WIFI, sound systems, specialist lighting and much more are provided.</p>

<p><strong>OPENING TIMES - 10 am -&nbsp;4.30pm&nbsp; Monday to Friday &nbsp;or by appointment&nbsp;</strong></p>

    </div>

    <ul class="buttons clear">
            <li>
                <a href="https://www.google.com/calendar/embed?src=warmemorialcentre%40gmail.com&amp;ctz=Pacific/Auckland" class="button"> Check Calendar </a>
            </li>
            <li>
                <a href="/booking" class="button"> Book Now </a>
            </li>
    </ul>

    <ul class="links clear">
            <li>
                <figure>
                    <a href="/facilities">
                        <img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/113" alt="Facilities" />
                        <figcaption>
                            All Facilities
                        </figcaption>
                    </a>
                </figure>
            </li>
            <li>
                <figure>
                    <a href="/our-services/training-and-seminars">
                        <img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/114" alt="Training and Seminars" />
                        <figcaption>
                            Training Seminars &amp; Meetings
                        </figcaption>
                    </a>
                </figure>
            </li>
            <li>
                <figure>
                    <a href="/our-services/weddings">
                        <img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/115" alt="Weddings" />
                        <figcaption>
                            Wedding Receptions &amp; Celebrations
                        </figcaption>
                    </a>
                </figure>
            </li>
            <li>
                <figure>
                    <a href="/our-services/dinners">
                        <img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/116" alt="Dinners" />
                        <figcaption>
                            Dinner Dances &amp; Events
                        </figcaption>
                    </a>
                </figure>
            </li>
            <li>
                <figure>
                    <a href="/about/photo-gallery">
                        <img src="http://contentapi-wanganuisubsites.datacomsphere.co.nz/clients/1/resources/117" alt="Photo Gallery" />
                        <figcaption>
                            Image Gallery
                        </figcaption>
                    </a>
                </figure>
            </li>
    </ul>

</div>


			<div class="clear"></div>
        </main>

    <footer class="group">
        <!--TODO: Footer details are to be pulled from DB-->
        <div class="left-foot">
            <address>
                <p>Whanganui War Memorial Centre</p>
                <p>Watt St. (Queen&#39;s Park) - Whanganui</p>
                <p>
                    10:00am - 4:30pm Mon-Fri or by appointment

                </p>
            </address>
            <div class="contact">
                <p>+64 6 349 0513</p>
                <a href="mailto:warmemorialcentre@wanganui.govt.nz">warmemorialcentre@wanganui.govt.nz</a>
            </div>
            <ul class="links">
                <a href="/about/newsletters">Sign up for newsletters</a>
            </ul>
            <ul class="social group">
                <li>
                    <iframe src="http://www.facebook.com/plugins/like.php?href=http%3a%2f%2fwww.warmemorialcentre.co.nz%2f&width&layout=standard&action=like&show_faces=false&share=true&height=35&appId=855154627836510"></iframe>
                </li>
            </ul>
        </div>
        <div class="right-foot">
            <ul class="affiliates group">
                <li>
                    <a href="http://www.wanganui.govt.nz">
                        <img src="http://wandc-subsites.multichannel-api.datacomcc.com/clients/1/resources/122" alt="Wanganui District Council " /></a>
                </li>
                <li>
                    <a href="http://www.wanganuirsa.co.nz">
                        <img src="http://wandc-subsites.multichannel-api.datacomcc.com/clients/1/resources/121" alt="Wanganui RSA" /></a>
                </li>
            </ul>
        </div>
    </footer>

    <script src="jquery.js"></script>

    <script src="bootstrap.js"></script>

    <script src="warmemorial.js"></script>

    <script src="jcarousel.js"></script>

    <script>

        $(function () {

            var $jcarousel = $('.carousel');

            $jcarousel.on('jcarousel:create jcarousel:reload', function () {
                var element = $(this),
                    width = element.innerWidth();

                element.jcarousel('items').css('width', width + 'px');
            })
                .jcarousel();

            $jcarousel.find('.jcarousel-control-prev').jcarouselControl({ target: '-=1' });
            $jcarousel.find('.jcarousel-control-next').jcarouselControl({ target: '+=1' });
        });
    </script>

</body>
</html>
