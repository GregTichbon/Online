<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Auction.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Montserrat', sans-serif;
        }

        .item-slideshow {
            max-height: 250px;
        }

            .item-slideshow img {
                width: auto;
                height: auto;
                max-height:100%;
                max-width:100%;
            }

        .donor-slideshow {
            height: 100px;
        }

            .donor-slideshow img {
                width: auto;
                height: 100%;
            }

        .stop-scrolling {
            height: 100%;
            overflow: hidden;
        }

        .stop-scrollingInfo {
            height: 100%;
            overflow: hidden;
        }

        .cycle-slide {
            height: 200px;
        }

        .hidden {
            display: none;
        }

        .categoryselected {
            background-color: green;
            color: white;
        }
    </style>
    <script src="<%: ResolveUrl("~/_Includes/Scripts/cycle2/jquery.cycle2.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/_Includes/Scripts/cycle2/jquery.cycle2.center.min.js")%>"></script>


    <script>
        $(document).ready(function () {

            var stopscrolling = -1;
            var showingitem = false;

            $(window).scroll(function (e) {
                if (stopscrolling != -1) {
                    //$('html, body').animate({ scrollTop: stopscrolling }, "fast");
                    $('html, body').scrollTop(stopscrolling);
                    //$('#debug').html($('#debug').html() + '<br />scrolling=' + stopscrolling);                   
                }
            });

            $('.categoryselect').click(function () {
                $('.categoryselect').removeClass('categoryselected');
                $(this).addClass('categoryselected');
                id = $(this).attr('id').substring(13);
                $('.div_category').each(function () {
                    if ($(this).attr('data-category') == id || id == 'All') {
                        $(this).removeClass('hidden');
                    } else {
                        $(this).addClass('hidden');
                    }
                })
                //$('.hidden').removeClass('hidden');
                //$('#' + id).toggleClass("hidden");
            })

            $(".showitem, .canclick").click(function () {
                showingitem = true;
                //alert($(document).scrollTop());
                itemid = this.id.substring(8);
                title = $(this).attr('data-title');
                $('body').addClass('stop-scrolling');
                stopscrolling = window.pageYOffset;
                //$('#debug').html($('#debug').html() + '<br />stopscrolling=' + stopscrolling);
                $('#dialog_showitem').dialog({
                    modal: true,
                    open: function () {
                        $(this).load('showitem.aspx?id=' + itemid);
                    },
                    width: ($(window).width() - 0) * .95,  //75 x 2 is the width of the question mark top right
                    height: 600, //auto
                    position: { my: "center", at: "100", of: window },
                    close: function () {
                        $(this).html('');
                        $('body').removeClass('stop-scrolling');
                        stopscrolling = -1;
                        showingitem = false;
                    },
                    title: title,
                    closeText: false
                });
            });

            $('#informationIcon').click(function () {
                $('body').addClass('stop-scrollingInfo');
                stopscrolling = window.pageYOffset;
                $('#dialog_showinformation').dialog({
                    modal: true,
                    open: function () {
                        $(this).load('ItemsInformation.aspx');
                    },
                    width: ($(window).width() - 0) * .95,  //75 x 2 is the width of the question mark top right
                    height: 800,
                    close: function () {
                        $('body').removeClass('stop-scrollingInfo');
                        if (!showingitem) {
                            stopscrolling = -1;
                        }
                    }, title: 'Bidding Information',
                    closeText: false
                });
            })

           // $('.donor-link').click(function () {
           //     alert($(this).prop('href'));
           // });

            $('.slideshow').cycle();
            $('.showitem, .canclick').css('cursor', 'pointer');
        });  //document.ready

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <img id="informationIcon" src="Images/Auction<%=parameters["Auction_CTR"]%>/question.png" title="Click on me for information on bidding." />
    <div id="debug"></div>
    <%= categories %>
    <div class="flex flex-wrap">
        <%=html%>
    </div>
    <div id="dialog_showitem"></div>
    <div id="dialog_showinformation"></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
