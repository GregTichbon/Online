﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="items.aspx.cs" Inherits="Auction.items" %>

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
            $(".showitem, .canclick").click(function () {
                itemid = this.id.substring(8);
                //alert('Hi Neo, the item id is: ' + itemid);
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
            });

            $('.slideshow').cycle();




            $('.showitem, .canclick').css('cursor', 'pointer');

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%=html%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>