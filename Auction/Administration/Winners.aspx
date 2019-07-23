<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="Winners.aspx.cs" Inherits="Auction.Administration.Winners" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .bidnotactioned {
            display: none;
        }

        .bidnotactionedtd {
            display: none;
        }

        .earlierbid {
            display: none;
        }
        tr.topbid {
            font-weight:bolder;
            color: red;
        }
        tr.divider {
            background-color: black;
        }
        td.header {
            font-size:x-large;
        }
        td.numeric {
            text-align:right;
        }
    </style>

    <script>

        $(document).ready(function () {
            var showunactionedbids = 0;
            var showearlierbids = 0;

            $('#btn_toggleunactionedbids').click(function () {
                if ($(this).val() == 'Show unactioned bids') {
                    $(this).val('Hide unactioned bids');
                    $('.bidnotactionedtd').show();
                    showunactionedbids = 1;
                } else {
                    $(this).val('Show unactioned bids');
                    $('.bidnotactionedtd').hide();
                    showunactionedbids = 0;
                }
                //alert('showunactionedbids: ' + showunactionedbids + '   ,showearlierbids: ' + showearlierbids);
                $('table > tbody  > tr').each(function () {
                    if ($(this).hasClass('bidnotactioned')) {
                        show = 0;
                        if (showunactionedbids == 1 && $(this).hasClass('bidnotactioned')) {
                            if ($(this).hasClass('earlierbid')) {
                                if (showearlierbids == 1) {
                                    show = 1;
                                }
                            } else {
                                show = 1;
                            }
                        }
                        if (show == 1) {
                            $(this).show();
                        } else {
                            $(this).hide();
                        }
                    }
                })
            })

            $('#btn_toggleearlierbid').click(function () {
                if ($(this).val() == 'Show previous bids') {
                    $(this).val('Hide previous bids');
                    showearlierbids = 1;
                } else {
                    $(this).val('Show previous bids');
                    showearlierbids = 0;
                }
                //alert('showearlierbids: ' + showearlierbids + '   ,showunactionedbids: ' + showunactionedbids);
                $('.earlierbid').each(function () {
                    //console.log(1);
                    show = showearlierbids;
                    if (show == 1 && showunactionedbids == 0 && $(this).hasClass('bidnotactioned')) {
                        show = 0;
                    }
                    if (show == 1) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                })
            })
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="btn_toggleunactionedbids" type="button" value="Show unactioned bids" /><input id="btn_toggleearlierbid" type="button" value="Show previous bids" />
    <table class="Xtable">
        <thead>
            <tr>
                <th>Title</th>
                <th>Created</th>
                <th>Name</th>
                <th class="numeric">Reserve</th>
                <th class="numeric">Bid</th>
                <th class="numeric">Auto Bid</th>
                <th class="bidnotactionedtd">Response</th>
            </tr>
        </thead>
        <tbody>
            <%=html%>
        </tbody>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
