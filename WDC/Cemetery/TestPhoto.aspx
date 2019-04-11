<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TestPhoto.aspx.cs" Inherits="Online.Cemetery.TestPhoto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.4.1/cropper.min.css" />-->

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.css" />


    <style>
        .imagecontainer {
            max-width: 640px;
            max-height: 400px;
            margin: 20px auto;
        }

        #preview {
            overflow: hidden;
            width: 200px;
            height: 200px;
        }

        img {
            max-width: 100%;
        }

        #canvas {
            background-color: #ffffff;
            cursor: default;
            border: 1px solid black;
        }

        #div_name {
            font-size: xx-large;
        }
    </style>
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.4.1/cropper.min.js"></script>-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.js"></script>
    <script type="text/javascript">


        $(document).ready(function () {

            /*
             var $image = $('#image');
 
             $image.cropper({
                 preview: '#preview',
                 dragMode: 'crop',
                 autoCropArea: 0.65,
                 rotatable: true,
 
                 cropBoxMovable: true,
                 cropBoxResizable: true
             });
 
 
 
 
             $('#btn_Crop').click(function () {
                 var cropper = $image.data('cropper');
                 var cropBoxData = cropper.getCropBoxData();
                 alert(cropBoxData.width)
             })
             */

            var canvas = $("#canvas"),
                context = canvas.get(0).getContext("2d"),
                $result = $('#result');

            $('#fileInput').on('change', function () {
                if (this.files && this.files[0]) {
                    if (this.files[0].type.match(/^image\//)) {
                        $('#btn_Save').show();
                        $('#btn_Restore').show();
                        $('#div_search').show();
                        var reader = new FileReader();
                        reader.onload = function (evt) {
                            var img = new Image();
                            img.onload = function () {
                                context.canvas.height = img.height;
                                context.canvas.width = img.width;
                                context.drawImage(img, 0, 0);
                                var cropper = canvas.cropper({
                                    preview: '#preview',
                                    dragMode: 'crop',
                                    autoCropArea: 0.65,
                                    rotatable: true,
                                    cropBoxMovable: true,
                                    cropBoxResizable: true
                                });
                                $('#btn_Crop').click(function () {
                                    // Get a string base 64 data url
                                    var croppedImageDataURL = canvas.cropper('getCroppedCanvas').toDataURL("image/png");
                                    $result.append($('<img>').attr('src', croppedImageDataURL));
                                });
                                $('#btn_Restore').click(function () {
                                    canvas.cropper('reset');
                                    $result.empty();
                                });
                                $('#btn_Save').click(function () {
                                        var image = canvas.cropper('getCroppedCanvas').toDataURL("image/png");
                                        image = image.replace('data:image/png;base64,', '');
                                        $.ajax({
                                            type: "POST",
                                            url: "posts.asmx/Test",
                                            data: '{"imageData": "' + image + '", "id": "1"}',
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (result) {
                                                //alert(result);
                                                details = $.parseJSON(result.d);
                                                alert(details.status);
                                                window.location.reload();
                                            }
                                        });
                                });
                            };
                            img.src = evt.target.result;
                        };
                        reader.readAsDataURL(this.files[0]);
                    }
                    else {
                        alert("Invalid file type! Please select an image file.");
                    }
                }
                else {
                    alert('No file(s) selected.');
                }
            });
         }); //document ready
    </script>



</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Cemetery Photo Load</h2>
    <div id="div_name"></div>

    <div class="imagecontainer">
        <input type="file" id="fileInput" class="btn btn-info" accept="image/*" />

        <canvas id="canvas" style="display:none">Your browser does not support the HTML5 canvas element.
        </canvas>
        <br />
        <input type="button" id="btn_Crop" class="btn btn-info" value="Crop" style="display: none" />
        <input type="button" id="btn_Restore" class="btn btn-info" value="Restore" style="display: none" />
        <input type="button" id="btn_Save" class="btn btn-info" value="Save" style="display: none" />
        <!--<img id="image" src="../TestAndPlay/Images/146.JPG" alt="Picture">-->
        <div id="preview"></div>
        <div id="result"></div>
    </div>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
