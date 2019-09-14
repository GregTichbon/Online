<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="UBC.People.SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />
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
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.js"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            var canvas = $("#canvas"),
                context = canvas.get(0).getContext("2d"),
                $result = $('#result');

            $('#getphoto').click(function () {
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
                        "Restore": function () {
                            canvas.cropper('reset');
                            //$result.empty();
                        },
                        "Cancel": function () {
                            canvas.cropper("destroy");
                            $(this).dialog("close");
                        },
                        "Upload": function () {
                            var image = canvas.cropper('getCroppedCanvas').toDataURL("image/jpg");
                            image = image.replace('data:image/png;base64,', '');
                            $.ajax({
                                type: "POST",
                                //async: false,
                                url: "posts.asmx/SaveSignupImage",
                                data: '{"imageData": "' + image + '", "id": "' + <%: hf_signup_ctr %> + '"}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (result) {
                                    //alert(result);
                                    d = new Date();
                                    $("#img_photo").attr("src", "images/signup/<%:hf_signup_ctr %>.jpg?" + d.getTime());
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
            $('#fileInput').on('change', function () {
                if (this.files && this.files[0]) {
                    if (this.files[0].type.match(/^image\//)) {
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

            if ($('#dd_school').val() != "") {
                $("#div_schoolyear").show();
            }


            $("#form1").validate({
                /*rules: {
                    tb_birthdate: {
                        pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                    }
                },
                messages: {
                    tb_birthdate: {
                        pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                    }
                }*/
            });

            /*
            $('#div_birthdate').datetimepicker({
                format: 'D MMM YYYY',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                //daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: false,
                sideBySide: true,
                viewMode: 'years'
                //,maxDate: moment().add(-1, 'year')
            });

            $("#div_birthdate").on("dp.change", function (e) {
                calculateage(e.date);
            });

            var e = moment($("#div_birthdate").find("input").val());
            calculateage(e);
            */
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

            /*
            $('#dd_school').change(function () {
                school = $(this).val();
                //alert('*' + school + '*');
                if (school != "") {
                    $("#div_schoolyear").show();
                } else {
                    $("#div_schoolyear").hide();
                    $("#dd_schoolyear").prop('selectedIndex', 0);
                }
            });
            */

            /*
            $('#tb_birthdate').change(function () {

            });
            */


            //$('[required]').css('border', '1px solid red');
            //$('[required]').addClass('required');
        });

        /*
        function calculateage(e) {
            if (moment(e).isValid()) {
                if (moment().diff(e, 'seconds') < 0) {
                    e.date = moment(e).subtract(100, 'years');
                    $("#tb_birthdate").val(moment(e).format('D MMM YYYY'));
                }
                var years = moment().diff(e, 'years');
                thisyear = moment().year();
                var jan1 = moment([thisyear, 1, 1]);
                $("#span_age").text('Age: ' + years + ' years, ' + jan1.diff(e, 'years') + ' years at 1 Jan ' + thisyear);

                //if (years < 18) {
                //    $('#div_parent').show();
                //} else {
                //    $('#div_parent').hide();
                //    $('#tb_parentcaregiver1').val('');
                //    $('#tb_parentcaregiver1mobilephone').val('');
                //    $('#tb_parentcaregiver1emailaddress').val('');
                //    $('#tb_parentcaregiver2').val('');
                //    $('#tb_parentcaregiver2mobilephone').val('');
                //    $('#tb_parentcaregiver2emailaddress').val('');

                //}


            }
        }
        */

    </script>
    <style type="text/css">
        .style1 {
            text-align: center;
            font-size: xx-large;
        }
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="hf_guid" name="hf_guid" type="hidden" value="<%:hf_guid%>" />

    <div class="container" style="background-color: #B1C9E6">
        <p></p>
        <table style="width: 100%">
            <tr>
                <td style="width: 350px">
                    <img src="http://private.unionboatclub.co.nz/dependencies/images/Logo-Page-Head.png" style="width: 100%" /></td>
                <td style="text-align: center">
                    <h1>Schools Learn to Row<br />
                        Friday 23 - Sunday 25 August 2019
                    </h1>
                </td>
            </tr>
        </table>
        <p></p>
        <hr />
        <p></p>
        <p class="style1">Read the <a href="SchoolLearntoRowAug2019.pdf" target="_blank">brochure</a></p>

        <div class="panel panel-danger">
            <div class="panel-heading">Student</div>
            <div class="panel-body">

                <!------------------------------------------------------>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_firstname">First name</label>
                    <div class="col-sm-8">
                        <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" value="<%:tb_firstname%>" maxlength="20" required />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_lastname">Last name</label>
                    <div class="col-sm-8">
                        <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" value="<%:tb_lastname%>" maxlength="30" required />
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_gender">Gender</label>
                    <div class="col-sm-8">
                        <select id="dd_gender" name="dd_gender" class="form-control" required>
                            <option></option>
                            <%= Generic.Functions.populateselect(gender, dd_gender,"None") %>
                        </select>
                    </div>
                </div>

                <!--
                <div class="form-group">
                    <label for="tb_birthdate" class="control-label col-sm-4">
                        Date of birth
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group date" id="div_birthdate">
                            <input id="tb_birthdate" name="tb_birthdate" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: tb_birthdate %>" required />

                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>

                            <span id="span_age" class="input-group-addon"></span>
                        </div>
                    </div>
                </div>
                -->

                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_school">School</label>
                    <div class="col-sm-8">
                        <select id="dd_school" name="dd_school" class="form-control" required>
                            <%= Generic.Functions.populateselect(school, dd_school,"") %>
                        </select>
                    </div>
                </div>
                <div id="div_schoolyear" class="form-group">
                    <label class="control-label col-sm-4" for="dd_schoolyear">School year</label>
                    <div class="col-sm-8">
                        <select id="dd_schoolyear" name="dd_schoolyear" class="form-control" required>
                            <%= Generic.Functions.populateselect(schoolyear, dd_schoolyear,"") %>
                        </select>
                    </div>
                </div>




                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
                    <div class="col-sm-8">
                        <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control" maxlength="100" required value="<%:tb_emailaddress%>" />
                    </div>
                </div>
                <!--
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_homephone">Home phone</label>
                    <div class="col-sm-8">
                        <input id="tb_homephone" name="tb_homephone" type="text" class="form-control numeric" value="<%:tb_homephone%>" maxlength="20" />
                    </div>
                </div>
                -->

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_mobilephone">Mobile phone</label>
                    <div class="col-sm-8">
                        <input id="tb_mobilephone" name="tb_mobilephone" type="text" class="form-control numeric" value="<%:tb_mobilephone%>" maxlength="20" required />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_notes">Anything else you want to let us know?</label>
                    <div class="col-sm-8">
                        <textarea id="tb_notes" name="tb_notes" class="form-control"><%:tb_notes%></textarea>
                    </div>
                </div>
                <!--
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_school">Swimming ability</label>
                    <div class="col-sm-8">
                        <select id="dd_swimmer" name="dd_swimmer" class="form-control" required>
                            <%= Generic.Functions.populateselect(swimmer, dd_swimmer,"") %>
                        </select>
                    </div>
                </div>
                -->
                <!------------------------------------------------------>

            </div>
        </div>


        <div class="panel panel-danger" id="div_parent">
            <div class="panel-heading">Parent/Caregivers</div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver1">Name(s)</label>
                    <div class="col-sm-8">
                        <input id="tb_parentcaregiver1" name="tb_parentcaregiver1" type="text" class="form-control" value="<%:tb_parentcaregiver1%>" maxlength="100" required />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver1phone">Contact phone number(s)</label>
                    <div class="col-sm-8">
                        <input id="tb_parentcaregiver1phone" name="tb_parentcaregiver1phone" type="text" class="form-control" value="<%:tb_parentcaregiver1phone%>" required maxlength="20" />
                    </div>
                </div>
                <!--
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver1mobilephone">Mobile phone</label>
                    <div class="col-sm-8">
                        <input id="tb_parentcaregiver1mobilephone" name="tb_parentcaregiver1mobilephone" type="text" class="form-control numeric" value="<%:tb_parentcaregiver1mobilephone%>" required maxlength="20" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver1emailaddress">Email address</label>
                    <div class="col-sm-8">
                        <input id="tb_parentcaregiver1emailaddress" name="tb_parentcaregiver1emailaddress" type="email" class="form-control" maxlength="100" required value="<%:tb_parentcaregiver1emailaddress%>" />
                    </div>
                </div>
                -->
                <!--

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver">Name (2)</label>
                    <div class="col-sm-8">
                        <input id="tb_parentcaregiver2" name="tb_parentcaregiver2" type="text" class="form-control" value="<%:tb_parentcaregiver2%>" maxlength="100" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver2mobilephone">Mobile phone (2)</label>
                    <div class="col-sm-8">
                        <input id="tb_parentcaregiver2mobilephone" name="tb_parentcaregiver2mobilephone" type="text" class="form-control numeric" value="<%:tb_parentcaregiver2mobilephone%>" maxlength="20" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_parentcaregiver2emailaddress">Email address (2)</label>
                    <div class="col-sm-8">
                        <input id="tb_parentcaregiver2emailaddress" name="tb_parentcaregiver2emailaddress" type="email" class="form-control" maxlength="100" value="<%:tb_parentcaregiver2emailaddress%>" />
                    </div>
                </div>
            </div>
     -->
            </div>




            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
                </div>
            </div>

            <img id="img_photo" alt="" src="Images/Signup/<%: hf_signup_ctr %>.jpg" style="width: 200px" /><br />
            <a id="getphoto">Upload Photo</a>


            <div id="dialog-getphoto" title="Upload Photo" style="display: none">
                <div class="imagecontainer">
                    <input type="file" id="fileInput" accept="image/*" />
                    <canvas id="canvas" style="display: none">Your browser does not support the HTML5 canvas element.
                    </canvas>
                    <br />
                    <input type="button" id="btn_Crop" class="btn btn-info" value="Crop" style="display: none" />
                    <div id="preview"></div>
                    <div id="result"></div>
                </div>

            </div>
        </div>

    </div>
</asp:Content>
