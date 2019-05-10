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
    </style>

    <script src="http://www.datainn.co.nz/Javascript/jquery.cycle2/jquery.cycle2.min.js"></script>
    <script>
        $(document).ready(function () {
            mywidth = $(window).width() * .95;
            /*
            if (mywidth > 800) {
                mywidth = 800;
            }
            */

            $(".showitem, .canclick").click(function () {
                itemid = this.id.substring(8);
                //alert('The item id is: ' + itemid);
                $('#dialog_showitem').dialog({
                    modal: true,
                    open: function () {
                        $(this).load('showitem2.aspx?id=' + itemid);
                    },
                    width: mywidth,
                    height: 800
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
