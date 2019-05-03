<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Allocate.aspx.cs" Inherits="DataInnovations.Accounts.Allocate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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

        .allocated {
            display: none;
        }
    </style>
    <script type="text/javascript">

        var mywidth;

        $(document).ready(function () {

            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                mywidth = 800;
            }

            $(".select").click(function () {
                transaction_tr = this;
                id = $(this).attr("id");
                sign = $(this).find('td').eq(7).text().substring(0, 1);
                fullamount = $(this).find('td').eq(7).text();
                if (sign != "-") {
                    sign = "";
                }
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=Get_Accounts_Transaction_Items&transaction_id=" + id, success: function (result) {
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
            });

            $('body').on('click', '.edit', function () {
                mode = $(this).text();
                $("#dialog_allocate").find(':input').val(''); //clear all fields
                if (mode == "Add") {
                    itemid = 'tr_new';
                    balance = fullamount - $('#tab_allocate tfoot tr').find('th').eq(0).text();
                    $('#amount').val(balance.toFixed(2));
                } else {
                    tr = $(this).closest('tr');
                    itemid = $(tr).attr("id");
                    $('#area').val($(tr).find('td').eq(0).text());
                    $('#note').val($(tr).find('td').eq(1).text());
                    $('#amount').val($(tr).find('td').eq(2).text());
                }

                $("#dialog_allocate").dialog({
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
                            $('#tab_allocate tbody').append('<tr><td></td><td></td><td style="text-align:right"></td><td><span class="edit">Edit</td></tr>');
                            tr = $('#tab_allocate tbody tr:last');
                        }
                        //tr.find(':input').val('');

                        area = $('#area').val();
                        note = $('#note').val();
                        amount = $('#amount').val();
                        if (amount.substring(0, 1) != sign) {
                            amount = sign + amount;
                        }

                        $(tr).find('td').eq(0).text(area);
                        $(tr).find('td').eq(1).text(note);
                        $(tr).find('td').eq(2).text(parseFloat(amount).toFixed(2));

                        total = 0;
                        $('#tab_allocate tbody tr').each(function () {
                            total += parseFloat($(this).find('td').eq(2).text());
                        });
                        total = total.toFixed(2);

                        $('#tab_allocate tfoot tr').find('th').eq(0).text(total);
                        $('#' + id).find('td').eq(8).text(total);

                        if (fullamount == total) {
                            $(transaction_tr).removeClass("unallocated").addClass("allocated");
                        } else {
                            $(transaction_tr).removeClass("allocated").addClass("unallocated");
                        }
                        allocatedclass = $("#selectallocated").val();
                        accountclass = $("#selectaccount").val();

                        if (($(transaction_tr).hasClass(accountclass) || accountclass == 'All') && $(transaction_tr).hasClass(allocatedclass)) {
                            $(this).show();
                        } else {
                            $(this).hide();
                        }
                        //showhide(); //this might be slow

                        $(this).dialog("close");
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
                        if (fullamount - $('#tab_allocate tfoot tr').find('th').eq(0).text() == 0) {
                            $("#dialog_items").dialog("close");
                        }

                    }
                }

                if (mode != 'Add') {
                    myButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this transaction?")) {
                            $(tr).remove();
                            total = 0;
                            $('#tab_allocate tbody tr').each(function () {
                                total += parseFloat($(this).find('td').eq(2).text());
                            });
                            total = total.toFixed(2);

                            $('#tab_allocate tfoot tr').find('th').eq(0).text(total);
                            $('#' + id).find('td').eq(8).text(total);
                            $(this).dialog("close");
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
                        }
                    }
                }
                $("#dialog_allocate").dialog('option', 'buttons', myButtons);
            })

            $("#selectallocated").change(function () {
                showhide()
            });

            $("#selectaccount").change(function () {
                showhide()
            });

            function showhide() {
                allocatedclass = $("#selectallocated").val();
                accountclass = $("#selectaccount").val();
                $('.select').each(function () {
                    if (($(this).hasClass(accountclass) || accountclass == 'All') && $(this).hasClass(allocatedclass)) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                })
            }

        }); //document.ready



    </script>

</head>
<body>
    <form id="form1" runat="server">
        Show: <select id="selectallocated">
            <option value="unallocated">Unallocated</option>
            <option value="allocated">Allocated</option>
        </select>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id="selectaccount">
            <option value="All">All</option>
            <option value="D5">ANZ - Credit Card</option>
            <option value="D1">ANZ - Credit Card - Greg</option>
            <option value="D2">ANZ - Credit Card - Judy</option>
            <option value="D3">ANZ - General</option>
            <option value="D4">ANZ - Family Trust</option>
            <option value="J">Card - Judy</option>
            <option value="G">Card - Greg</option>
        </select>
        <% = html_transactions %>
        <div id="dialog_items" title="Allocate" style="display: none" class="form-horizontal">
            <div id="div_items"></div>
        </div>
        <div id="dialog_allocate" title="Allocate" style="display: none" class="form-horizontal">
            <table>
                <thead></thead>
                <tbody>
                    <tr>
                        <td>Area</td>
                        <td>
                            <select id="area" name="area">
                                <option></option>
                                <option>Personal</option>
                                <option>Reimbursment</option>
                                <option>Totara Property Rentals</option>
                                <option>Tichbon/Kumeroa Family Trust</option>
                                <option>Koha (Tax deductible)</option>
                                <option>Transfer</option>
                                <option>Income (To be declared)</option>
                                <option>Financial Charge (To be claimed)</option>
                                <option>Tax</option>
                                <option>Opening Balance</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Note</td>
                        <td>
                            <textarea id="note" name="note"></textarea></td>
                    </tr>
                    <tr>
                        <td>Amount</td>
                        <td>
                            <input style="text-align: right" id="amount" name="amount" /></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
