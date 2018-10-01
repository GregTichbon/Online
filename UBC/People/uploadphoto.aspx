<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="uploadphoto.aspx.cs" Inherits="UBC.People.uploadphoto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.css" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/additional-methods.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });



            $("#form1").validate();

            $(".numeric").keydown(function (event) {
                if (event.shiftKey == true) {
                    event.preventDefault();
                }

                if ((event.keyCode >= 48 && event.keyCode <= 57) ||
                    (event.keyCode >= 96 && event.keyCode <= 105) ||
                    event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
                    event.keyCode == 39 || event.keyCode == 46 || (event.keyCode == 190 && 1 == 2)) {
                } else {
                    event.preventDefault();
                }

                if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
                    event.preventDefault();
                //if a decimal has been added, disable the "."-button

            });



            $('.inhibitcutcopypaste').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            //$('[required]').css('border', '1px solid red');
            $('[required]').addClass('required');

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
                                    if (!$("input[name='rb_use']:checked").val()) {
                                        alert('You must choose a person before saving');
                                    } else {
                                        $('#div_search').hide();

                                        var image = canvas.cropper('getCroppedCanvas').toDataURL("image/jpg");
                                        image = image.replace('data:image/png;base64,', '');
                                        $.ajax({
                                            type: "POST",
                                            url: "posts.asmx/SaveImage",
                                            data: '{"imageData": "' + image + '", "id": "' + id + '"}',
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (result) {
                                                //alert(result);
                                                details = $.parseJSON(result.d);
                                                alert(details.status);
                                                window.location.reload();
                                            },
                                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                alert("Status: " + textStatus); alert("Error: " + errorThrown);
                                            }
                                        });
                                    }
                                    //location.reload();
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




        });

    </script>
    <style type="text/css">
        .imagecontainer {
            max-width: 800px;
            max-height: 800px;
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
            width: 1200px;
        }
    </style>
</head>
<body>
    <div class="container" style="background-color: #FCF7EA">
        <form id="form1" runat="server" class="form-horizontal" role="form">

            <!--
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_test">Test</label>
                <div class="col-sm-8">
                    <input id="tb_test" name="tb_test" type="text" class="form-control" />
                </div>
            </div>

                -->

            <div class="imagecontainer">
                <input type="file" id="fileInput" class="btn btn-info" accept="image/*" />
                <canvas id="canvas" style="display: none">Your browser does not support the HTML5 canvas element.
                </canvas>
                <br />
                <input type="button" id="btn_Crop" class="btn btn-info" value="Crop" style="display: none" />
                <input type="button" id="btn_Restore" class="btn btn-info" value="Restore" style="display: none" />
                <input type="button" id="btn_Save" class="btn btn-info" value="Save" style="display: none" />
                <div id="preview"></div>
                <div id="result"></div>
            </div>


        </form>
    </div>
</body>
</html>
