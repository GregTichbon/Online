<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Registrations.aspx.cs" Inherits="UBC.People.Reports.Registrations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>

    <script>

        $(document).ready(function () {
            $('.registrationview').click(function () {
                id = $(this).attr('id');
                idparts = id.split("_");
                if (idparts[2] == '2017/18' || idparts[2] == '2018/19') {
                    window.open("../RegisterDisplay.aspx?id=" + idparts[1], 'Register');
                } else {
                    window.open("../RegistrationDisplay.aspx?id=" + idparts[1], 'Register');
                }
            });

            $('.link').click(function () {
                id = $(this).attr('id');
                idparts = id.split("_");
                $("#dialog-link").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Save": function () {
                            alert('to do');
                            $(this).dialog("close");
                        }
                    },
                    appendTo: "#form1"
                });

            });

            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                mywidth = 800;
            }

            $('.registrationedit').click(function () {
                id = $(this).attr('id');
                //idparts = id.split("_");
                Ustatus = $(this).find('td:eq(3)').text();
                if (Ustatus != "") {
                    Udate = $(this).find('td:eq(4)').text();
                    Uperson = '<%=Session["UBC_person_id"]%>';  //This should always be the logged in person
                    Unote = $(this).find('td:eq(6)').text();
                } else {
                    Udate = moment(new Date()).format("DD MMM YYYY");
                    Uperson = "<%= personName %>";
                    Unote = "";
                }

                $('#tb_status').val(Ustatus);
                $('#tb_statusdate').val(Udate);
                $('#tb_statusperson').val(Uperson);
                $('#tb_statusnote').val(Unote);

                $("#dialog-edit").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Save": function () {
                            alert('to do');
                            $(this).dialog("close");
                        }
                    },
                    appendTo: "#form1"
                });
            });

            $('#help').click(function () {
                $("#dialog-help").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "OK": function () {
                            $(this).dialog("close");
                        }
                    }
                });
            });

            $('#export').click(function () {
                var table = "<table>";
                $('table > tbody  > tr').each(function () {
                    table += "<tr>";
                    $(this).find('td').each(function () {
                        if (!$(this).hasClass("noexport")) {
                            table += "<td>";
                            if ($(this).find('select').length > 0) {
                                table += $("option:selected", this).text();
                            } else {
                                table += $(this).text();
                            }
                            table += "</td>";
                        }
                    });
                    table += "</tr>";
                });
                table += "</table>";
                $.ajax({
                    type: "POST",
                    url: "../posts.asmx/TabletoExcelCSV",
                    data: '{"table": "' + table + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {

                        //alert(result);
                        details = $.parseJSON(result.d);
                        //console.log(details);
                        $('#div_downloadtext').html('Download: <a href="../downloads/' + details.message + '">File</a>');
                        $("#div_download").dialog({
                            resizable: false,
                            width: 800,
                            modal: true
                        });

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Status: " + textStatus); alert("Error: " + errorThrown);
                    }
                });
                //alert(table);
            });

        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA; width: 100%">
        <div class="toprighticon">
            <input type="button" id="export" class="btn btn-info" value="Export" />
            <input type="button" id="help" class="btn btn-info" value="Help" />
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Registrations
        </h1>

        <table class="table">
            <%= html_registration %>
        </table>

        <div id="dialog-help" title="Help" style="display: none;">
            <p>This is a list of all registrations received online.</p>
            <p>You may view the registration as it was submitted.</p>
            <p>The information that is contained within the registration can be used to verify and maintain the person's record.</p>
            <p>The status of the most current registration for each person can be updated to note that it has or is being actioned</p>
            <p>There is smome work to be done on those registrations that are received which are not associated to an exisiting person record.</p>
        </div>
        <div id="div_download" title="Download" style="display: none;">
            <div id="div_downloadtext"></div>
        </div>
        <div id="dialog-link" title="Edit" style="display: none" class="form-horizontal">
            <h2>Linking still to be done, this will either 1) select an exisiting person and change the guid of "Person" record or 2) allow the creation of a "Person" record and assign the "Registration" guid</h2>
        </div>

        <div id="dialog-edit" title="Edit" style="display: none" class="form-horizontal">
            <h2>Updating still to be done, default to todays date, make person use currently logged on user.</h2>

            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_status">Status</label>
                <div class="col-sm-8">
                    <select id="dd_status" name="dd_status" class="form-control" required="required">
                        <%= Generic.Functions.populateselect(statuses, "","None") %>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="tb_statusdate" class="control-label col-sm-4">
                    Date
                </label>
                <div class="col-sm-8">
                    <div class="input-group standarddate">
                        <input id="tb_statusdate" name="tb_statusdate" placeholder="eg: 23 Jun 1985" type="text" class="form-control" required="required" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="span_statusperson">Person</label>
                <div class="col-sm-8">
                    <span id="span_statusperson" class="form-control"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_statusnote">Note</label>
                <div class="col-sm-8">
                    <textarea id="tb_statusnote" name="tb_statusnote" class="form-control"></textarea>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
