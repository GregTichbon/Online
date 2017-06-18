<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="DonorList.aspx.cs" Inherits="TOHW.Auction.Admin.DonorList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link rel="stylesheet" href="http://www.datainn.co.nz/Javascript/colorbox/colorbox.css" />
    <link href="main.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="http://www.datainn.co.nz/javascript/colorbox/jquery.colorbox-min.js"></script>
    <script src="http://www.datainn.co.nz/Javascript/jquery.cycle2/jquery.cycle2.min.js"></script>
    <script src="http://www.datainn.co.nz/Javascript/jquery.cycle2/jquery.cycle2.shuffle.min.js"></script>
    <script src="http://www.datainn.co.nz/Javascript/jquery.cycle2/jquery.cycle2.center.min.js"></script>


    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

        });
        $.fn.cycle.defaults.autoSelector = '.slideshow';

    </script>




    <style type="text/css">
        <!--
        .mycentered {
            text-align: center;
        }

        .slideshow {
            width: 120px;
            height: 80px;
            margin: auto;
        }

            .slideshow img {
                opacity: 0;
                filter: alpha(opacity=0);
                max-width: 100%;
                max-height: 100%;
            }
        -->
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a href="donor.aspx">Create</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="default.aspx">Menu</a>
    <table width="75%" border="1" cellspacing="0" cellpadding="5">
        <%=html%>
    </table>
    <a href="default.aspx">Menu</a>
</asp:Content>
