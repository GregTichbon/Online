<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Winners.aspx.cs" Inherits="DataInnovations.Raffles.UBC2019B.Winners" %>

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
        var myheight;
        $(document).ready(function () {

            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                mywidth = 800;
            }
            myheight = $(window).height() * .99;

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
                height: myheight,
                dataEdited: function (data) {
                    //console.log(data);
                },
                cellEdited: function (cell) {
                    var cwinnerid = cell.getRow().getData().RaffleWinner_ID;
                    var cvalue = cell.getValue();
                    var cfield = cell.getColumn().getField();
                    console.log(cfield + "=" + cwinnerid + "=" + cvalue);
                    /*
                    $.ajax({
                        url: "data.asmx/updateticket?field=" + cfield + "&id=" + cwinnerid + "&value=" + cvalue, success: function (result) {
                            //alert('Success');
                        }, error: function (XMLHttpRequest, textStatus, error) {
                            alert("AJAX error: " + textStatus + "; " + error);
                        }
                    });
                    */
                },
                columns: [
                    { title: "ID", field: "RaffleWinner_ID", visible: false },
                    { title: "Seller", field: "seller"  },
                    { title: "Identifier", field: "Identifier"  },
                    { title: "Ticket", field: "TicketNumber" },
                    { title: "Purchaser", field: "Purchaser" },
                    //{ title: "Greeting", field: "Greeting" },
                    //{ title: "Detail", field: "Detail" },
                    { title: "Email", field: "EmailAddress" },
                    { title: "Mobile", field: "mobile" },
                    {
                        title: "Status", field: "status", editor: "select", editorParams: {
                            "Winner": "Winner",
                            "Printed": "Printed",
                            "Notified": "Notified",
                            "Received": "Received",
                            "Ordered": "Ordered",
                            "Collected": "Collected",
                            "Invoiced": "Invoiced",
                            "Paid": "Paid"
                        }
                    },
                    { title: "Ticket Notes", field: "TicketNotes" },
                    { title: "Paid", field: "Paid"},
                    { title: "Payment Detail", field: "PaymentDetail"},
                    { title: "Draw", field: "Draw", editor: "input" },
                    { title: "Drawn", field: "DrawnDate", editor: "input" },
                    { title: "Response", field: "Response", editor: "input" },
                    { title: "Voucher", field: "voucher", editor: "input" },
                    { title: "Winner Notes", field: "Notes", editor: "input" }
                ]
            });
        });

        <%= tabledata %>


    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div id="rt"></div>
    </form>
</body>
</html>
