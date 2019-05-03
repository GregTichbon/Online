<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="datainn.co.nz.VehicleReminders._default" %>


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
                    { title: "ID", field: "Vehicle_CTR", visible: false},
                    { title: "Registration", field: "Registration", editor: "input" },
                    { title: "Description", field: "Description", editor: "textarea" },
                    { title: "Registration Due", field: "RegistrationDue", editor: dateEditor },
                    { title: "WOF Due", field: "WofDue", editor: dateEditor },
                    { title: "Service Due", field: "ServiceDue", editor: dateEditor },
                    { title: "Notes", field: "Notes", editor: "textarea" },
                    { title: "Email", field: "Email", editor: "input" },
                    { title: "Hold Email till", field: "HoldEmailTill", editor: dateEditor },
                    { title: "Mobile", field: "Mobile", editor: "input" },
                    { title: "Hole Mobile till", field: "HoldMobileTill", editor: dateEditor }
                ]
            });

        });
        
        <%= tabledata %>

</script>

</head>
<body>
    <form id="form1" runat="server">
        <div id="rt">
        </div>
    </form>
</body>
</html>
