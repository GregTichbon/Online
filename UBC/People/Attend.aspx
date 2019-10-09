<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Attend.aspx.cs" Inherits="UBC.People.Attend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>

    <style>
        #blurb {color:red; font-weight:bold;}
    </style>

    <script>
       var mywidth;

        $(document).ready(function () {

            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                mywidth = 800;
            }
            //alert(mywidth);
            /*
            $('.tr_field').change(function () {
                alert('write to db');
            })
            */
            $('table tbody tr').click(function () {
                tr = this;
                $('#attendance').val($(this).find('td:eq(2)').text());
                myval = $(this).find('td:eq(3)').text();
                if (myval != "") {
                    $('#personnote').val(myval);
                }

                $("#div_edit").dialog({
                    resizable: false,
                    width: "auto",
                    modal: true,
                    appendTo: "#form1",
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Save": function () {
                            event_id = $(tr).prop('id').substring(6);
                            $(tr).find('td:eq(2)').text($('#attendance').val());
                            $(tr).find('td:eq(3)').text($('#personnote').val());
                            $("#div_edit").dialog("close");

                            var arForm = [{ "name": "event_id", "value": event_id }, { "name": "person_id", "value": "<%=person_id%>" }, { "name": "person_guid", "value": "<%=guid%>" }, { "name": "attendance", "value": $('#attendance').val() }, { "name": "personnote", "value": $('#personnote').val() }];
                            var formData = JSON.stringify({ formVars: arForm });

                            $.ajax({
                                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                contentType: "application/json; charset=utf-8",
                                url: 'posts.asmx/updateattendance', // the url where we want to POST
                                data: formData,
                                dataType: 'json', // what type of data do we expect back from the server
                                success: function (result) {

                                },
                                error: function (xhr, status) {
                                    alert('error');

                                }
                            });
                        }
                    }
                });
            })
            $('#login').click(function () {
                window.location.href = "<%: ResolveUrl("security/login.aspx")%>";
            })
            $('#menu').click(function () {
                window.location.href = "<%: ResolveUrl("default.aspx")%>";
            })
        }) //document.ready
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA">
         <%=html_button %>
        <h1><%=name %></h1>
        <p id="blurb">To advance in your rowing, and for the sake of your team and crew, and out of respect for the coaches, you are expected to be at all training sessions on time, unless there is good reason which is communicated as early as possible.<br />Please complete the form below for the next 7 days.</p>
        <h3>Click on a row to update.</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Date/Time</th>
                    <th>Detail</th>
                    <th>Attendance</th>
                    <th>Note</th>
                    <!--<th>Updated</th>-->
                </tr>
            </thead>
            <tbody><%=html %></tbody>
        </table>
        <div id="div_edit" title="Edit" style="display: none;">

            <div class="form-group">
                <label class="control-label col-sm-4" for="attendance">Attending</label>
                <div class="col-sm-8">
                    <select id="attendance" name="attendance" class="form-control" required="required">
                        <%= Generic.Functions.populateselect(attendance_values, "","None") %>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="personnote" class="control-label col-sm-4">
                    Note
                </label>
                <div class="col-sm-8">
                    <textarea id="personnote" name="personnote" class="form-control"></textarea>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
