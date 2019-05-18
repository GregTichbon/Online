<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="items.aspx.cs" Inherits="Auction.items" %>

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

        .cycle-slide {
            height:200px;
        }

    </style>
    <script src="<%: ResolveUrl("~/_Includes/Scripts/cycle2/jquery.cycle2.min.js")%>"></script>

    
    <script>
        $(document).ready(function () {
            //mywidth = $(window).width() * .95;
            /*
            if (mywidth > 800) {
                mywidth = 800;
            }
            */

            $(".showitem, .canclick").click(function () {
                itemid = this.id.substring(8);
                //alert('The item id is: ' + itemid);
                $('body').addClass('stop-scrolling');
                $('#dialog_showitem').dialog({
                    modal: true,
                    open: function () {
                        $(this).load('showitem.aspx?id=' + itemid);
                    },
                    width: $(window).width() * .95,
                    height: 800,
                    close: function () {
                        $('body').removeClass('stop-scrolling');
                    }
                    //,                    title: 'xxxxx'
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

            $('.slideshow').cycle();
            $('.showitem, .canclick').css('cursor', 'pointer');
        });  //document.ready

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%=html%>
    <div id="dialog_showitem"></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
