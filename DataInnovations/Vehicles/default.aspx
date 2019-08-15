<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="datainn.co.nz.Vehicles._default" %>


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

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>

    <link href="https://unpkg.com/tabulator-tables@4.2.1/dist/css/tabulator.min.css" rel="stylesheet" />
    <script type="text/javascript" src="https://unpkg.com/tabulator-tables@4.2.1/dist/js/tabulator.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.js"></script>


    <script>
        $(document).ready(function () {
            $('[rel=tooltip]').tooltip('destroy');

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

            var valid_date = function (cell, value) {
                //cell - the cell component for the edited cell
                //value - the new input value of the cell
                //parameters - the parameters passed in with the validator
                if (value == "") {
                    return true;
                }
                var aDate = moment(value, 'D MMM YY', true);
                var isValid = aDate.isValid();
                return isValid;
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
                    console.log(cell.getColumn());


                    var arForm = [{ "name": "field", "value": cfield }, { "name": "id", "value": cid }, { "name": "value", "value": cvalue }];
                    var formData = JSON.stringify({ formVars: arForm });


                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        contentType: "application/json; charset=utf-8",
                        url: "posts.asmx/updatevehicle",
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        error: function (XMLHttpRequest, textStatus, error) {
                            alert("AJAX error: " + textStatus + "; " + error);
                        }
                    });
                },
                columns: [
                    { title: "ID", field: "vehicle_CTR", visible: false },
                    { title: "Registration", field: "registration", editor: "input" },
                    { title: "Description", field: "description", editor: "textarea" },
                    {
                        title: "Registration Due", field: "registrationdue", editor: "input", validator: [{
                            type: valid_date
                        }]
                    },
                    {
                        title: "WOF Due", field: "wofdue", editor: "input", validator: [{
                            type: valid_date
                        }]
                    },
                    {
                        title: "Service Due", field: "servicedue", editor: "input", validator: [{
                            type: valid_date
                        }]
                    },
                    { title: "Notes", field: "notes", editor: "textarea" },
                    { title: "Email", field: "email", editor: "input" },
                    {
                        title: "Hold Email till", field: "holdemailtill", editor: "input", validator: [{
                            type: valid_date
                        }]
                    },
                    { title: "Mobile", field: "mobile", editor: "input" },
                    {
                        title: "Hole Mobile till", field: "holdmobiletill", editor: "input", validator: [{
                            type: valid_date
                        }]
                    }
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
