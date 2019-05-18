<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Group.aspx.cs" Inherits="DataInnovations.SMS.Administration.Group" %>

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

            var actRemove = function (cell, formatterParams, onRendered) {
                return "Remove";
            }

            //var actSend = function (cell, formatterParams, onRendered) {
            //    return '<input class="send" type="checkbox" />';
            //}          

            var table = new Tabulator("#rt", {
                data: tableData,
                dataEdited: function (data) {
                    //console.log(data);
                },
                cellEdited: function (cell) {
                    var cid = cell.getRow().getData().Number_CTR;
                    var cvalue = cell.getValue();
                    var cfield = cell.getColumn().getField();
                    //console.log(cfield + "=" + cid + "=" + cvalue);
                    //alert(cfield + "=" + cid + "=" + cvalue);
                   
                    $.ajax({
                        url: "../data.asmx/updatenumber?field=" + cfield + "&id=" + cid + "&value=" + cvalue, success: function (result) {
                            //alert('Success');
                        }, error: function (XMLHttpRequest, textStatus, error) {
                            alert("AJAX error: " + textStatus + "; " + error);
                        }
                    });
                
                },
                columns: [
                    //{ title: "Send", align:"center", formatter: actSend },
                    { title: "Group_number_CTR", field: "Group_number_CTR", visible: false },
                    { title: "Number_CTR", field: "Number_CTR", visible: false },
                    { title: "Number", field: "Number", editor: "input" },
                    { title: "Name", field: "Name", editor: "input" },
                    { title: "Greeting", field: "Greeting", editor: "input" },
                    { title: "Status", field: "Status", editor: "input" },
                    {
                        title: "Remove", formatter: actRemove, cellClick: function (e, cell) {
                            var Group_number_CTR = cell.getRow().getData().Group_number_CTR;
                            $.ajax({
                                url: "../data.asmx/RemovefromGroup?Group_number_CTR=" + Group_number_CTR, success: function (result) {
                                    cell.getRow().delete();
                                }, error: function (XMLHttpRequest, textStatus, error) {
                                    alert("AJAX error: " + textStatus + "; " + error);
                                }
                            });
                        }
                    }
                ]
            })

            $('#addrow').click(function () {
                $('#searchname').val('');
                dialog = $("#dialog_add").dialog({
                    resizable: false,
                    height: 300,
                    width: 400,
                    modal: true,
                    position: { my: "centre", at: "centre", of: window }
                });
                $("#searchname").autocomplete({
                source: "../data.asmx/name_autocomplete",
                minLength: 2,
                    select: function (event, ui) {
                        //event.preventDefault();
                        selected = ui.item;
                        //alert(selected.value);
                        if (selected.value == 'new') {
                            $("#dialog_addnumber").find('input:text').val('');  
                            $("#dialog_addnumber").dialog({
                                resizable: false,
                                height: 300,
                                width: 400,
                                modal: true,
                                position: { my: "centre", at: "centre", of: window },
                                buttons: {
                                    "Cancel": function () {
                                        $(this).dialog("close");
                                    },
                                    "Save": function () {
                                        var arForm = [{ "name": "number_ctr", "value": "new" }, { "name": "number", "value": $('#number').val() }, { "name": "greeting", "value": $('#greeting').val() }, { "name": "status", "value": $('#status').val() }, { "name": "name", "value": $('#name').val() }, { "name": "source", "value": $('#source').val() }, { "name": "group_ctr", "value": $('#cb_group').val() }];
                                        //console.log(arForm);
                                        var formData = JSON.stringify({ formVars: arForm });
                                        //alert(formData);
                                        $.ajax({
                                            type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                            contentType: "application/json; charset=utf-8",
                                            url: '../posts.asmx/updatenumber', // the url where we want to POST
                                            data: formData,
                                            dataType: 'json', // what type of data do we expect back from the server
                                            success: function (result) {
                                                //console.log(result);
                                                //console.log(result.d);
                                                //console.log(result.d.Number_CTR);
                                                //console.log(result.d.Group_Number_CTR);
                                                table.addRow({ Group_number_CTR: result.d.Group_Number_CTR, Number_CTR: result.d.Number_CTR, Number: $('#number').val(), Name: $('#name').val(), Greeting: $('#greeting').val(), Status: $('#status').val() });
                                            },
                                            error: function (xhr, status) {
                                                alert("An error occurred: " + status);
                                            }
                                        });

                                        $(this).dialog("close");
                                    }
                                }
                            });
                        } else {
                            $.ajax({
                                url: "../data.asmx/AddtoGroup?Group_CTR=" + $('#cb_group').val() + "&Number_CTR=" + selected.value, success: function (result) {
                                    table.addRow({ Group_number_CTR: result.id, Number_CTR: selected.value, Number: selected.number, Name: selected.name, Greeting: selected.greeting, Status: selected.status });
                                }, error: function (XMLHttpRequest, textStatus, error) {
                                    alert("AJAX error: " + textStatus + "; " + error);
                                }
                            });
                        }
                        $(dialog).dialog('close');
                    }
                })

                //table.addRow();
            })

           
        });

             <%= tabledata %>

    </script>
    <style>
        table {
            width: 100%;
            border: 1px solid #FFFFFF;
            border-collapse: collapse;
        }

            table td, table th {
                border: 1px solid #FFFFFF;
                padding: 5px;
                text-align: left;
            }

            table tbody td {
                font-size: 13px;
            }

            table tr:nth-child(even) {
                background: #D0E4F5;
            }

            table thead {
                background: #0B6FA4;
                border-bottom: 5px solid #FFFFFF;
            }

                table thead th {
                    font-size: 17px;
                    font-weight: bold;
                    color: #FFFFFF;
                    text-align: left;
                    border-left: 2px solid #FFFFFF;
                }

                    table thead th:first-child {
                        border-left: none;
                    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:DropDownList ID="cb_group" runat="server" OnSelectedIndexChanged="cb_group_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem Value="">Please Select</asp:ListItem>
            <asp:ListItem Value="1">TOH Whakapakari</asp:ListItem>
            <asp:ListItem Value="2">TOH Office</asp:ListItem>
            <asp:ListItem Value="4">LTRT</asp:ListItem>
        </asp:DropDownList>
        <%=addrow %> <a href="groupsend.aspx">Send</a>

        <div id="rt"></div>
        <!--<asp:Label ID="lbl_html" runat="server" Text="Label"></asp:Label>-->
        <div id="dialog_add" title="Add a person to this group" style="display: none">
            <input id="searchname" name="searchname" type="text" />
        </div>
        <div id="dialog_addnumber" title="Add a person/number" style="display: none">
            Number: <input id="number" name="number" type="text" /> <br />
            Name: <input id="name" name="name" type="text" /> <br />
            Greeting: <input id="greeting" name="greeting" type="text" /> <br />
            Status: <input id="status" name="status" type="text" /> <br />
            Source: <input id="source" name="source" type="text" /> <br />
        </div>


    </form>
</body>
</html>
