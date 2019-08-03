<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Control.aspx.cs" Inherits="DataInnovations.Raffles.Control" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://unpkg.com/tabulator-tables@4.2.1/dist/css/tabulator.min.css" rel="stylesheet" />
    <script type="text/javascript" src="https://unpkg.com/tabulator-tables@4.2.1/dist/js/tabulator.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.js"></script>
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!--<script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>-->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <style>
        .mytable {
            width: 100%;
            border: 1px solid #FFFFFF;
            border-collapse: collapse;
        }

            .mytable td, table th {
                border: 1px solid #FFFFFF;
                padding: 5px;
                text-align: left;
            }

            .mytable tbody td {
                font-size: 13px;
            }

            .mytable tr:nth-child(even) {
                background: #D0E4F5;
            }

            .mytable thead {
                background: #0B6FA4;
                border-bottom: 5px solid #FFFFFF;
            }

                .mytable thead th {
                    font-size: 17px;
                    font-weight: bold;
                    color: #FFFFFF;
                    text-align: left;
                    border-left: 2px solid #FFFFFF;
                }

                    .mytable thead th:first-child {
                        border-left: none;
                    }
    </style>
    <script>
        var mywidth;
        $(document).ready(function () {

            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                mywidth = 800;
            }

            var dateEditor = function (cell, onRendered, success, cancel) {
                //cell - the cell component for the editable cell
                //onRendered - function to call when the editor has been rendered
                //success - function to call to pass the successfuly updated value to Tabulator
                //cancel - function to call to abort the edit and return to a normal cell

                //create and style input
                var cellValue = moment(cell.getValue(), "DD/MM/YYYY").format("YYYY-MM-DD"),
                    input = document.createElement("input");

                input.setAttribute("type", "date");

                input.style.padding = "4px";
                input.style.width = "100%";
                input.style.boxSizing = "border-box";

                input.value = cellValue;

                onRendered(function () {
                    input.focus();
                    input.style.height = "100%";
                });

                function onChange() {
                    if (input.value != cellValue) {
                        success(moment(input.value, "YYYY-MM-DD").format("DD/MM/YYYY"));
                    } else {
                        cancel();
                    }
                }

                //submit new value on blur or change
                input.addEventListener("change", onChange);
                input.addEventListener("blur", onChange);

                //submit new value on enter
                input.addEventListener("keydown", function (e) {
                    if (e.keyCode == 13) {
                        onChange();
                    }

                    if (e.keyCode == 27) {
                        cancel();
                    }
                });

                return input;
            };

            var actWins = function (cell, formatterParams, onRendered) {
                return "Wins";
            };

            var table = new Tabulator("#rt", {
                data: tableData,
                dataEdited: function (data) {
                    //console.log(data);
                },
                cellEdited: function (cell) {
                    var cid = cell.getRow().getData().id;
                    var cvalue = cell.getValue();
                    var cfield = cell.getColumn().getField();
                    console.log(cfield + "=" + cid + "=" + cvalue);

                    $.ajax({
                        url: "data.asmx/updateticket?field=" + cfield + "&id=" + cid + "&value=" + cvalue, success: function (result) {
                            //alert('Success');
                        }, error: function (XMLHttpRequest, textStatus, error) {
                            alert("AJAX error: " + textStatus + "; " + error);
                        }
                    });
                },
                columns: [
                    { title: "ID", field: "RaffleTicket_ID", visible: false },
                    { title: "Raffle", field: "Raffle_ID", visible: false },
                    { title: "Ticket", field: "TicketNumber" },
                    { title: "Purchaser", field: "Purchaser", editor: "input" },
                    { title: "Detail", field: "Detail", editor: "input" },
                    { title: "Email", field: "EmailAddress", editor: "input" },
                    { title: "Mobile", field: "Mobile", editor: "input" },
                    { title: "Paid", field: "Paid", editor: "input" },
                    { title: "Payment Detail", field: "PaymentDetail", editor: "input" },
                    { title: "Notes", field: "Notes", editor: "input" },
                    { title: "Greeting", field: "Greeting", editor: "input" },
                    { title: "Split Ticket", field: "SplitTicket", editor: "input" },
                    { title: "Taken", field: "Taken", editor: dateEditor },
                    { title: "On Behalf Of", field: "OnBehalfOf", editor: "input" },
                    { title: "GUID", field: "GUID" },
                    {
                        title: "Wins", formatter: actWins, cellClick: function (e, cell) {
                            id = cell.getRow().getData().RaffleTicket_ID;

                            $.ajax({
                                dataType: 'html', // what type of data do we expect back from the server
                                url: "data.aspx?mode=Get_Ticket_Wins&raffleticket_id=" + id, success: function (result) {
                                    $("#div_items").html(result);
                                }
                            });

                            $("#dialog_items").dialog({
                                resizable: false,
                                //height: 700,
                                width: mywidth,
                                modal: true,
                                position: { my: "centre", at: "centre", of: window }
                            });
                        }
                    }
                    /*
                    { title: "Winner Status", field: "WinnerStatus", editor: "input" },
                    { title: "Winner Response", field: "WinnerResponse", editor: "input" },
                    { title: "Winner Note", field: "WinnerNote", editor: "input" }
                    */
                ]
            });

            $('body').on('click', '.edit', function () {
                mode = $(this).text();
                $("#dialog_Wins").find(':input').val(''); //clear all fields
                if (mode == "Add") {
                    itemid = 'tr_new';
                } else {
                    tr = $(this).closest('tr');
                    itemid = $(tr).attr("id");
                    
                    $('#draw').val($(tr).find('td').eq(0).text());
                    $('#drawndate').val($(tr).find('td').eq(1).text());
                    $('#status').val($(tr).find('td').eq(2).text());
                    $('#notes').val($(tr).find('td').eq(3).text());
                }

                $("#dialog_Wins").dialog({
                    resizable: false,
                    //height: 700,
                    width: mywidth - 100,
                    modal: true,
                    position: { my: "top", at: "centre" }
                });

                var myButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        if (mode == "Add") {
                            $('#tab_Wins tbody').append('<tr><td></td><td></td><td></td><td></td><td><span class="edit">Edit</td></tr>');
                            tr = $('#tab_Wins tbody tr:last');
                        }
                        //tr.find(':input').val('');

                        draw = $('#draw').val();
                        drawndate = $('#drawndate').val();
                        status = $('#status').val();
                        notes = $('#notes').val();
 
                        $(tr).find('td').eq(0).text(draw);
                        $(tr).find('td').eq(1).text(drawndate);
                        $(tr).find('td').eq(2).text(status);
                        $(tr).find('td').eq(3).text(notes);

                        $(this).dialog("close");
                        var arForm = [{ "name": "rafflewinner_id", "value": itemid }, { "name": "raffleticket_id", "value": id }, { "name": "draw", "value": draw }, { "name": "drawndate", "value": drawndate }, { "name": "status", "value": status }, { "name": "notes", "value": notes }];
                        var formData = JSON.stringify({ formVars: arForm });

                        $.ajax({
                            type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                            contentType: "application/json; charset=utf-8",
                            url: 'posts.asmx/update_ticket_winner', // the url where we want to POST
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
                     }
                }

                if (mode != 'Add') {
                    myButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this win?")) {
                            $(tr).remove();
  
                            $(this).dialog("close");
                            var arForm = [{ "name": "rafflewinner_id", "value": itemid }];
                            var formData = JSON.stringify({ formVars: arForm });
                            $.ajax({
                                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                contentType: "application/json; charset=utf-8",
                                url: 'posts.asmx/delete_ticket_winner', // the url where we want to POST
                                data: formData,
                                dataType: 'json', // what type of data do we expect back from the server
                                //success: function (result) {
                                //    window.location.href = 'default.aspx';
                                //},
                                error: function (xhr, status) {
                                    alert("An error occurred: " + status);
                                }
                            });
                        }
                    }
                }
                $("#dialog_Wins").dialog('option', 'buttons', myButtons);
            })

        });

        <%= tabledata %>


</script>

</head>
<body>
    <form id="form1" runat="server">

        <div id="rt"></div>
        <div id="dialog_items" title="Wins" style="display: none" class="form-horizontal">
            <div id="div_items"></div>
        </div>
        <div id="dialog_Wins" title="Wins" style="display: none" class="form-horizontal">
            <table>
                <thead></thead>
                <tbody>
                    <tr>
                        <td>Draw</td>
                        <td>
                            <input type="number" style="text-align: right" id="draw" name="draw" /></td>
                        </tr>
                    <tr>
                        <td>Date</td>
                        <td>
                            <input  id="drawndate" name="drawndate" /></td>
                        </tr>
                    <tr>
                        <td>Status</td>
                        <td>
                            <select id="status" name="status">
                                <option></option>
                                <option>Winner</option>
                                <option>Notified</option>
								<option>Received</option>
                                <option>Ordered</option>
                                <option>Collected</option>
                                <option>Invoiced</option>
                                <option>Paid</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Notes</td>
                        <td>
                            <textarea id="notes" name="notes"></textarea></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
