<%@ Page Title="Union Boat Club - Event" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Event.aspx.cs" Inherits="UBC.People.Event" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/additional-methods.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/dirty.js")%>"></script>
    <style>
        .personnote {
            color: red;
        }
    </style>

    <script>
        var tr_changed = [];

        $(document).ready(function () {

            $("#myForm").dirty();

            $('#export').click(function () {
                var table = "<table>";
                $('table > tbody  > tr').each(function () {
                    table += "<tr>";
                    $(this).find('td').each(function () {
                        table += "<td>";
                        if ($(this).find('select').length > 0) {
                            table += $("option:selected", this).text();
                        } else {
                            table += $(this).text();
                        }
                        table += "</td>";
                    });
                    table += "</tr>";
                });
                table += "</table>";
                $.ajax({
                    type: "POST",
                    url: "posts.asmx/TabletoExcelCSV",
                    data: '{"table": "' + table + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {

                        //alert(result);
                        details = $.parseJSON(result.d);
                        //console.log(details);
                        $('#div_downloadtext').html('Download: <a href="downloads/' + details.message + '">File</a>');
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

        $('#eventlist').click(function () {
            window.location.href = "<%: ResolveUrl("eventlist.aspx")%>";
        })

        $("#form1").validate({
            rules: {
                tb_startdatetime: {
                    pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                },
                tb_enddatetime: {
                    pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                }
            },
            messages: {
                tb_startdatetime: {
                    pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                },
                tb_enddatetime: {
                    pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                }
            }
        });


        $('#togglepeople').click(function () {
            if ($(this).val() == "Show people") {
                $('#div_people').show();
                $(this).val('Hide people');
            } else {
                $('#div_people').hide();
                $(this).val('Show people');
            }
        })

        $('#div_startdatetime').datetimepicker({
            format: 'D MMM YYYY HH:mm',
            extraFormats: ['D MMM YY HH:mm', 'D MMM YYYY HH:mm', 'DD/MM/YY HH:mm', 'DD/MM/YYYY HH:mm', 'DD.MM.YY HH:mm', 'DD.MM.YYYY HH:mm', 'DD MM YY HH:mm', 'DD MM YYYY HH:mm'],
            //daysOfWeekDisabled: [0, 6],
            showClear: true,
            viewDate: false,
            useCurrent: false,
            sideBySide: true,
            viewMode: 'days',
            stepping: 15
            //,maxDate: moment().add(-1, 'year')
        });

        $('#div_enddatetime').datetimepicker({
            format: 'D MMM YYYY HH:mm',
            extraFormats: ['D MMM YY HH:mm', 'D MMM YYYY HH:mm', 'DD/MM/YY HH:mm', 'DD/MM/YYYY HH:mm', 'DD.MM.YY HH:mm', 'DD.MM.YYYY HH:mm', 'DD MM YY HH:mm', 'DD MM YYYY HH:mm'],
            //daysOfWeekDisabled: [0, 6],
            showClear: true,
            viewDate: false,
            useCurrent: false,
            sideBySide: true,
            viewMode: 'days',
            stepping: 15
            //,maxDate: moment().add(-1, 'year')
        });

        $('#dd_categories').select2();
        $('#dd_categories_filter').select2();

        $('#cb_allday').change(function () {
            if ($(this).is(":checked")) {
                $('.usetime').text('');
                myformat = 'D MMM YYYY';
                myextraFormats = ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'];
                $('#div_startdatetime').data("DateTimePicker").format(myformat);
                $('#div_startdatetime').data("DateTimePicker").extraFormats(myextraFormats);
                $('#div_enddatetime').data("DateTimePicker").format(myformat);
                $('#div_enddatetime').data("DateTimePicker").extraFormats(myextraFormats);
            } else {
                $('.usetime').text('/time');
                myformat = 'D MMM YYYY HH:mm';
                myextraFormats = ['D MMM YY HH:mm', 'D MMM YYYY HH:mm', 'DD/MM/YY HH:mm', 'DD/MM/YYYY HH:mm', 'DD.MM.YY HH:mm', 'DD.MM.YYYY HH:mm', 'DD MM YY HH:mm', 'DD MM YYYY HH:mm'];
                $('#div_startdatetime').data("DateTimePicker").format(myformat);
                $('#div_startdatetime').data("DateTimePicker").extraFormats(myextraFormats);
                $('#div_enddatetime').data("DateTimePicker").format(myformat);
                $('#div_enddatetime').data("DateTimePicker").extraFormats(myextraFormats);
            }
            });
            if ($('#dd_type').val() == "Regatta") {
                $('#btn_regattalist').show();
            }

            $('#dd_type').change(function () {
                if ($(this).val() == "Regatta" && $('#hf_event_id').val() != 'new') {
                    $('#btn_regattalist').show();
                } else {
                    $('#btn_regattalist').hide();
                    $('#btn_regattalist').hide();
                }
            });

            $('#btn_regattalist').click(function () {
                if ($("#form1").dirty("isDirty")) {
                    alert('Changes have been made, please submit this form first.')
                } else {
                    window.open('reports/regattalist.aspx?id=' + $('#hf_event_id').val(), '_blank');
                }
            })

        /*
$('#dd_categories_filter').change(function () {
alert($(this).val());
})

$('#dd_show').change(function () {
 
option = $(this).val();

switch (option) {
    case "Only noted":
        $('#tbl_attendance tr[id^=tr_]').each(function () {
            personid = $(this).attr("id").substring(3);
            if ($("#dd_attendance_" + personid).val() == 'No' && $("#tb_note_" + personid).val() == '') {
                $(this).hide();
            } else {
                $(this).show();
            }
        });
        break;
    case "All":
        $('#tbl_attendance tr[id^=tr_]').show()
        break;
    case "Not noted":
        $('#tbl_attendance tr[id^=tr_]').each(function () {
            personid = $(this).attr("id").substring(3);
            if ($("#dd_attendance_" + personid).val() == 'No' && $("#tb_note_" + personid).val() == '') {
                $(this).show();
            }
            else {
                $(this).hide();
            }
        });
        break;
}
});
*/

        processrows();

        $('.tr_field').change(function () {
            //id = $(this).parent().parent().attr('id').substring(3);
            id = $(this).data('id');
            tr_changed.indexOf(id) === -1 ? tr_changed.push(id) : null;
            $("#hf_tr_changed").val(tr_changed.toString());
        });


        $('#btn_refresh').click(function () {
            //Now will have all data but just hidden alert('Get data from server for categories: ' + $('#dd_categories_filter').val());
            processrows();
        })

        });

        function processrows() {

            //This code should be in the loop below ----- START
            var attendances = {};
            var roles = {};
            var key;
            $('[id^=dd_attendance_]').each(function () {
                id = $(this).attr('id').substring(14);
                key = $(this).val();

                if (key == 'No' && $('#tb_note_' + id).val() != '') {
                    key = key + ' with notes';
                }
                if (!attendances[key]) {
                    attendances[key] = 0;
                }
                attendances[key] += 1;

                key = $('#dd_role_' + id).val();
                if (key != '') {
                    if (!roles[key]) {
                        roles[key] = 0;
                    }
                    roles[key] += 1;
                }

            });
            mydiv = "";
            mydelim = "";
            $.each(attendances, function (key, val) {
                //alert([key, val]);
                mydiv += mydelim + [key, val];
                mydelim = " | ";
            });
            mydiv += "<br />";
            mydelim = "";
            $.each(roles, function (key, val) {
                //alert([key, val]);
                mydiv += mydelim + [key, val];
                mydelim = " | ";
            });

            $('#div_count').html(mydiv);
            //This code should be in the loop below ----- END

            showval = $('#dd_show').val();
            category = $('#dd_categories_filter').val();

            $('#tbl_attendance tr[id^=tr_1_]').each(function () {
                personid = $(this).attr("id").substring(5);
                personcategory = $(this).attr("data-category");
                show = false;
                switch (showval) {
                    case "All":
                        show = true;
                        break;
                    case "Not noted":
                        if ($("#dd_attendance_" + personid).val() == '' && $("#tb_note_" + personid).val() == '' && $("#dd_role_" + personid).val() == '' && $("#personnote_" + personid).text() == '') {
                            show = true;
                        }
                        break;
                    case "Only attended or noted":
                        if (($("#dd_attendance_" + personid).val() != '' && $("#dd_attendance_" + personid).val() != 'No' && $("#dd_attendance_" + personid).val() != 'Not going') || $("#dd_attendance_" + personid).val() != '' || $("#tb_note_" + personid).val() != '' || $("#dd_role_" + personid).val() != '' || $("#personnote_" + personid).text() != '') {
                            show = true;
                        }
                        break;
                    case "Only noted":
                        if ($("#dd_attendance_" + personid).val() != '' || $("#dd_attendance_" + personid).val() != '' || $("#tb_note_" + personid).val() != '' || $("#dd_role_" + personid).val() != '' || $("#personnote_" + personid).text() != '') {
                            show = true;
                        }
                        break;
                }
                if (category != null) {
                    found = false;
                    for (f1 = 0; f1 < category.length; f1++) {
                        usecategory = '|' + category[f1] + '|';
                        //console.log(usecategory);
                        //console.log(personcategory);

                        if (personcategory.indexOf(usecategory) != -1 || $("#dd_attendance_" + personid).val() != '') {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        show = false;
                    }
                }
                if (show) {
                    $(this).show();
                    $(this).next().show();
                    $(this).next().next().show();
                } else {
                    $(this).hide();
                    $(this).next().hide();
                    $(this).next().next().hide();
                }

            });

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="hf_tr_changed" name="hf_tr_changed" />
    <input type="hidden" id="hf_event_id" name="hf_event_id" value="<%: event_id %>" />
    <div class="container" style="background-color: #FCF7EA">
        <div class="toprighticon">
            <input type="button" id="export" class="btn btn-info" value="Export" />
            <input type="button" id="eventlist" class="btn btn-info" value="Event List" />
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Event
        </h1>


        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_title">Title</label>
            <div class="col-sm-8">
                <input id="tb_title" name="tb_title" type="text" class="form-control" value="<%: title %>" maxlength="200" required />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="cb_allday">All day</label>
            <div class="col-sm-8">
                <input id="cb_allday" name="cb_allday" type="checkbox" style="width: auto" value="Yes" <%:allday_checked %>class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_startdatetime">Start date<span class="usetime"><%:datetime %></span></label>
            <div class="col-sm-8">
                <div class="input-group date" id="div_startdatetime">
                    <input id="tb_startdatetime" name="tb_startdatetime" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: startdatetime %>" maxlength="20" required />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_enddatetime">End date<span class="usetime"><%:datetime %></span></label>
            <div class="col-sm-8">
                <div class="input-group date" id="div_enddatetime">
                    <input id="tb_enddatetime" name="tb_enddatetime" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: enddatetime %>" maxlength="20" required />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_type">Type</label>
            <div class="col-sm-6">
                <select id="dd_type" name="dd_type" class="form-control" required>
                    <%= Generic.Functions.populateselect(type_values, type,"None") %>
                </select>
            </div>
            <div class="col-sm-2">
                <button class="btn btn-info" style="display: none" type="button" id="btn_regattalist">Regatta List</button>
            </div>
        </div>
     

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_description">Description</label>
            <div class="col-sm-8">
                <textarea id="tb_description" name="tb_description" class="form-control"><%: description %></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_categories">Categories</label>
            <div class="col-sm-8">
                <select id="dd_categories" name="dd_categories" class="form-control" multiple="multiple">
                    <%= categories_values %>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_showattendees">Show on Attendees</label>
            <div class="col-sm-8">
                <select id="dd_showattendees" name="dd_showattendees" class="form-control">
                    <%= Generic.Functions.populateselect(noyes_values, showattendees,"None") %>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_finance">Allow financial transactions</label>
            <div class="col-sm-8">
                <select id="dd_finance" name="dd_finance" class="form-control">
                    <%= Generic.Functions.populateselect(noyes_values, finance,"None") %>
                </select>
            </div>
        </div>

        <input type="button" id="togglepeople" class="btn btn-info" value="Hide people" />
        <div id="div_people">

            <%=html_persons %>
        </div>
        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>
    </div>

    <div id="div_download" title="Download" style="display: none;">
        <div id="div_downloadtext"></div>
    </div>


</asp:Content>
