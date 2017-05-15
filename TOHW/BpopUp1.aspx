<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="BpopUp1.aspx.cs" Inherits="TOHW.BpopUp1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Whanganui Te Ora Hou</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
    <link rel="stylesheet" href="assets/css/main.css" />
    <!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
    <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->

    <style>
        #element_to_pop_up {
            background-color: #fff;
            border-radius: 15px;
            color: #000;
            display: none;
            padding: 20px;
            min-width: 400px;
            min-height: 180px;
        }

        .b-close {
            cursor: pointer;
            position: absolute;
            right: 10px;
            top: 5px;
        }
    </style>

    <!-- Scripts -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/jquery.scrollex.min.js"></script>
    <script src="assets/js/jquery.scrolly.min.js"></script>
    <script src="assets/js/skel.min.js"></script>
    <script src="assets/js/util.js"> </script>
    <!-- [if lte IE 8] > <script src="assets/js/ie/respond.min.js" > </script > <![endif] -->
    <script src="assets/js/main.js"></script>
    <script src="scripts/bPopup.js"></script>

    <script>

        $(document).ready(function () {

            // Initialize the plugin
            $('#my-button').on('click', function (e) {

                // Prevents the default action to be triggered. 
                e.preventDefault();

                // Triggering bPopup when click event is fired
                $('#element_to_pop_up').bPopup({
                    contentContainer: '.content',
                    loadUrl: 'test.html' //Uses jQuery.load()
                });

            });


        });
        // Semicolon (;) to ensure closing of earlier scripting
        // Encapsulation
        // $ is assigned to jQuery

        /*
        ; (function ($) {

            // DOM Ready
            $(function () {

                // Binding a click event
                // From jQuery v.1.7.0 use .on() instead of .bind()
                $('#my-button').on('click', function (e) {

                    // Prevents the default action to be triggered. 
                    e.preventDefault();

                    // Triggering bPopup when click event is fired
                    $('#element_to_pop_up').bPopup();

                });

            });

        })(jQuery);
        */
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Button that triggers the popup -->
    <button id="my-button">POP IT UP</button>
    <!-- Element to pop up -->
    <div id="element_to_pop_up">
        <a class="b-close">x</a>
        Content of popup
    </div>
    <div class="content"></div>

</asp:Content>
