<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankAllocate.aspx.cs" Inherits="UBC.People.BankAllocate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/UBC.css")%>" rel="stylesheet" />

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
        .allocated {
            display: none;
            color: red;
        }

        .number {
            text-align: right;
        }
    </style>

    <script>
        var mywidth;

        $(document).ready(function () {

            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                mywidth = 800;
            }

            $(".transactionsview").click(function () {
                //$(this).parent().parent().prop('id').substring(13)
                tr_transaction = $(this).parent().parent();
                tr_transaction_id = $(tr_transaction).prop('id').substring(13)
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=getkiwibanktransaction1&transaction_id=" + tr_transaction_id, success: function (result) {
                        $("#kiwibank1").html(result);
                    }
                });

                $("#dialog_kiwibank1").dialog({
                    resizable: false,
                    //height: 700,
                    width: mywidth,
                    modal: true,
                    position: { my: "top", at: "centre top" }
                });
            });

            $('body').on('click', '.btn_updatenote', function () {
                //$('.btn_updatenote').click(function () {
                id = $(this).prop("id").substring(5);
                alert('To do: update kiwibank record with note for ' + id);
            })

            $('body').on('click', '.othertransaction', function () {
                mode = $(this).text();
                $("#dialog_othertransactions").find(':input').val(''); //clear all fields
                if (mode == "Add") {
                    $('#tb_othertransactions_transaction_id').val('othertransaction_new');
                    setdefaultamount();
                } else {
                    tr = $(this).closest('tr');
                    $('#tb_othertransactions_transaction_id').val($(tr).attr('id'));
                    $('#dd_othertransactions_system').val($(tr).attr('system'));
                    $('#dd_othertransactions_person_id').val($(tr).attr('person_id'));
                    $('#dd_othertransactions_code').val($(tr).find('td').eq(0).text());
                    $('#dd_othertransactions_event_id').val($(tr).attr('event_id'));
                    $('#tb_othertransactions_amount').val($(tr).find('td').eq(1).text());
                    $('#tb_othertransactions_note').val($(tr).attr('note'));
                }

                $("#dialog_othertransactions").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true,
                    position: { my: "top", at: "centre top" }
                });

                var othertransactionButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        othertransaction_id = $('#tb_othertransactions_transaction_id').val();
                        person = $('#dd_othertransactions_person_id option:selected').text();
                        person_id = $('#dd_othertransactions_person_id').val();
                        //date = $('#tb_transactions_date').val();
                        system = $('#dd_othertransactions_system').val();
                        code = $('#dd_othertransactions_code').val();
                        event = $('#dd_othertransactions_event_id option:selected').text();
                        event_id = $('#dd_othertransactions_event_id').val();
                        amount = $('#tb_othertransactions_amount').val();
                        note = $('#tb_othertransactions_note').val();
                        banktransaction_id = $('#banktransaction_id').text();   ////??????????????????????

                        $(this).dialog("close");

                        var arForm = [{ "name": "othertransaction_id", "value": othertransaction_id }, { "name": "person_id", "value": person_id }, { "name": "system", "value": system }, { "name": "code", "value": code }, { "name": "event_id", "value": event_id }, { "name": "amount", "value": amount }, { "name": "note", "value": note }, { "name": "banktransaction_id", "value": banktransaction_id }]; //, { "name": "banked", "value": banked }]; , { "name": "date", "value": date }
                        var formData = JSON.stringify({ formVars: arForm });
                        $.ajax({
                            type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                            contentType: "application/json; charset=utf-8",
                            url: 'posts.asmx/update_othertransaction', // the url where we want to POST
                            data: formData,
                            dataType: 'json', // what type of data do we expect back from the server
                            success: function (result) {
                                if (mode == 'Add') {
                                    $('#div_othertransactions > table > tbody').append('<tr><td></td><td class="number"></td><td class="othertransaction">Edit</td></tr>');
                                    tr = $('#div_othertransactions > table > tbody tr:last')
                                    $(tr).attr('id', 'othertransaction_' + result.d.id);
                                }
                                //$(tr).find('td').eq(0).text(person);
                                $(tr).attr('system', system);
                                $(tr).attr('person_id', person_id);
                                $(tr).attr('event_id', event_id);
                                $(tr).find('td').eq(0).text(code);
                                //$(tr).find('td').eq(4).text(event);
                                $(tr).find('td').eq(1).text(parseFloat(amount).toFixed(2));
                                $(tr).attr('note', note);
                                $(tr).find('td').eq(2).text('Edit');
                                total_transactions();
                            },
                            error: function (xhr, status) {
                                alert("An error occurred: " + status);
                            }
                        });
                    }
                }

                if (mode != 'Add') {
                    othertransactionButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this transaction?")) {
                            $(this).dialog("close");
                            othertransaction_id = $('#tb_othertransactions_transaction_id').val();
                            var arForm = [{ "name": "othertransaction_id", "value": othertransaction_id }];
                            var formData = JSON.stringify({ formVars: arForm });
                            $.ajax({
                                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                contentType: "application/json; charset=utf-8",
                                url: 'posts.asmx/delete_othertransaction', // the url where we want to POST
                                data: formData,
                                dataType: 'json', // what type of data do we expect back from the server
                                success: function (result) {
                                    $(tr).remove();
                                    total_transactions();
                                },
                                error: function (xhr, status) {
                                    alert("An error occurred: " + status);
                                }
                            });
                        }
                    }
                }
                $("#dialog_othertransactions").dialog('option', 'buttons', othertransactionButtons);
            }); //$('body').on('click', '.othertransaction'

 
            $('body').on('click', '.person_transaction', function () {
                mode = $(this).text();
                $("#dialog_person_transactions").find(':input').val(''); //clear all fields
                if (mode == "Add") {
                    $('#tb_person_transactions_transaction_id').val('person_transaction_new');
                     setdefaultamount();
                } else {
                    tr = $(this).closest('tr');
                    $('#tb_person_transactions_transaction_id').val($(tr).attr('id'));
                    $('#dd_person_transactions_system').val($(tr).attr('system'));
                    $('#dd_person_transactions_person_id').val($(tr).attr('person_id'));
                    $('#dd_person_transactions_code').val($(tr).find('td').eq(0).text());
                    $('#dd_person_transactions_event_id').val($(tr).attr('event_id'));
                    $('#tb_person_transactions_amount').val($(tr).find('td').eq(1).text());
                    $('#tb_person_transactions_note').val($(tr).attr('note'));
                }

                $("#dialog_person_transactions").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true,
                    position: { my: "top", at: "centre top" }
                });

                var person_transactionButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        person_transaction_id = $('#tb_person_transactions_transaction_id').val();
                        person = $('#dd_person_transactions_person_id option:selected').text();
                        person_id = $('#dd_person_transactions_person_id').val();
                        //date = $('#tb_transactions_date').val();
                        system = $('#dd_person_transactions_system').val();
                        code = $('#dd_person_transactions_code').val();
                        event = $('#dd_person_transactions_event_id option:selected').text();
                        event_id = $('#dd_person_transactions_event_id').val();
                        amount = $('#tb_person_transactions_amount').val();
                        note = $('#tb_person_transactions_note').val();
                        banktransaction_id = $('#banktransaction_id').text();   ////??????????????????????

                        $(this).dialog("close");

                        var arForm = [{ "name": "person_transaction_id", "value": person_transaction_id }, { "name": "person_id", "value": person_id }, { "name": "system", "value": system }, { "name": "code", "value": code }, { "name": "event_id", "value": event_id }, { "name": "amount", "value": amount }, { "name": "note", "value": note }, { "name": "banktransaction_id", "value": banktransaction_id }]; //, { "name": "banked", "value": banked }]; , { "name": "date", "value": date }
                        var formData = JSON.stringify({ formVars: arForm });
                        $.ajax({
                            type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                            contentType: "application/json; charset=utf-8",
                            url: 'posts.asmx/update_person_transaction', // the url where we want to POST
                            data: formData,
                            dataType: 'json', // what type of data do we expect back from the server
                            success: function (result) {
                                if (mode == 'Add') {
                                    $('#div_person_transactions > table > tbody').append('<tr><td></td><td class="number"></td><td class="person_transaction">Edit</td></tr>');
                                    tr = $('#div_person_transactions > table > tbody tr:last')
                                    $(tr).attr('id', 'person_transaction_' + result.d.id);
                                }
                                //$(tr).find('td').eq(0).text(person);
                                $(tr).attr('system', system);
                                $(tr).attr('person_id', person_id);
                                $(tr).attr('event_id', event_id);
                                $(tr).find('td').eq(0).text(code);
                                //$(tr).find('td').eq(4).text(event);
                                $(tr).find('td').eq(1).text(parseFloat(amount).toFixed(2));
                                $(tr).attr('note', note);
                                $(tr).find('td').eq(2).text('Edit');
                                total_transactions();
                            },
                            error: function (xhr, status) {
                                alert("An error occurred: " + status);
                            }
                        });
                    }
                }

                if (mode != 'Add') {
                    person_transactionButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this transaction?")) {
                            $(this).dialog("close");
                            person_transaction_id = $('#tb_person_transactions_transaction_id').val();
                            var arForm = [{ "name": "person_transaction_id", "value": person_transaction_id }];
                            var formData = JSON.stringify({ formVars: arForm });
                            $.ajax({
                                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                contentType: "application/json; charset=utf-8",
                                url: 'posts.asmx/delete_person_transaction', // the url where we want to POST
                                data: formData,
                                dataType: 'json', // what type of data do we expect back from the server
                                success: function (result) {
                                    $(tr).remove();
                                    total_transactions();
                                },
                                error: function (xhr, status) {
                                    alert("An error occurred: " + status);
                                }
                            });
                        }
                    }
                }
                $("#dialog_person_transactions").dialog('option', 'buttons', person_transactionButtons);
            }); //$('body').on('click', '.person_transaction'

            function total_transactions() {
                total_person_transactions = 0;
                $('[id^=person_transaction_]').each(function () {
                    total_person_transactions += parseFloat($(this).find('td').eq(1).text());
                })
                $(tr_transaction).find('td').eq(4).text(total_person_transactions.toFixed(2));

                total_other_transactions = 0;
                $('[id^=othertransaction_]').each(function () {
                    total_other_transactions += parseFloat($(this).find('td').eq(1).text());
                })

                $(tr_transaction).find('td').eq(5).text(total_other_transactions.toFixed(2));

                if (parseFloat($(tr_transaction).find('td').eq(3).text()) == total_other_transactions) {
                    $(tr_transaction).addClass('allocated');
                    $("#dialog_kiwibank1").dialog("close");
                } else {
                    $(tr_transaction).removeClass('allocated');
                }
            }

            function setdefaultamount() {
                transaction_amount = parseFloat($(tr_transaction).find('td').eq(3).text());
                transaction_person = parseFloat($(tr_transaction).find('td').eq(4).text());
                transaction_other = parseFloat($(tr_transaction).find('td').eq(5).text());
                $('#tb_othertransactions_amount').val((transaction_amount - transaction_person - transaction_other).toFixed(2));
            }

            $('#menu').click(function () {
                window.location.href = "<%: ResolveUrl("~/default.aspx")%>";
            })

            $('#toggleallocated').click(function () {
                $('.allocated').toggle();
            })

        });
    </script>
