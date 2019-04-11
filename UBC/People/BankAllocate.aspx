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
            display:none;
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

                $("#dialog-kiwibank1").dialog({
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
