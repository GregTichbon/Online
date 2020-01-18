<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maint.aspx.cs" Inherits="DataInnovations.Raffles.Maint" %>


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
        var myheight;
        $(document).ready(function () {

            myheight = $(window).height() * .99;
            

            

            var table = new Tabulator("#rt", {
                data: tableData,
                height: myheight,
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
                    { title: "Paid", field: "Paid" },
                    { title: "Payment Detail", field: "PaymentDetail", editor: "input" },
                    { title: "Notes", field: "Notes", editor: "input" },
                    { title: "Greeting", field: "Greeting", editor: "input" },
                    /*
                    { title: "Winner Status", field: "WinnerStatus", editor: "input" },
                    { title: "Winner Response", field: "WinnerResponse", editor: "input" },
                    { title: "Winner Note", field: "WinnerNote", editor: "input" }
                    */
                ]
            });



        });

        <%= tabledata %>


    </script>

</head>
<body>
    <form id="form1" runat="server">
          <%=head %>
        <div id="rt"></div>
        
  
    </form>
</body>
</html>
