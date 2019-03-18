<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PhotoLoad.aspx.cs" Inherits="Online.Cemetery.PhotoLoad" %>

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
            font-size: x-large;
        }
    </style>
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.4.1/cropper.min.js"></script>-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.js"></script>
    <script type="text/javascript">

        var ids;

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
                                    if (!$("input[name='rb_use']:checked").val()) {
                                        alert('You must choose a person before saving');
                                    } else {
                                        $('#div_search').hide();

                                        var image = canvas.cropper('getCroppedCanvas').toDataURL("image/jpg");
                                        image = image.replace('data:image/png;base64,', '');
                                        $.ajax({
                                            type: "POST",
                                            url: "posts.asmx/SaveImage",
                                            data: '{"imageData": "' + image + '", "ids": "' + ids + '"}',
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (result) {
                                                //alert(result);
                                                details = $.parseJSON(result.d);
                                                alert(details.status);
                                                window.location.reload();
                                            },
                                            error: function(XMLHttpRequest, textStatus, errorThrown) { 
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
            $('body').on('click', '#btn_submit', function () {
                $('#results').empty();
                $.ajax({
                    url: "../functions/data.asmx/CemeterySearch?mode=list&surname=" + $("#tb_surname").val() + "&forenames=" + $("#tb_forenames").val(), success: function (result) {
                        burialrecord = $.parseJSON(result);
                        $('#results').append('<table id="searchtable" class="table table-striped table-responsive"><tbody></tbody></table>');
                        table = $("#searchtable");
                        table.append('<tr><th>Name</th><th>Date of Birth</th><th>Date of Death</th><th>Date of Burial</th><th>Use</th></tr>');
                        for (var i = 0, len = burialrecord.length; i < len; ++i) {
                            id = burialrecord[i]['AccessID'];
                            table.append('<tr><td><a class="view" id="' + id + '" href="javascript:void(0);">' + burialrecord[i]['Name'] + '</a></td><td>' + burialrecord[i]['Date_of_Birth'] + '</td><td>' + burialrecord[i]['Date_of_Death'] + '</td><td>' + burialrecord[i]['Date_of_Burial'] + '</td><td><input name="rb_use" id="rb_use_' + id + '" type="checkbox" /></td></tr>');
                        }
                    }
                });
            });
            $('body').on('click', '.view', function () {
                id = $(this).attr("id");
                $(".view").colorbox({ href: "view.aspx?id=" + id, iframe: true, height: "800", width: "700", overlayClose: true });
            });

            $('body').on('click', '[name="rb_use"]', function () {
                var names = "";
                var delim1 = "";
                var delim2 = "";
                ids = "";
                $('[name="rb_use"]:checked').each(function (index) {
                    id = $(this).attr("id").substring(7);
                    ids = ids + delim2 + id;
                    names = names + delim1 + $('#' + id).text();
                    delim1 = "<br />";
                    delim2 = ",";
                });
                $('#div_name').html(names);
                //window.scrollTo(0, 0);
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
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <div id="div_search" style="display: none">


        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_surname">Surname</label>
            <div class="col-sm-8">
                <input id="tb_surname" name="tb_surname" type="text" class="form-control" required />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_forenames">First name</label>
            <div class="col-sm-8">
                <input id="tb_forenames" name="tb_forenames" type="text" class="form-control" required />
            </div>
        </div>
        <!-- SUBMIT -->

        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <input id="btn_submit" type="button" value="Search" class="btn btn-info submit" />
            </div>
        </div>

        <div id="results"></div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
