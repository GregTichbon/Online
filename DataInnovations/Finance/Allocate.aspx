<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Allocate.aspx.cs" Inherits="DataInnovations.Finance.Allocate" %>

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

        var dritemtypes = '<option gst="1">Asset</option>' + 
                            '<option gst="0">Bank Fee</option>' + 
                            '<option gst="1">Business Expenses</option>' + 
                            '<option gst="0">Drawings</option>' + 
                            '<option gst="0">GST</option>' + 
                            '<option gst="0">GST Penalty</option>' + 
                            '<option gst="1">Hosting</option>' + 
                            '<option gst="0">Investment</option>' + 
                            '<option gst="0">Loan</option>' + 
                            '<option gst="0">Loan Repayment</option>' + 
                            '<option gst="0">Opening Balance</option>' + 
                            '<option gst="0">PAYE</option>' + 
                            '<option gst="1">Services (On charged)</option>' + 
                            '<option gst="0">Sponsorship</option>' + 
                            '<option gst="1">Stock</option>' + 
                            '<option gst="0">Tax</option>' + 
                            '<option gst="1">To be specified</option>' + 
                            '<option gst="0">Wages</option>'; 

        var critemtypes = '<option gst="1">Asset Sale</option>' +
                            '<option gst="0">GST</option>' +
                            '<option gst="1">Hosting</option>' +
                            '<option gst="0">Interest</option>' +
                            '<option gst="1">Invoice</option>' +
                            '<option gst="1">Invoice (Work)</option>' +
                            '<option gst="0">Loan</option>' +
                            '<option gst="0">Loan Repayment</option>' +
                            '<option gst="1">Opening Balance</option>' +
                            '<option gst="0">Tax Refund</option>' +
                            '<option gst="1">To be specified</option>' +
                            '<option gst="0">Transfer</option>';

        $(document).ready(function () {

            mywidth = $(window).width() * .95;
            if (mywidth > 1200) {
                mywidth = 1200;
            }

            $(".select").click(function () {
                transaction_tr = this;
                id = $(this).attr("id");
                fullamount = $(this).find('td').eq(6).text();
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=Get_Finance_Transaction_Items&transaction_id=" + id, success: function (result) {
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
                    $('#description').val($(tr).find('td').eq(0).text());
                    $('#otherparty').val($(tr).find('td').eq(1).text());
                    crdr = $(transaction_tr).find('td').eq(1).text();
                    if (crdr == 'CR') {
                        $("#type").empty().append(critemtypes);
                    } else {
                        $("#type").empty().append(dritemtypes);
                    }
                    $('#type').val($(tr).find('td').eq(2).text());
                    $('#invoice').val($(tr).find('td').eq(3).text());
                    $('#amount').val($(tr).find('td').eq(4).text());
                    $('#gst').val($(tr).find('td').eq(5).text());
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

                        description = $('#description').val();
                        otherparty = $('#otherparty').val();
                        type = $('#type').val();
                        invoice = $('#invoice').val();
                        amount = $('#amount').val();
                        gst = $('#gst').val();

                        $(tr).find('td').eq(0).text(description);
                        $(tr).find('td').eq(1).text(otherparty);
                        $(tr).find('td').eq(2).text(type);
                        $(tr).find('td').eq(3).text(invoice);
                        $(tr).find('td').eq(4).text(parseFloat(amount).toFixed(2));
                        $(tr).find('td').eq(5).text(parseFloat(gst).toFixed(2));

                        totalamount = 0;
                        $('#tab_allocate tbody tr').each(function () {
                            totalamount += parseFloat($(this).find('td').eq(4).text());
                        });
                        totalamount = totalamount.toFixed(2);
                        $('#tab_allocate tfoot tr').find('th').eq(0).text(totalamount);
                        $('#' + id).find('td').eq(7).text(totalamount);

                        totalgst = 0;
                        $('#tab_allocate tbody tr').each(function () {
                            totalgst += parseFloat($(this).find('td').eq(5).text());
                        });
                        totalgst = totalgst.toFixed(2);

                        $('#tab_allocate tfoot tr').find('th').eq(1).text(totalgst);
                        
                        if (fullamount == totalamount) {
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

                        var arForm = [{ "name": "Transactions_Items_ID", "value": itemid }, { "name": "Transactions_ID", "value": id }, { "name": "description", "value": description }, { "name": "otherparty", "value": otherparty }, { "name": "type", "value": type }, { "name": "invoice", "value": invoice }, { "name": "amount", "value": amount }, { "name": "gst", "value": gst }];
                        var formData = JSON.stringify({ formVars: arForm });

                        $.ajax({
                            type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                            contentType: "application/json; charset=utf-8",
                            url: 'posts.asmx/update_Finance_Transaction_Items', // the url where we want to POST
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
                                url: 'posts.asmx/delete_Finance_Transaction_Items', // the url where we want to POST
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
                //accountclass = $("#selectaccount").val();
                $('.select').each(function () {
                    //if (($(this).hasClass(accountclass) || accountclass == 'All') && $(this).hasClass(allocatedclass)) {
                    if (($(this).hasClass(allocatedclass))) {
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
        Show:
        <select id="selectallocated">
            <option value="unallocated">Unallocated</option>
            <option value="allocated">Allocated</option>
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
                        <td>Description</td>
                        <td>
                            <textarea id="description" name="description" rows="4"></textarea></td>
                    </tr>
                    <tr>
                        <td>Other party</td>
                        <td><input id="otherparty" name="otherparty" /></td>
                    </tr>
                    <tr>
                        <td>Type</td>
                        <td><select id="type" name="type">

                            </select></td>
                    </tr>
                    <tr>
                        <td>Invoice</td>
                      <td><input id="invoice" name="invoice" /></td>
                    </tr>
                    <tr>
                        <td>Amount</td>
                        <td>
                            <input style="text-align: right" id="amount" name="amount" /></td>
                    </tr>
                    <tr>
                        <td>GST</td>
                        <td>
                            <input style="text-align: right" id="gst" name="gst" /> <input id="calculategst" type="button" value="Calculate" /></td>
                    </tr>
                    
                    <tr>
                        <td>Note</td>
                        <td>
                            <textarea id="note" name="note"></textarea></td>
                    </tr>

                </tbody>
            </table>
        </div>
    </form>
</body>
</html>

