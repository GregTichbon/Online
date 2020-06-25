<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Popup1.aspx.cs" Inherits="TOHW._TEST.Popup1" %>



<!doctype html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <title>Site Title</title>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Add an optional button to open the popup -->
        <button class="my_popup_open">Open popup</button>

        <!-- Add content to the popup -->
        <div id="my_popup">
            ...popup content...

    <!-- Add an optional button to close the popup -->
            <button class="my_popup_close">Close</button>

        </div>

        <!-- Include jQuery -->
        <!-- <script src="https://code.jquery.com/jquery-1.8.2.min.js"></script> -->
         <script src="../assets/js/jquery.min.js"></script>

        <!-- Include jQuery Popup Overlay -->
        <!--<script src="https://cdn.rawgit.com/vast-engineering/jquery-popup-overlay/1.7.13/jquery.popupoverlay.js"></script>-->
        <script src="../Scripts/PopupOverlay/jquery.popupoverlay.js"></script>
        <script>
            $(document).ready(function () {

                // Initialize the plugin
                $('#my_popup').popup();

            });
        </script>
    </form>
</body>
</html>
