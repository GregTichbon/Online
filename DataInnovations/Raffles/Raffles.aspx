<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Raffles.aspx.cs" Inherits="DataInnovations.Raffles.Raffles" %>

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

            var actControl = function (cell, formatterParams, onRendered) {
                return "Control";
            }
            var actPurchase = function (cell, formatterParams, onRendered) {
                return "Purchase";
            };

            var actCommunicate = function (cell, formatterParams, onRendered) {
                return "Communicate";
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
                    //console.log(cfield + "=" + cid + "=" + cvalue);
                    
                    $.ajax({
                        url: "data.asmx/updateraffle?field=" + cfield + "&id=" + cid + "&value=" + cvalue, success: function (result) {
                            //alert('Success');
                        }, error: function (XMLHttpRequest, textStatus, error) {
                            alert("AJAX error: " + textStatus + "; " + error);
                        }
                    });
                  



                },
                columns: [
                    { title: "ID", field: "Raffle_ID" },
                    { title: "Name", field: "Name", editor: "input" },
                    { title: "Identifier", field: "Identifier", editor: "input" },
                    { title: "Seller", field: "Seller", editor: "input" },
                    { title: "Notes", field: "Notes", editor: "textarea" },
                    { title: "Guid", field: "Guid", visible: false },
                    { title: "First Ticket", field: "FirstTicket", editor: "input" },
                    { title: "Last Ticket", field: "LastTicket", editor: "input" },
                    {
                        title: "Control", formatter: actControl, cellClick: function (e, cell) {
                            var guid = cell.getRow().getData().Guid;
                            window.open("control.aspx?id=" + guid, "RaffleWindow");
                        }
                    },
                    {
                        title: "Communicate", formatter: actCommunicate, cellClick: function (e, cell) {
                            var guid = cell.getRow().getData().Guid;
                            window.open("communicate.aspx?id=" + guid, "RaffleWindow");
                        }
                    },
                    {
                        title: "Purchase", formatter: actPurchase, cellClick: function (e, cell) {
                            var guid = cell.getRow().getData().Guid;
                            window.open("UBC2019A/ticket.aspx?id=" + guid, "RaffleWindow");
                        }
                    },
                    { title: "Open Date", field: "OpenDate", editor: dateEditor },
                    { title: "Close Date", field: "CloseDate", editor: dateEditor },
                    { title: "Detail", field: "Detail", editor: "input" },
                    { title: "Columns", field: "Columns", editor: "input" },
                    { title: "Bank Account", field: "BankAccount", editor: "input" },
                    { title: "Mobile To Text", field: "MobileToText", editor: "input" },
                    { title: "Named", field: "Named", editor: "input" }


                ]
            });

        });
        /*
        var tableData = [{id:7, Raffle_ID:"7", Name:"Union Boat Club's", OpenDate:"", CloseDate:"", Detail:"North Island", Identifier:"Black", Seller:"Neo", Guid:"36131e48-888c-4ec3-92a8-3e5e03128c95", FirstTicket:"26", LastTicket:"50", Columns:"5", BankAccount:"06-0996-0956968-00"},{id:6, Raffle_ID:"6", Name:"Union Boat Club's North Island Secondary Schools and Maadi Cup 2019 - Meat Raffle (Black Card) for Whanganui Cullinane and Girls' College", OpenDate:"", CloseDate:"", Detail:"North Island Secondary Schools and Maadi Cup 2019 - Black Meat Raffle
", Identifier:"Black", Seller:"Tomasi", Guid:"2d0df393-7394-4561-9ca2-b6965ef8b237", FirstTicket:"1", LastTicket:"25", Columns:"5", BankAccount:"06-0996-0956968-00"},{id:5, Raffle_ID:"5", Name:"Union Boat Club's North Island Secondary Schools and Maadi Cup 2019 - Meat Raffle (Yellow Card) for Whanganui Cullinane and Girls' College", OpenDate:"19/02/2019 12:00:00 AM", CloseDate:"", Detail:"North Island Secondary Schools and Maadi Cup 2019 - Yellow Meat Raffle
", Identifier:"Yellow", Seller:"Greg", Guid:"914f2f25-c2b5-4268-a6d2-1ba82558def4", FirstTicket:"1", LastTicket:"50", Columns:"10", BankAccount:"06-0996-0956968-00"},{id:3, Raffle_ID:"3", Name:"????????????????????", OpenDate:"", CloseDate:"", Detail:"??????????????????????????", Identifier:"", Seller:"", Guid:"ece4d9dd-ac91-416f-a84f-78663c6d9765", FirstTicket:"", LastTicket:"", Columns:"", BankAccount:"06-0996-0956968-00"},{id:2, Raffle_ID:"2", Name:"Maadi Cup 2018 Outdoor Table", OpenDate:"5/03/2018 12:00:00 AM", CloseDate:"5/03/2018 12:00:00 AM", Detail:"Maadi Cup 2018 Outdoor Table 250 tickets @ $2.00", Identifier:"", Seller:"", Guid:"8938f231-7878-4172-8bb6-6a40cf0a8862", FirstTicket:"", LastTicket:"", Columns:"", BankAccount:"06-0996-0956968-00"},{id:1, Raffle_ID:"1", Name:"Maadi Cup 2018", OpenDate:"1/02/2018 12:00:00 AM", CloseDate:"1/02/2018 12:00:00 AM", Detail:"Maadi Cup 2018 - $20.00", Identifier:"", Seller:"", Guid:"3309cff9-3bf6-4e7f-9cb2-77924d973a55", FirstTicket:"", LastTicket:"", Columns:"", BankAccount:"06-0996-0956968-00"}]
*/
        <%= tabledata %>


</script>

</head>
<body>
    <form id="form1" runat="server">

        <div id="rt"></div>

    </form>
    <h2>Should make diferent guids for control, communicate, and purchase for security reasons</h2>

</body>
</html>
