<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="attr1.aspx.cs" Inherits="Online.TestAndPlay.attr1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script type="text/javascript">

        var newid = 0;
        $(document).ready(function () {


            $('#btn').click(function () {
                $('#test').attr('greg', 1);
                $('#test').text('greg');
                newid++;
                $('#table_items tr:last').after('<tr><td id="item_new_' + newid + '" class="item">Edit</td><td>' + 1 + '</td><td>' + 2 + '</td></tr>');
                thisitem = $('#table_items tr:last');
                console.log(thisitem);
                $(thisitem).find('td').attr('Yaaah',1);




            });

        });
        </script>

</head>
<body>
    <form id="form1" runat="server">

        <textarea id="test">Test</textarea>

       <table class="table" id="table_items">
                <thead>
                    <tr>
                        <th class="item" id="item_new">Add</th>
                        <th>Name</th>
                        <th>Description</th>
                        </tr>
                </thead>
                <tbody>
                 
                </tbody>
            </table>




        <a href="#" id="btn">Click</a>


    </form>
</body>
</html>