</head>
<body>
    <div class="container" style="background-color: #FCF7EA">
        <div class="toprighticon">
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Bank Allocation
        </h1>
        <form id="form1" runat="server">
            <input type="button" id="toggleallocated" class="btn btn-info" value="Show/Hide allocated" />
            <table id="transactionstable" class="table">
                <%= html_transactions %>
            </table>

            <div id="dialog_kiwibank1" title="Kiwibank Transaction" style="display: none" class="form-horizontal">
                <div id="kiwibank1"></div>
            </div>
            <!-- DIALOG PERSON TRANSACTIONS -->
            <div id="dialog_person_transactions" title="Maintain People Transactions" style="display: none" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_person_transactions_person_transaction_id">ID</label>
                    <div class="col-sm-8">
                        <input id="dd_person_transactions_person_transaction_id" name="dd_person_transactions_person_transaction_id" type="text" class="form-control" readonly="readonly" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_person_transactions_person_id">Person</label>
                    <div class="col-sm-8">
                        <select id="dd_person_transactions_person_id" name="dd_person_transactions_person_id" class="form-control">
                            <option></option>
                            <%= people %>
                        </select>
                    </div>
                </div>
                <!--
                <div class="form-group">
                    <label for="tb_person_transactions_date" class="control-label col-sm-4">
                        Date
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group standarddate">
                            <input id="tb_person_transactions_date" name="tb_person_transactions_date" placeholder="eg: 23 Jun 1985" type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                -->
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_person_transactions_system">System</label>
                    <div class="col-sm-8">
                        <select id="dd_person_transactions_system" name="dd_person_transactions_system" class="form-control" required="required">
                            <%= Generic.Functions.populateselect(transactions_system, "","None") %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_person_transactions_code">Code</label>
                    <div class="col-sm-8">
                        <select id="dd_person_transactions_code" name="dd_person_transactions_code" class="form-control" required="required">
                            <%= Generic.Functions.populateselect(transactions_code, "","None") %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_person_transactions_event_id">Event</label>
                    <div class="col-sm-8">
                        <select id="dd_person_transactions_event_id" name="dd_person_transactions_event_id" class="form-control">
                            <option></option>
                            <option value="107">John Trophy Regatta, Waitara</option>
                            <option value="148">Karapiro Christmas Regatta</option>
                            <option value="150">Hawkes Bay Cup Regatta / Clive</option>
                            <option value="179">North Island Club Champs / Cambridge Town Cup - Karapiro</option>
                            <option value="250">North Island Secondary School Championships</option>
                            <option value="274">Maadi</option>
                            <option value="275">Pre-Paid Event</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_person_transactions_amount">Amount</label>
                    <div class="col-sm-8">
                        <input id="tb_person_transactions_amount" name="tb_person_transactions_amount" type="text" class="form-control" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_person_transactions_note">Note</label>
                    <div class="col-sm-8">
                        <input id="tb_person_transactions_note" name="tb_person_transactions_note" type="text" class="form-control" />
                    </div>
                </div>
            </div>

          <!-- DIALOG OTHER TRANSACTIONS -->
            <div id="dialog_othertransactions" title="Maintain Other Transactions" style="display: none" class="form-horizontal">
                 <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_othertransactions_transaction_id">ID</label>
                    <div class="col-sm-8">
                        <input id="tb_othertransactions_transaction_id" name="tb_othertransactions_transaction_id" type="text" class="form-control" readonly="readonly" />
                    </div>
                </div>
                <!--
                <div class="form-group">
                    <label for="tb_othertransactions_date" class="control-label col-sm-4">
                        Date
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group standarddate">
                            <input id="tb_othertransactions_date" name="tb_othertransactions_date" placeholder="eg: 23 Jun 1985" type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                -->
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_othertransactions_system">System</label>
                    <div class="col-sm-8">
                        <select id="dd_othertransactions_system" name="dd_othertransactions_system" class="form-control" required="required">
                            <%= Generic.Functions.populateselect(transactions_system, "","None") %>
                        </select>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_othertransactions_person_id">Person</label>
                    <div class="col-sm-8">
                        <select id="dd_othertransactions_person_id" name="dd_othertransactions_person_id" class="form-control">
                            <option></option>
                            <%= people %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_othertransactions_code">Code</label>
                    <div class="col-sm-8">
                        <select id="dd_othertransactions_code" name="dd_othertransactions_code" class="form-control" required="required">
                            <%= Generic.Functions.populateselect(transactions_code, "","None") %>
                        </select>
                    </div>
                </div>
                 <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_othertransactions_event_id">Event</label>
                    <div class="col-sm-8">
                        <select id="dd_othertransactions_event_id" name="dd_othertransactions_event_id" class="form-control">
                            <option></option>
                            <option value="107">John Trophy Regatta, Waitara</option>
                            <option value="148">Karapiro Christmas Regatta</option>
                            <option value="150">Hawkes Bay Cup Regatta / Clive</option>
                            <option value="179">North Island Club Champs / Cambridge Town Cup - Karapiro</option>
                            <option value="250">North Island Secondary School Championships</option>
                            <option value="274">Maadi</option>
                            <option value="275">Pre-Paid Event</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_othertransactions_amount">Amount</label>
                    <div class="col-sm-8">
                        <input id="tb_othertransactions_amount" name="tb_othertransactions_amount" type="text" class="form-control" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_othertransactions_note">Note</label>
                    <div class="col-sm-8">
                        <input id="tb_othertransactions_note" name="tb_othertransactions_note" type="text" class="form-control" />
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
