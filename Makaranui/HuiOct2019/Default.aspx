<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Makaranui.HuiOct2019.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        th {
            text-align: left;
        }

            th.right, td.right {
                text-align: right;
            }

        .numeric {
            direction: rtl;
        }

        #regtable {
            width: 100%;
        }

        table {
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

        }
    </style>
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script type="text/javascript">

        var mywidth;

        $(document).ready(function () {

            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                mywidth = 800;
            }
            $('#regtable tr').click(function () {
                $('#firstname').val($(this).find('td:eq(1)').text());
                $('#lastname').val($(this).find('td:eq(2)').text());
                $('#phone').val($(this).find('td:eq(3)').text());
                $('#email').val($(this).find('td:eq(4)').text());
                $('#age').val($(this).find('td:eq(5)').text());
                $('#diet').val($(this).find('td:eq(6)').text());
                $('#health').val($(this).find('td:eq(7)').text());
                $('#medication').val($(this).find('td:eq(8)').text());
                $('#emergency').val($(this).find('td:eq(9)').text());
                $('#firstaid').val($(this).find('td:eq(10)').text());



                $("#dialog_items").dialog({
                    resizable: false,
                    //height: 700,
                    width: mywidth,
                    modal: true,
                    position: { my: "centre", at: "centre", of: window },
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Save": function () {
                            alert('To do');
                            $(this).dialog("close");
                        }
                    }
                });
            });


        }); //document.ready

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Wananga Registration<br />
    <br />
    <table id="regtable">
        <thead>
            <tr>
                <th>Primary Contact</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th class="right">Age</th>
                <th>Special<br />
                    Dietary Needs</th>
                <th>Health/Medical<br />
                    Issues</th>
                <th>Medication</th>
                <th>Emergency Contact</th>
                <th>First Aid</th>
            </tr>
        </thead>
        <tbody><%= registrationhtml %></tbody>
    </table>
    <table>
        <thead>
            <tr>
                <th>Size</th>
                <th class="right">Number</th>
            </tr>
        </thead>
        <tbody><%= tshirtshtml %></tbody>
    </table>
    <div id="dialog_items" title="Person Details" style="display: none" class="form-horizontal">

        Primary Contact<br />
                First Name <input type="text" id="firstname" /><br />
                Last Name <input type="text" id="lastname" /><br />
                Phone <input type="tel" id="phone" /><br />
                Email <input type="email" id="email" /><br />
                Age <input type="number" id="age" /><br />
                Special Dietary Needs <textarea id="diet"></textarea><br />
                Health/Medical Issues <textarea id="health"></textarea><br />
                Medication <select id="medication"><option>Yes</option></select><br />
                Emergency Contact <textarea id="emergency"></textarea><br />
                First Aid <select id="firstaid"><option>Yes</option></select><br />


    </div>
</asp:Content>
