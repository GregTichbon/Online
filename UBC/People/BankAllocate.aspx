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
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=getkiwibanktransaction1&transaction_id=" + $(this).parent().parent().prop('id').substring(13), success: function (result) {
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
                    $('#dd_othertransactions_transaction_id').val('othertransaction_new');
                } else {
                    tr = $(this).closest('tr');
                    $('#dd_othertransactions_transaction_id').val($(tr).attr('id'));
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
                        othertransaction_id = $('#dd_othertransactions_transaction_id').val();
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
                       //console.log(arForm);
                        var formData = JSON.stringify({ formVars: arForm });
                        //alert(formData);
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
                                    $(tr).attr('id', result.d.id);
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
                            $(tr).remove();
                            $(this).dialog("close");
                            othertransaction_id = $('#dd_othertransactions_transaction_id').val();
                            var arForm = [{ "name": "othertransaction_id", "value": othertransaction_id }];
                            //console.log(arForm);
                            var formData = JSON.stringify({ formVars: arForm });
                            //alert(formData);
                            $.ajax({
                                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                contentType: "application/json; charset=utf-8",
                                url: 'posts.asmx/delete_othertransaction', // the url where we want to POST
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
                $("#dialog_othertransactions").dialog('option', 'buttons', othertransactionButtons);
            });



            $('body').on('click', '.persontransaction', function () {
                mode = $(this).text();
                $("#dialog_transactions").find(':input').val(''); //clear all fields
                if (mode == "Add") {
                    $('#dd_transactions_person_transaction_id').val('transactions_new');
                } else {
                    alert('Edit is currently not done');
                    /*
                                        tr = $(this).closest('tr');
                    
                                        $('#dd_transactions_person_transaction_id').val($(tr).attr('id'));
                                        $('#dd_transactions_person_id').val($(tr).find('td').eq(0).attr('person_id'));
                                        $('#tb_transactions_date').val($(tr).find('td').eq(1).text());
                                        $('#dd_transactions_system').val($(tr).find('td').eq(2).text());
                                        $('#dd_transactions_code').val($(tr).find('td').eq(3).text());
                                        $('#dd_transactions_event_id').val($(tr).find('td').eq(4).attr('event_id'));
                                        $('#tb_transactions_amount').val($(tr).find('td').eq(5).text());
                                        $('#tb_transactions_note').val($(tr).find('td').eq(6).text());
                                        banklinked = $(tr).find('td').eq(8).text();
                                        if (banklinked == '-') {
                                            $('#div_banked').hide();
                    
                                        } else {
                                            $('#div_banked').show();
                                            $('#div_bankeddate').text($(tr).find('td').eq(7).text());
                                        }
                    */
                }



                $("#dialog_transactions").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true,
                    position: { my: "top", at: "centre top" }
                });

                var transactionButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        if (mode == "Add") {
                            tr = $('#tab_transactions > tbody tr:first').clone();
                            tr.find(':input').val('');
                            $('#tab_transactions > tbody').append(tr);
                        }


                        person_transaction_id = $('#dd_transactions_person_transaction_id').val();
                        person = $('#dd_transactions_person_id option:selected').text();
                        person_id = $('#dd_transactions_person_id').val();
                        //date = $('#tb_transactions_date').val();
                        system = $('#dd_transactions_system').val();
                        code = $('#dd_transactions_code').val();
                        event = $('#dd_transactions_event_id option:selected').text();
                        event_id = $('#dd_transactions_event_id').val();
                        amount = $('#tb_transactions_amount').val();
                        note = $('#tb_transactions_note').val();
                        banktransaction_id = $('#banktransaction_id').text();

                        /*
                                                $(tr).find('td').eq(0).text(person);
                                                $(tr).find('td').eq(0).attr('person_id', person_id);
                                                $(tr).find('td').eq(1).text(date);
                                                $(tr).find('td').eq(2).text(system);
                                                $(tr).find('td').eq(3).text(code);
                                                $(tr).find('td').eq(4).text(event);
                                                $(tr).find('td').eq(4).attr('event_id', event_id);
                                                $(tr).find('td').eq(5).text(amount);
                                                $(tr).find('td').eq(6).text(note);
                        */
                        $(this).dialog("close");

                        var arForm = [{ "name": "person_transaction_id", "value": person_transaction_id }, { "name": "person_id", "value": person_id }, { "name": "date", "value": null }, { "name": "system", "value": system }, { "name": "code", "value": code }, { "name": "event_id", "value": event_id }, { "name": "amount", "value": amount }, { "name": "note", "value": note }, { "name": "banktransaction_id", "value": banktransaction_id }]; //, { "name": "banked", "value": banked }]; , { "name": "date", "value": date }
                        //console.log(arForm);
                        var formData = JSON.stringify({ formVars: arForm });
                        //alert(formData);
                        $.ajax({
                            type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                            contentType: "application/json; charset=utf-8",
                            url: 'posts.asmx/update_person_transaction', // the url where we want to POST
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

                if (mode != 'Add') {
                    transactionButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this transaction?")) {
                            $(tr).remove();

                            $(this).dialog("close");
                            person_transaction_id = $('#dd_transactions_person_transaction_id').val();
                            var arForm = [{ "name": "person_transaction_id", "value": person_transaction_id }];
                            //console.log(arForm);
                            var formData = JSON.stringify({ formVars: arForm });
                            //alert(formData);
                            $.ajax({
                                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                contentType: "application/json; charset=utf-8",
                                url: 'posts.asmx/delete_person_transaction', // the url where we want to POST
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
                $("#dialog_transactions").dialog('option', 'buttons', transactionButtons);
            })

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
            <div id="dialog_transactions" title="Maintain Transactions" style="display: none" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_transactions_person_transaction_id">ID</label>
                    <div class="col-sm-8">
                        <input id="dd_transactions_person_transaction_id" name="dd_transactions_person_transaction_id" type="text" class="form-control" readonly="readonly" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_transactions_person_id">Person</label>
                    <div class="col-sm-8">
                        <select id="dd_transactions_person_id" name="dd_transactions_person_id" class="form-control">
                            <option></option>
                            <%= people %>
                        </select>
                    </div>
                </div>
                <!--
                <div class="form-group">
                    <label for="tb_transactions_date" class="control-label col-sm-4">
                        Date
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group standarddate">
                            <input id="tb_transactions_date" name="tb_transactions_date" placeholder="eg: 23 Jun 1985" type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                -->
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_transactions_system">System</label>
                    <div class="col-sm-8">
                        <select id="dd_transactions_system" name="dd_transactions_system" class="form-control">
                            <%= Generic.Functions.populateselect(transactions_system, "","None") %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_transactions_code">Code</label>
                    <div class="col-sm-8">
                        <select id="dd_transactions_code" name="dd_transactions_code" class="form-control">
                            <%= Generic.Functions.populateselect(transactions_code, "","None") %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_transactions_event_id">Event</label>
                    <div class="col-sm-8">
                        <select id="dd_transactions_event_id" name="dd_transactions_event_id" class="form-control">
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
                    <label class="control-label col-sm-4" for="tb_transactions_amount">Amount</label>
                    <div class="col-sm-8">
                        <input id="tb_transactions_amount" name="tb_transactions_amount" type="text" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_transactions_note">Note</label>
                    <div class="col-sm-8">
                        <input id="tb_transactions_note" name="tb_transactions_note" type="text" class="form-control" />
                    </div>
                </div>
            </div>

          <!-- DIALOG OTHER TRANSACTIONS -->
            <div id="dialog_othertransactions" title="Maintain Transactions" style="display: none" class="form-horizontal">
                 <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_othertransactions_transaction_id">ID</label>
                    <div class="col-sm-8">
                        <input id="dd_othertransactions_transaction_id" name="dd_othertransactions_transaction_id" type="text" class="form-control" readonly="readonly" />
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
                        <select id="dd_othertransactions_system" name="dd_othertransactions_system" class="form-control">
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
                        <select id="dd_othertransactions_code" name="dd_othertransactions_code" class="form-control">
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
                        <input id="tb_othertransactions_amount" name="tb_othertransactions_amount" type="text" class="form-control" />
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
