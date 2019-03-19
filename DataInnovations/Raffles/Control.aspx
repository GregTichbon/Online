<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Control.aspx.cs" Inherits="DataInnovations.Raffles.Control" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://unpkg.com/tabulator-tables@4.2.1/dist/css/tabulator.min.css" rel="stylesheet" />
    <script type="text/javascript" src="https://unpkg.com/tabulator-tables@4.2.1/dist/js/tabulator.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.js"></script>
     
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script>
        $(document).ready(function () {
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
                { title: "On Behalf Of", field: "OnBehalfOf", editor: "input" }
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
    <script>



        

    </script>
</body>
</html>
