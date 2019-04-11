<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="transactions.aspx.cs" Inherits="UBC.People.transactions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/UBC.css")%>" rel="stylesheet" />


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

        var tr;
        var mode;
        var mywidth;

        $(document).ready(function () {

            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                mywidth = 800;
            }

            $('#menu').click(function () {
                window.location.href = "<%: ResolveUrl("~/default.aspx")%>";
            })

            //$('.transactionsedit').click(function () {
            $(document).on('click', '.transactionsedit', function () {  //Can edit transactions created on the fly
                mode = $(this).data('mode');
                if (mode == "add") {
                    $("#dialog-transactions").find(':input').val(''); //clear all fields
                    $('#dd_transactions_person_transaction_id').val('transactions_new');
                    /*
                    $('#dd_transactions_person_id').val('');
                    $('#tb_transactions_date').val('');
                    $('#dd_transactions_system').val('');
                    $('#dd_transactions_code').val('');
                    $('#dd_transactions_event_id').val('');
                    $('#tb_transactions_amount').val('');
                    $('#tb_transactions_note').val('');
                    $('#tb_transactions_banked').val('');
                    */
                } else {
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
                }



                $("#dialog-transactions").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true,
                    position: { my: "top", at: "centre top" }
                });

                var myButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        if (mode == "add") {
                            tr = $('#div_transactions > table > tbody tr:first').clone();
                            tr.find(':input').val('');
                            $('#div_transactions > table > tbody').append(tr);
                        }


                        person_transaction_id = $('#dd_transactions_person_transaction_id').val();
                        person = $('#dd_transactions_person_id option:selected').text();
                        person_id = $('#dd_transactions_person_id').val();
                        date = $('#tb_transactions_date').val();
                        system = $('#dd_transactions_system').val();
                        code = $('#dd_transactions_code').val();
                        event = $('#dd_transactions_event_id option:selected').text();
                        event_id = $('#dd_transactions_event_id').val();
                        amount = $('#tb_transactions_amount').val();
                        note = $('#tb_transactions_note').val();

                        $(tr).find('td').eq(0).text(person);
                        $(tr).find('td').eq(0).attr('person_id', person_id);
                        $(tr).find('td').eq(1).text(date);
                        $(tr).find('td').eq(2).text(system);
                        $(tr).find('td').eq(3).text(code);
                        $(tr).find('td').eq(4).text(event);
                        $(tr).find('td').eq(4).attr('event_id', event_id);
                        $(tr).find('td').eq(5).text(amount);
                        $(tr).find('td').eq(6).text(note);

                        $(this).dialog("close");

                        var arForm = [{ "name": "person_transaction_id", "value": person_transaction_id }, { "name": "person_id", "value": person_id }, { "name": "date", "value": date }, { "name": "system", "value": system }, { "name": "code", "value": code }, { "name": "event_id", "value": event_id }, { "name": "amount", "value": amount }, { "name": "note", "value": note }]; //, { "name": "banked", "value": banked }];
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

                if (mode != 'add') {
                    myButtons["Delete"] = function () {
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
                $("#dialog-transactions").dialog('option', 'buttons', myButtons);

            });

            $(".kbtransaction").click(function () {
                console.log($(this).attr('id').substring(4));
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=getkiwibanktransaction1&transaction_id=" + $(this).attr('id').substring(4), success: function (result) {
                        $("#kiwibank1").html(result);
                    }
                });



                $("#dialog-kiwibank1").dialog({
                    resizable: false,
                    //height: 700,
                    width: mywidth,
                    modal: true,
                    position: { my: "top", at: "centre top", of: "window" }
                });
            });

        });


    </script>
    <style type="text/css">
               
    </style>
</head>
<body>
    <div class="container" style="background-color: #FCF7EA">
        <div class="toprighticon">
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Transaction Maintenance
        </h1>
        <p>Querystring: person, event</p>

        <form id="form1" runat="server" class="form-horizontal" role="form">
            <table id="transactionstable" class="table">
                <%= html_transactions %>
            </table>


            <div id="dialog-transactions" title="Maintain Transactions" style="display: none" class="form-horizontal">

                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_transactions_person_transaction_id">ID</label>
                    <div class="col-sm-8">
                        <input id="dd_transactions_person_transaction_id" name="dd_transactions_person_transaction_id" type="text" class="form-control" readonly />
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
                <div class="form-group" id="div_banked">
                    <label for="tb_transactions_banked" class="control-label col-sm-4">
                        Banked
                    </label>
                    <div class="col-sm-8 align-text-bottom" id="div_bankeddate">
                    </div>
                </div>
            </div>

            <div id="dialog-kiwibank1" title="Kiwibank Transaction" style="display: none" class="form-horizontal">
                <div id="kiwibank1"></div>
            </div>

        </form>
    </div>



</body>
</html>

