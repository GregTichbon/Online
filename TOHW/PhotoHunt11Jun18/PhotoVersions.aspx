<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PhotoVersions.aspx.cs" Inherits="TOHW.PhotoHunt11Jun18.PhotoVersions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .version {
            width: 200px;
        }

        .original {
            width: 200px;
        }

        #preview {
            overflow: hidden;
            width: 200px;
            height: 200px;
        }

        #canvas {
            background-color: #ffffff;
            cursor: default;
            border: 1px solid black;
            width: 1200px;
        }
    </style>

    <!-- Style Sheets -->
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.css" />
    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/scripts/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.js"></script>




    <script type="text/javascript">


        $(document).ready(function () {

            var canvas = $("#canvas");
            var context = canvas.get(0).getContext("2d");


            $('.version').click(function () {
                thisversion = this;
                photoid = $(thisversion).data('photo');
                versionid = $(thisversion).data('version');
                
                if ($(thisversion).hasClass('notset')) {
                    var img = document.getElementById('image_' + photoid);
                } else {
                    var img = this;
                }

                context.canvas.height = img.naturalHeight;
                context.canvas.width = img.naturalWidth;

                context.drawImage(img, 0, 0);
                var cropper = canvas.cropper({
                    preview: '#preview',
                    dragMode: 'crop',
                    autoCropArea: 0.65,
                    rotatable: true,
                    cropBoxMovable: true,
                    cropBoxResizable: true
                });


                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }
                $("#dialog-getphoto").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "original": function () {
                            canvas.cropper("destroy");
                            var img = document.getElementById('image_' + photoid);
                            context.canvas.height = img.naturalHeight;
                            context.canvas.width = img.naturalWidth;

                            context.drawImage(img, 0, 0);
                            var cropper = canvas.cropper({
                                preview: '#preview',
                                dragMode: 'crop',
                                autoCropArea: 0.65,
                                rotatable: true,
                                cropBoxMovable: true,
                                cropBoxResizable: true
                            });

                        },
                        "Restore": function () {
                            canvas.cropper('reset');
                        },
                        "Cancel": function () {
                            canvas.cropper("destroy");
                            $(this).dialog("close");
                        },
                        "Save": function () {
                            var image = canvas.cropper('getCroppedCanvas').toDataURL("image/jpg");
                            image = image.replace('data:image/png;base64,', '');
                            $.ajax({
                                type: "POST",
                                //async: false,
                                url: "posts.asmx/SavePhoto",
                                data: '{"imageData": "' + image + '", "photo": "' + photoid + '", "version": "' + versionid + '"}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (result) {
                                    d = new Date();
                                    $(thisversion).attr("src", "images/" + result.d.id + ".jpg?" + d.getTime());
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    alert("Status: " + textStatus); alert("Error: " + errorThrown);
                                }
                            });
                            canvas.cropper("destroy");
                            $(this).dialog("close");
                        }
                    }
                });
            })




        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <table>
            <asp:Literal ID="Lit_Images" runat="server"></asp:Literal>
        </table>

        <div id="dialog-getphoto" title="Upload Photo" style="display: none">
            <div class="imagecontainer">
                <canvas id="canvas" style="display: none">Your browser does not support the HTML5 canvas element.
                </canvas>
                <br />
                <input type="button" id="btn_Crop" class="btn btn-info" value="Crop" style="display: none" />
                <div id="preview"></div>

            </div>
        </div>






    </form>
</body>
</html>
