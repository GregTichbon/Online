<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintainPrognostic.aspx.cs" Inherits="DataInnovations.Row.MaintainPrognostic" %>

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
                        url: "posts.asmx/updateprognostic",
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        error: function (XMLHttpRequest, textStatus, error) {
                            alert("AJAX error: " + textStatus + "; " + error);
                        }
                    });
                },
                columns: [
                    { title: "ID", field: "Prognostic_CTR", visible: false },
                    { title: "Discipline", field: "Discipline", sorter: "alphanum", headerFilter: "input" },
                    { title: "Code", field: "code", sorter: "alphanum", headerFilter: "input", editor: "input" },
                    { title: "Description", field: "Description", sorter: "alphanum", headerFilter: "input", editor: "input" },
                    { title: "Boat", field: "Boat", sorter: "alphanum", headerFilter: "input" },
                    { title: "Division", field: "Division", sorter: "alphanum", headerFilter: "input" },
                    { title: "Gender", field: "Gender", sorter: "alphanum", headerFilter: "input" },
                    { title: "Prognostic Time", field: "prognostictime", sorter: "alphanum", editor: "input", validator:"float" }
                ]
            });

            $('#btn_edit').click(function () {
                $('#dialog_edit').dialog({
                    modal: true,
                    width: ($(window).width() - 0) * .95,  //75 x 2 is the width of the question mark top right
                    height: 600, //auto
                    position: { my: "center", at: "100", of: window }
                });
            })

        });

        <%= tabledata %>

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <input type="button" id="btn_edit" value="Add" />
        <div id="rt">
        </div>
        <div id="dialog_edit" title="Add a prognostic record" style="display: none">
         <h1>TO DO</h1>
            <p>Discipline</p>
            <p>Code</p>
            <p>Description</p>
            <p>Boat</p>
            <p>Division</p>
            <p>Gender</p>
            <p>Prognostic Time</p>
        </div>
    </form>
</body>
</html>
