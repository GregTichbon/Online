<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="New.aspx.cs" Inherits="BadHagrid.New" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <script async src="https://www.googletagmanager.com/gtag/js?id=UA-113505480-2"></script>

    <script>

        window.dataLayer = window.dataLayer || [];
        function gtag() { dataLayer.push(arguments); }
        gtag('js', new Date());

        gtag('config', 'UA-113505480-2');
    </script>

    <title>Bad Hagrid</title>
    <link rel="apple-touch-icon" sizes="57x57" href="/Dependencies/Images/FavIcon/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="/Dependencies/Images/FavIcon/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/Dependencies/Images/FavIcon/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="/Dependencies/Images/FavIcon/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/Dependencies/Images/FavIcon/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="/Dependencies/Images/FavIcon/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/Dependencies/Images/FavIcon/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="/Dependencies/Images/FavIcon/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="/Dependencies/Images/FavIcon/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192"  href="/Dependencies/Images/FavIcon/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/Dependencies/Images/FavIcon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="/Dependencies/Images/FavIcon/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/Dependencies/Images/FavIcon/favicon-16x16.png">
    <link rel="manifest" href="/Dependencies/Images/FavIcon/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">

    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Roboto|Roboto+Slab&display=swap" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script type="text/javascript" src="<%: ResolveUrl("~/dependencies/downcount/jquery.downCount.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="https://unpkg.com/infinite-scroll@3/dist/infinite-scroll.pkgd.min.js"></script>

    <style type="text/css">
        body {
            font-family: 'Roboto';
        }

        .input {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        #signup {
            padding: 10px;
        }

        #submit {
            padding: 10px;
            width: 100%;
            margin-top: 10px;
        }

        body {
            background: #363f48;
            color: white;
            font: normal 20px 'Open Sans', sans-serif;
            margin-top: 20px;
            background-image: url(dependencies/images/Test2.jpg);
            background-repeat: repeat;
            margin-bottom: 120px;
        }

        ul.countdown {
            list-style: none;
            margin: 10px 0;
            padding: 0;
            display: block;
            text-align: center;
        }

            ul.countdown li {
                display: inline-block;
            }

                ul.countdown li span {
                    font-size: 30px;
                    font-weight: 300;
                    line-height: 30px;
                }

                ul.countdown li.seperator {
                    font-size: 30px;
                    line-height: 24px;
                    vertical-align: top;
                }

                ul.countdown li p {
                    color: white;
                    font-size: 14px;
                }

        ul li img {
            height: 20px;
        }

        .signup {
            text-align: center;
            font-size: large;
        }

        #keen {
            padding: 10px;
            font-size: 20px;
        }

        label.error {
            display: block;
            color: #a94442;
            font-size: medium;
            text-align: left;
            margin-top: -10px;
        }

        .titlecenter {
            display: block;
            margin-left: auto;
            margin-right: auto;
            width: 80%;
        }

        .center {
            margin-left: auto;
            margin-right: auto;
        }

        /*
        .navbar-nav.navbar-center {
            position: absolute;
            left: 50%;
            transform: translatex(-50%);
        }
        */


        .div_content {
            width: 800px;
            position: relative;
            margin-left: auto;
            margin-right: auto;
            font-size: smaller;
            color: #25274D;
            padding: 10px 100px 20px 100px;
            background: #AAABB8;
            border-radius: 25px;
            /*border:2px solid red;*/
        }



            .div_content h2 {
                color: #29648A;
                font-family: 'Roboto Slab';
            }

            .div_content h1 {
                color: #29648A;
                font-family: 'Roboto Slab';
            }

        .footer {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100%;
            background-color: #2E9CCA;
            color: #25274D;
            text-align: center;
        }

            .footer a {
                color: white;
            }

        .header {
            overflow: hidden;
            /*background-color: #333;*/
            position: fixed; /* Set the header to fixed position */
            top: 0; /* Position the header at the top of the page */
            width: 100%; /* Full width */
        }

        .content {
            position: relative;
            top: 35px;
        }

        html {
            height: 101%;
        }

        hr {
            color: gray;
            background-color: gray;
            height: 3px;
            margin: 5px;
        }

        .table {
            border: solid;
            padding: 10px;
        }

        .socialmedia {
            height: 80px;
            padding: 12px;
        }

        #div_imagery img {
            width: 100%;
            padding: 12px;
        }
    </style>


   <script>

        $(document).ready(function () {
            var newsid = 0;
            var last_newsid = -1;
            var isActive = false;
            //var content = "";

            /*
             * function appendContent() {
                $("#div_news").append(content);
            };
            */

            /*
            $('#div_imagery').infiniteScroll({
                // options
                path: '.pagination__next',
                append: '.post',
                history: false,
            });
            */

            $('#navbar1 > ul > li').click(function () {
                id = $(this).prop('id');
                if (id == 'nav_merch') {
                    window.open('https://badhagrid.bandcamp.com/merch', '_blank');
                } else {
                    $('.active').removeClass();
                    $(this).addClass('active');
                    id = "#div" + id.substring(3);
                    $('.activediv').hide();
                    $('.activediv').removeClass('activediv');
                    $(id).addClass('activediv')
                    $(id).show();
                }
            });

            /*
            $('#nav_about').click(function () {
                $('#div_news').hide();
                $('#div_about').show();
            })
            */

            $(window).scroll(function () {
                //if ($(window).scrollTop() + $(window).height() == $(document).height()) {
                //console.log($(window).scrollTop() + ',' + $(document).height() + ',' + window.innerHeight + ',' + ($(document).height() - window.innerHeight));
                //console.log(newsid + ',' + last_newsid);
                //if (newsid != '-1') { // && newsid != last_newsid) {
                //last_newsid = newsid;
                if (!isActive && newsid != -1 && $(window).scrollTop() >= ($(document).height() - window.innerHeight) - 1) {
                    //newsid = $('#hf_news_id').val();
                    isActive = true;
                    $.get("../data.aspx?id=" + newsid, function (data) {
                        dataparts = data.split("|");
                        newsid = dataparts[0];
                        if (newsid != '-1') {
                            //content = dataparts[1];
                            //setTimeout(appendContent(), 1000);
                            $("#div_news").append("<hr />" + dataparts[1]);
                        }
                        isActive = false;
                    });
                }
                //}
            });



            $.get("../data.aspx?id=0", function (data) {
                dataparts = data.split("|");
                newsid = dataparts[0];
                if (newsid != '-1') {
                    $("#div_news").append(dataparts[1]);
                }
            });


            if ("<%:result%>" != "") {
                $('dialog_result').html('<%:result%>');
                $('#dialog_result').dialog({
                    modal: true,
                    width: 400,
                    title: "Sign up",
                    closeText: false
                });
            }


            $('.countdown').downCount({
                date: '12/03/2019 12:00:00',
                offset: +12
            }, function () {
                $('#dialog_result').html("It's happening");
                $('#dialog_result').dialog({
                    modal: true,
                    width: 400,
                    title: "Sign up",
                    closeText: false
                });
            })


            $("#form1").validate({
                rules: {
                    emailaddress: {
                        required: '#mobilenumber:blank'
                    },
                    mobilenumber: {
                        required: '#emailaddress:blank'
                    }
                },
                messages: {
                    emailaddress: {
                        required: "Either an email address"
                    },
                    mobilenumber: {
                        required: "or a mobile phone number are required"
                    },
                    name: {
                        required: "A name is required"
                    }
                }
            });


            $("#keen").click(function () {
                $('#dialog_signup').dialog({
                    modal: true,
                    width: 400,
                    title: "Sign up",
                    closeText: false,
                    open: function () {
                        $(this).parent().appendTo($('#form1'));
                    }
                });
            });

            $('#submit').click(function () {
                if ($("#form1").valid()) {
                    $('#dialog_signup').dialog('close');
                    var arForm = [{ "name": "name", "value": $('#name').val() }, { "name": "emailaddress", "value": $('#emailaddress').val() }, { "name": "mobilenumber", "value": $('#mobilenumber').val() }];
                    var formData = JSON.stringify({ formVars: arForm });
                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        contentType: "application/json; charset=utf-8",
                        url: 'posts.asmx/Update_BadHagrid', // the url where we want to POST
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        success: function (result) {
                            $('#dialog_result').html('Thanks, we\'ve sent a link to you to confirm it, please simply click on the link and we will notify you as "stuff" happens.');
                            $('#dialog_result').dialog({
                                modal: true,
                                width: 400,
                                title: "Sign up",
                                closeText: false
                            });
                        },
                        error: function (xhr, status) {
                            $('#dialog_result').html('Sorry, an error of some sort happened.  Would you please try again');
                            $('#dialog_result').dialog({
                                modal: true,
                                width: 400,
                                title: "Sign up",
                                closeText: false
                            });

                        }
                    });
                };
            });



        });  //document.ready
    </script>

