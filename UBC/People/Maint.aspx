﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maint.aspx.cs" Inherits="UBC.People.Maint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

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
    <script src="<%: ResolveUrl("~/Dependencies/jscolor.js")%>"></script>

    <!--additional-methods.min.js-->

    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                var x = $(event.target).text();         // active tab
                var y = $(event.relatedTarget).text();  // previous tab
                $(".act span").text(x);
                $(".prev span").text(y);
            });

            $("#form1").validate({
                rules: {
                    tb_birthdate: {
                        pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                    }
                },
                messages: {
                    tb_birthdate: {
                        pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                    }
                }
            });

            $('.submit').click(function () {
                alert(JSON.stringify(results_grid.getChanges()));
                alert(JSON.stringify(results_grid.getAll(true)));

            })

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

            $('.send_text').click(function () {
                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }
                $("#dialog-sendtext").dialog({
                    resizable: false,
                    height: 250,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Send": function () {
                            alert("to do");
                            $(this).dialog("close");
                        }
                    }
                });
            })
            $('.send_email_system').click(function () {
                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }
                $("#dialog-sendemail").dialog({
                    resizable: false,
                    height: 400,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Send": function () {
                            alert("to do - send to: " + $('td:first', $(this).parents('tr')).text());
                            $(this).dialog("close");
                        }
                    }
                });
            })

            $('.send_email_local').click(function () {
                email = $('td:first', $(this).parents('tr')).text();
                firstname = $('#tb_firstname').val();
                knownas = $('#tb_knownas').val();
                if (knownas == "") {
                    knownas = firstname;
                }
                $(this).attr("href", "mailto:" + email + "?subject=Union Boat Club&body=Hi " + knownas);
            })

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
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Upload": function () {
                            alert("to do");
                            $(this).dialog("close");
                        }
                    }
                });
            })

            $('.registration_view').click(function () {
                alert('To do: ajax aspx return dialog, not editable OR dialog iframe');
            })


            $('.inhibitcutcopypaste').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            //$('[required]').css('border', '1px solid red');
            $('[required]').addClass('required');
        });

        function calculateage(e) {
            if (moment().diff(e, 'seconds') < 0) {
                e.date = moment(e).subtract(100, 'years');
                $("#tb_birthdate").val(moment(e).format('D MMM YYYY'));
            }
            var years = moment().diff(e, 'years');
            thisyear = moment().year();
            thismonth = moment().month() + 1;
            if (thismonth >= 9) {
                thisyear = thisyear + 1;
            }
            var jan1 = moment([thisyear, 1, 1]);
            $("#span_age").text('Age: ' + years + ' years, ' + jan1.diff(e, 'years') + ' years at 1 Jan ' + thisyear);
        }




    </script>
    <style type="text/css">
               
    </style>
