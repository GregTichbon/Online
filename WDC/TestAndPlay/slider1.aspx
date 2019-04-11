<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="slider1.aspx.cs" Inherits="Online.TestAndPlay.slider1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .ui-slider {
            height: 5em;
            width: 90%;
            margin:0 auto;
        }

        .ui-slider .ui-slider-handle {
            height: 5.5em;
            width: 5.5em;
            margin-left: -2.75em;
            border-color: red;
            text-align:center;
            padding-top:2em;
        }
    </style>


    <script type="text/javascript">

        $(document).ready(function () {

            var handle = $("#slider1");
            var optiontext1 = ["Difficult", "OK", "Easy"]
            $("#slider").slider({
                value: 2,
                min: 1,
                max: 3,
                step: 1,
                create: function () {
                    handle.html(optiontext1[$(this).slider("value") - 1]);
                },
                slide: function (event, ui) {
                    handle.html(optiontext1[ui.value - 1]);
                }
            });

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div id="slider">
        <div id="slider1" class="ui-slider-handle"></div>
    </div>
      
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