</head>
<body>


    <form id="form1" runat="server">
        <div class="content">
            <img alt="Title Image" src="Dependencies/Images/Title.png" class="titlecenter" />
            <div class="div_content activediv" id="div_news"></div>

            <div class="div_content" id="div_about" style="display: <%=none%>">
                <%=pages["1"] %>
            </div>
         
            <div class="div_content" id="div_imagery" style="display: <%=none%>">
                   <% =images %>
               
            </div>

            <div class="div_content" id="div_dates" style="display: <%=none%>">
                <%=pages["2"] %>
            </div>

            <div class="div_content" id="div_merch" style="display: <%=none%>">
                <a href="https://badhagrid.bandcamp.com/merch">https://badhagrid.bandcamp.com/merch</a>
            </div>
            <div class="div_content" id="div_contact" style="display: <%=none%>">
                <%=pages["3"] %>
            </div>

        </div>
        <div id="dialog_signup" style="display: none; text-align: center">
            <input class="input" type="text" id="name" name="name" placeholder="Name" required="required" />
            <input class="input" type="email" id="emailaddress" name="emailaddress" placeholder="Email Address" />
            <input class="input" type="tel" id="mobilenumber" name="mobilenumber" placeholder="Mobile Phone Number" />
            <input id="submit" type="button" value="Submit" />
        </div>



        <div id="dialog_result" style="display: none" class="signup">
        </div>

    </form>
    <div class="header">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>

                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse center" id="navbar1">
                    <ul class="nav navbar-nav navbar-center">
                        <li id="nav_news" class="active"><a href="#">
                            <img src="Dependencies/Images/news.png" /><span class="sr-only">(current)</span></a></li>
                        <li id="nav_about"><a>
                            <img src="Dependencies/Images/about.png" /></a></li>
                        <li id="nav_imagery"><a href="#">
                            <img src="Dependencies/Images/imagery.png" /></a></li>
                        <li id="nav_dates"><a href="#">
                            <img src="Dependencies/Images/dates.png" /></a></li>
                        <li id="nav_merch"><a href="#">
                            <img src="Dependencies/Images/merch.png" /></a></li>
                        <li id="nav_contact"><a href="#">
                            <img src="Dependencies/Images/contact.png" /></a></li>
                    </ul>

                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid -->
        </nav>
    </div>
    <div class="footer">

        <div class="container" style="width: 100%">
            <div class="row">
                <div class="col-sm-4">
                    <div xstyle="float: left">
                        <a href="https://open.spotify.com/artist/3MDwxDxEbZUmTaTwZ1KGg5?si=kxAbVB2rRYq9USVRysNVRg" target="_blank">
                            <img src="Dependencies/Images/spotify.svg" class="socialmedia" /></a>
                        <a href="https://www.facebook.com/badhagrid/" target="_blank">
                            <img src="Dependencies/Images/facebook.svg" class="socialmedia" /></a>
                        <a href="https://www.instagram.com/badhagrid/" target="_blank">
                            <img src="Dependencies/Images/instagram.svg" class="socialmedia" /></a>
                    </div>
                </div>
                fnews
                <div class="col-sm-4">
                    <div xclass="center" style="display: inline-block; padding-top: 25px">
                        <a id="keen" href="javascript:void(0)">Fan Club mailing list - sign up to get told</a>
                    </div>

                </div>
                <div class="col-sm-4">
                    <div xstyle="float: right">
                        <ul class="countdown">
                            <li>
                                <span class="days">00</span>
                                <p class="days_ref">days</p>
                            </li>
                            <li class="seperator">.</li>
                            <li>
                                <span class="hours">00</span>
                                <p class="hours_ref">hours</p>
                            </li>
                            <li class="seperator">:</li>
                            <li>
                                <span class="minutes">00</span>
                                <p class="minutes_ref">minutes</p>
                            </li>
                            <li class="seperator">:</li>
                            <li>
                                <span class="seconds">00</span>
                                <p class="seconds_ref">seconds</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- <button id="keen" type="button">I'm keen</button>-->
    </div>
</body>
</html>