</head>
<body>

    <div class="container" style="background-color: #FCF7EA">
        <form id="form1" runat="server" class="form-horizontal" role="form">
            <input id="hf_guid" name="hf_guid" type="hidden" value="<%:hf_guid%>" />
            <h1>Union Boat Club - Person Maintenance
            </h1>

            <div class="row">
                <div class="col-md-8">
                    <div class="row form-group">
                        <label class="control-label col-md-6" for="tb_firstname">First name</label>
                        <div class="col-md-6">
                            <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" value="<%:tb_firstname%>" maxlength="20" required />
                        </div>

                    </div>
                    <div class="row form-group">
                        <label class="control-label col-md-6" for="tb_knownas">Known as</label>
                        <div class="col-md-6">
                            <input id="tb_knownas" name="tb_knownas" type="text" class="form-control" value="<%:tb_knownas%>" maxlength="20" />
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="control-label col-md-6" for="tb_lastname">Last name</label>
                        <div class="col-md-6">
                            <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" value="<%:tb_lastname%>" maxlength="20" />
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <img alt="" src="Images/<%: hf_person_id %>.jpg" style="width: 200px" /><br />
                    <a id="getphoto">Upload Photo</a>
                </div>
            </div>

            <div id="dialog-getphoto" title="Upload Photo" style="display: none">
                <iframe height="95%" width="95%" frameborder="0" scrolling="no" src="uploadphoto.aspx?id=<%: hf_person_id %>"></iframe>
            </div>

            <div id="dialog-sendtext" title="Send Text" style="display: none" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_textmessage">Message</label>
                    <div class="col-sm-8">
                        <textarea id="tb_textmessage" name="tb_textmessage" class="form-control"></textarea>
                    </div>
                </div>
            </div>

            <div id="dialog-sendemail" title="Send Email" style="display: none" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_subject">Subject</label>
                    <div class="col-sm-8">
                        <input id="tb_subject" name="tb_subject" type="text" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_body">Message</label>
                    <div class="col-sm-8">
                        <textarea id="tb_body" name="tb_body" class="form-control" rows="6"></textarea>
                    </div>
                </div>
            </div>

            <ul class="nav nav-tabs">
                <li class="active"><a data-target="#div_basic">Basic</a></li>
                <%=html_tabs %>
                <li><a data-target="#div_category">Category</a></li>
                <li><a data-target="#div_phone">Phone</a></li>
                <li><a data-target="#div_address">Address</a></li>
                <li><a data-target="#div_email">Email</a></li>
                <li><a data-target="#div_attendance">Attendance</a></li>
                <li><a data-target="#div_results">Results</a></li>
                <li><a data-target="#div_registration">Registration</a></li>
            </ul>
            <div class="tab-content">
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_basic" class="tab-pane fade in active">
                    <h3>Basic</h3>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_gender">Gender</label>
                        <div class="col-sm-8">
                            <select id="dd_gender" name="dd_gender" class="form-control" required>
                                <%= Generic.Functions.populateselect(gender, dd_gender,"None") %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="tb_birthdate" class="control-label col-sm-4">
                            Date of birth
                        </label>
                        <div class="col-sm-8">
                            <div class="input-group date" id="div_birthdate">
                                <input id="tb_birthdate" name="tb_birthdate" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: tb_birthdate %>" />

                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>

                                <span id="span_age" class="input-group-addon"></span>
                            </div>
                        </div>
                    </div>



                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_medical">Medical</label>
                        <div class="col-sm-8">
                            <textarea id="tb_medical" name="tb_medical" class="form-control"><%: tb_medical %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_dietry">Dietry requirements</label>
                        <div class="col-sm-8">
                            <textarea id="tb_dietry" name="tb_dietry" class="form-control"><%: tb_dietry %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_feecategory">Fee category</label>
                        <div class="col-sm-8">
                            <select id="dd_feecategory" name="dd_feecategory" class="form-control">
                                <%= Generic.Functions.populateselect(feecategory, dd_feecategory,"") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_school">School</label>
                        <div class="col-sm-8">
                            <select id="dd_school" name="dd_school" class="form-control">
                                <%= Generic.Functions.populateselect(school, dd_school,"") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_schoolyear">School year</label>
                        <div class="col-sm-8">
                            <input id="tb_schoolyear" name="tb_schoolyear" type="text" class="form-control numeric" value="<%:tb_schoolyear%>" maxlength="2" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_facebook">Facebook</label>
                        <div class="col-sm-7">
                            <input id="tb_facebook" name="tb_facebook" type="text" class="form-control" value="<%:tb_facebook%>" maxlength="150" />
                        </div>
                        <div class="col-sm-1">
                            <a class="btn btn-info" role="button" href="<%: tb_facebook %>" target="UBC_Facebook">Go</a>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_notes">Notes</label>
                        <div class="col-sm-8">
                            <textarea id="tb_notes" name="tb_notes" class="form-control"><%: tb_notes %></textarea>
                        </div>
                    </div>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_attendance" class="tab-pane fade in">
                    <h3>Attendance</h3>
                    <table class="table">
                        <%= html_attendance %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_category" class="tab-pane fade in">
                    <h3>Category</h3>
                    <table class="table">
                        <%= html_category %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_finance" class="tab-pane fade in">
                    <h3>Finance</h3>
                    <table class="table">
                        <%= html_finance %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_phone" class="tab-pane fade in">
                    <h3>Phone</h3>
                    <table class="table">
                        <%= html_phone %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_email" class="tab-pane fade in">
                    <h3>Email</h3>
                    <table class="table">
                        <%= html_email %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_results" class="tab-pane fade in">
                    <h3>Results</h3>
                    <button type="button" id="results_add">Add</button>
                    <table id="tbl_results">
                        <%= html_results %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_system" class="tab-pane fade in">
                    <h3>System</h3>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_colour">Colour</label>
                        <div class="col-sm-8">
                            <input id="tb_colour" name="tb_colour" class="jscolor" value="<%: tb_colour %>" />
                        </div>
                    </div>

                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_address" class="tab-pane fade in">
                    <h3>Address</h3>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_residentialaddress">Residential address</label>
                        <div class="col-sm-8">
                            <textarea id="tb_residentialaddress" name="tb_residentialaddress" class="form-control" rows="6"><%: tb_residentialaddress %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_postaladdress">Postal address</label>
                        <div class="col-sm-8">
                            <textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control" rows="6"><%: tb_postaladdress %></textarea>
                        </div>
                    </div>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_registration" class="tab-pane fade in">
                    <h3>Registration</h3>
                    <table style="width: 100%">
                        <%= html_registration %>
                    </table>
                </div>

                <p></p>
                <p></p>


                <!------------------------------------------------------------------------------------------------------>
                <div id="div_loginregister" class="tab-pane fade in">
                    <h3>Logins</h3>
                    <table class="table" style="width: 100%">
                        <%= html_loginregister %>
                    </table>
                </div>

                <p></p>
                <p></p>


                <!------------------------------------------------------------------------------------------------------>

                 <div id="div_arrangements" class="tab-pane fade in">
                    <h3>Arrangements</h3>
                    <table class="table" style="width: 100%">
                        <%= html_arrangements %>
                    </table>
                </div>

                <p></p>
                <p></p>


                <!------------------------------------------------------------------------------------------------------>

            </div>
            <!-- tabs -->
            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="submit btn btn-info" Text="Submit" />
                </div>
            </div>
        </form>
    </div>



</body>
</html>
