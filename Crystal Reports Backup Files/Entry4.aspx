<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Entry4.aspx.cs" Inherits="DataInnovations.Row.Entry4" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Entry</title>
    <!-- Style Sheets -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous" />
    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <style>
        table {
            width: 100%;
            border: 1px solid #FFFFFF;
            border-collapse: collapse;
        }

            table td, table th {
                border: 1px solid #FFFFFF;
                padding: 5px;
                text-align: left;
            }

            table tbody td {
                font-size: 13px;
            }

            table tr:nth-child(even) {
                background: #D0E4F5;
            }

            table thead {
                background: #0B6FA4;
                border-bottom: 5px solid #FFFFFF;
            }

                table thead th {
                    font-size: 17px;
                    font-weight: bold;
                    color: #FFFFFF;
                    text-align: left;
                    border-left: 2px solid #FFFFFF;
                }

                    table thead th:first-child {
                        border-left: none;
                    }
    </style>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
    <script src="../Dependencies/CascadingDropDown/jquery.cascadingdropdown.min.js"></script>
    <script type="text/javascript">
        var mywidth;
        var mode;
        var tr;

        $(document).ready(function () {
            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                //mywidth = 800;
            }
            $('#div_prognostic').cascadingDropdown({
                selectBoxes: [
                    {
                        selector: '#dd_discipline',
                        source: function (request, response) {
                            $.getJSON('data.asmx/discipline', function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    }
                                }));
                            })
                        },
                        onChange: function (event, value, requiredValues, requirementsMet) {
                            $('#html').html('');
                        }
                    },
                    {
                        selector: '#dd_boat',
                        requires: ['#dd_discipline'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('data.asmx/boat', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        },
                        onChange: function (event, value, requiredValues, requirementsMet) {
                            $('#html').html('');
                        }
                    },
                    {
                        selector: '#dd_division',
                        requires: ['#dd_discipline', '#dd_boat'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('data.asmx/division', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        },
                        onChange: function (event, value, requiredValues, requirementsMet) {
                            $('#html').html('');
                        }
                    },
                    {
                        selector: '#dd_gender',
                        requires: ['#dd_discipline', '#dd_boat', '#dd_division'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('data.asmx/gender', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        },

                        onChange: function (event, value, requiredValues, requirementsMet) {
                            $('#html').html('');
                            if (!requirementsMet) {
                                //$("#btn_submit").prop('disabled', true);
                                //alert('Requirements not met');
                                return;
                            }
                            //alert('Requirements met');
                            //standardised.loading(true);
                            //$("#btn_submit").prop('disabled', false);

                            $.ajax({
                                url: "data.aspx?mode=get_entry&id=" + xx + "&discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val() + "&division=" + $('#dd_division').val() + "&gender=" + $('#dd_gender').val(), success: function (result) {
                                    $('#html').html(myhtml);
                                }
                            });
                       
                        
                        }
                    }
                ]
            });

            $("tr").click(function () {
                mode = $(this).data('mode');
                if (mode == "add") {
                    $("#dialog_edit").find(':input').val('');
                    $('#div_prognostic').show();
                } else {
                    tr = $(this).closest('tr');
                    /*
                    $.ajax({
                        url: "data.aspx?mode=get_entry&id=" + $(this).attr("id"), success: function (result) {
                            $('#html').html(myhtml);
                        }
                    });
                    $('#tb_email_emailaddress').val($(tr).find('td').eq(1).text());
                    $('#tb_email_note').val($(tr).find('td').eq(2).text());
                    */
                }
                $("#dialog_edit").dialog({
                    resizable: true,
                    //height: 700,
                    width: mywidth - 100,
                    modal: true,
                    position: { my: "top", at: "centre" },
                    appendTo: "#form1"
                });

                var myButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        if (mode == "Add") {
                            $('#tab_entries tbody').append('<tr><td></td><td></td><td></td><td></td></tr>');
                            tr = $('#tab_entries tbody tr:last');
                        }
                        //tr.find(':input').val('');

                        area = $('#area').val();
                        note = $('#note').val();
                        amount = $('#amount').val();
                       
                        //$(tr).find('td').eq(0).text('xxxxx');
                        //$(tr).find('td').eq(1).text('xxxxxx');
                        //$(tr).find('td').eq(2).text('xxxxxx');
                        //$(tr).find('td').eq(3).text('xxxxxx');
                        $(tr).find('td').eq(4).text('10000');
                        //$(tr).find('td').eq(2).text(parseFloat(amount).toFixed(2));

 
                        $(this).dialog("close");
                        alert('to do: update database on Update');
                        /*
                        var arForm = [{ "name": "Transactions_Items_ID", "value": itemid }, { "name": "Transactions_ID", "value": id }, { "name": "area", "value": area }, { "name": "note", "value": note }, { "name": "amount", "value": amount }];
                        var formData = JSON.stringify({ formVars: arForm });

                        $.ajax({
                            type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                            contentType: "application/json; charset=utf-8",
                            url: 'posts.asmx/update_Accounts_Transaction_Items', // the url where we want to POST
                            data: formData,
                            dataType: 'json', // what type of data do we expect back from the server
                            success: function (result) {
                                details = $.parseJSON(result.d);
                                $(tr).attr('id', 'tr_' + details.id);
                            },
                            error: function (xhr, status) {
                                alert("An error occurred: " + status);
                            }
                        });
                       */

                    }
                }

                if (mode != 'Add') {
                    myButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this transaction?")) {
                            $(tr).remove();
                            
                            $(this).dialog("close");
                            alert('to do: update database on Delete');
                            /*
                            var arForm = [{ "name": "Transactions_Items_ID", "value": itemid }];
                            var formData = JSON.stringify({ formVars: arForm });
                            $.ajax({
                                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                contentType: "application/json; charset=utf-8",
                                url: 'posts.asmx/delete_Accounts_Transaction_Items', // the url where we want to POST
                                data: formData,
                                dataType: 'json', // what type of data do we expect back from the server
                                //success: function (result) {
                                //    window.location.href = 'default.aspx';
                                //},
                                error: function (xhr, status) {
                                    alert("An error occurred: " + status);
                                }
                            });
                            */
                        }
                    }
                }
                $("#dialog_edit").dialog('option', 'buttons', myButtons);
            })

            $('body').on('click', '.seatdivision, .seatgender', function () {
                id = $(this).attr('id').split('_')[1];

                if ($(this).attr('id').startsWith('seatdivision_')) {
                    var genderoptions = "";
                    $.ajax({
                        url: "data.asmx/gender?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val() + "&division=" + $('#seatdivision_' + id).val(),
                        dataType: 'json',
                        async: false,
                        success: function (data) {
                            $.each(data, function (i, item) {
                                if ($('#dd_gender').val() == item.value) {
                                    selected = ' selected';
                                } else {
                                    selected = '';
                                }
                                genderoptions += '<option value="' + item.value + '"' + selected + '>' + item.label + '</option>';
                            });
                        }
                    });
                    $('#seatgender_' + id).empty().append(genderoptions);
                }


                $.ajax({
                    url: "data.asmx/prognostic?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val() + "&division=" + $('#seatdivision_' + id).val() + "&gender=" + $('#seatgender_' + id).val(),
                    async: false,
                    success: function (result) {
                        jresult = $.parseJSON(result);
                        record = jresult[0];
                        prognostictime = record.prognostictime;
                        $('#span_prognostic_' + id).text(prognostictime);
                    }
                });
                sumprognostics = 0;
                for (f1 = 0; f1 < seats; f1++) {
                    sumprognostics += parseFloat($('#span_prognostic_' + (f1 + 1)).text());
                }
                prognostictime = sumprognostics / seats;
                //alert(prognostictime.toFixed(4));
                $('#span_prognostic').text(prognostictime.toFixed(4));

            });


        }); //document.ready
    </script>

