<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Canvas2.aspx.cs" Inherits="UBC.People.TestAndPlay.Canvas2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>




    <script>
        window.addEventListener("paste", function (e) {
            // Handle the event
            retrieveImageFromClipboardAsBlob(e, function (imageBlob) {
                // If there's an image, display it in the canvas
                if (imageBlob) {
                    var canvas = document.getElementById("mycanvas");
                    var ctx = canvas.getContext('2d');

                    // Create an image to render the blob on the canvas
                    var img = new Image();

                    // Once the image loads, render the img on the canvas
                    img.onload = function () {
                        // Update dimensions of the canvas with the dimensions of the image
                        canvas.width = this.width;
                        canvas.height = this.height;

                        // Draw the image
                        ctx.drawImage(img, 0, 0);
                    };

                    // Crossbrowser support for URL
                    var URLObj = window.URL || window.webkitURL;

                    // Creates a DOMString containing a URL representing the object given in the parameter
                    // namely the original Blob
                    img.src = URLObj.createObjectURL(imageBlob);
                }
            });
        }, false);




        /**
         * This handler retrieves the images from the clipboard as a blob and returns it in a callback.
         * 
         * @param pasteEvent 
         * @param callback 
         */
        function retrieveImageFromClipboardAsBlob(pasteEvent, callback) {
            if (pasteEvent.clipboardData == false) {
                if (typeof (callback) == "function") {
                    callback(undefined);
                }
            };

            var items = pasteEvent.clipboardData.items;

            if (items == undefined) {
                if (typeof (callback) == "function") {
                    callback(undefined);
                }
            };

            for (var i = 0; i < items.length; i++) {
                // Skip content if not image
                if (items[i].type.indexOf("image") == -1) continue;
                // Retrieve image on clipboard as blob
                var blob = items[i].getAsFile();

                if (typeof (callback) == "function") {
                    callback(blob);
                }
            }
        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <canvas style="border: 1px solid grey;" id="mycanvas"></canvas>
    </form>
</body>
</html>
