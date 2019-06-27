<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Auction.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .item-slideshow {
            height: 250px;
        }
            .item-slideshow img {
                width: auto;
                height: 100%;
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
            height:200px;
        }
        .hidden {
            display:none;
        }
        .categoryselected {
            background-color:green;
        }

       
    </style>
    <script src="<%: ResolveUrl("~/_Includes/Scripts/cycle2/jquery.cycle2.min.js")%>"></script>

    
    <script>
        $(document).ready(function () {
            //$('#debug').html('Start');
            var stopscrolling = 0;
            var showingitem = false;
            //mywidth = $(window).width() * .95;
            /*
            if (mywidth > 800) {
                mywidth = 800;
            }
            */
            $(window).scroll(function (e) {
                if (stopscrolling != 0) {
                    //$('html, body').animate({ scrollTop: stopscrolling }, "slow");
                    //$('#debug').html($('#debug').html() + '<br />scrolling=' + stopscrolling);                   
                }
            });

            $('.categoryselect').click(function () {
                $('.categoryselect').removeClass('categoryselected');
                $(this).addClass('categoryselected');
                id = $(this).attr('id').substring(13);
                $('.div_category').each(function () {
                    if ($(this).attr('category') == id || id == 'All') {
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
                //alert('The item id is: ' + itemid);
                $('body').addClass('stop-scrolling');
                //stopscrolling = window.pageYOffset;
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
                        stopscrolling = 0;
                        showingitem = false;
                    },
                    title: title
                });


                /*
                $.colorbox({
                    href: 'showitem.aspx?id=' + itemid,
                    iframe: false,
                    overlayClose: false,
                    width: '90%',
                    height: '90%',
                    onComplete: function () {
                        $('.slideshowitem').cycle();
                        //$(this).colorbox.resize();
                    }
                });
                //$('#colorbox, #cboxOverlay, #cboxWrapper').css('z-index', 99);
                */
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
                            stopscrolling = 0;
                        }
                    }, title: 'Bidding Information'
                });
            })

            $('.slideshow').cycle();
            $('.showitem, .canclick').css('cursor', 'pointer');
        });  //document.ready

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
        <img id="informationIcon" src="Images/Auction<%=parameters["Auction_CTR"]%>/question.png" title="Click on me for information on bidding." />
    <div id="debug"></div>
    <%= categories %>
    <%=html%>
    <div id="dialog_showitem"></div>
    <div id="dialog_showinformation"></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