</head>
<body>
    <div class="container" style="background-color: #FCF7EA">
        <form id="form1" runat="server">
            <asp:DropDownList ID="dd_club" runat="server"></asp:DropDownList>
            <table id="tab_entries">
                <thead>
                    <tr>
                        <th>Club</th>
                        <th>Boat</th>
                        <th>Members</th>
                        <th>Prognostic</th>
                        <th>Prognostic Override</th>
                    </tr>
                </thead>
                <tbody>
                    <%= html %>
                </tbody>
            </table>

            <div id="dialog_edit" title="Edit" style="display: none" class="form-horizontal">
                <div id="div_prognostic" style="display:none">
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_discipline">Discipline</label>
                        <div class="col-sm-8">
                            <select id="dd_discipline" name="discipline" class="form-control">
                                <option></option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_boat">Boat</label>
                        <div class="col-sm-8">
                            <select id="dd_boat" name="boat" class="form-control">
                                <option></option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_division">Division</label>
                        <div class="col-sm-8">
                            <select id="dd_division" name="division" class="form-control">
                                <option></option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_gender">Gender</label>
                        <div class="col-sm-8">
                            <select id="dd_gender" name="gender" class="form-control">
                                <option></option>
                            </select>
                        </div>
                    </div>
                </div>
                 <div id="html"></div>
            </div>
            
        </form>
        <form id="form2"></form>
    </div>
</body>
</html>
