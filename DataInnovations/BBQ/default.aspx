<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="DataInnovations.BBQ._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BBQ</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>

    <script type="text/javascript">

        var ctr = 0;
        $(document).ready(function () {

            

            $("#btn_addperson").click(function () {
                ctr  = ctr + 1;
                var markup = "<tr><td><textarea name='who-N" + ctr + "' style='width:90%'></textarea></td><td><textarea name='bringing-N" + ctr + "'style='width:90%'></textarea></td><td></td></tr>";
                $("#tbl tbody").append(markup);
            });

        }); //document.ready
    </script>

</head>
<body>
    <form id="form1" runat="server">
        NEED TO BE ABLE TO DO DELETION
        <table id="tbl" style="width: 100%">
            <tbody>
                <tr>

                    <td>
                        <input type="button" id="btn_addperson" value="Add" />
                        Who's coming?</td>
                    <td>What are they bringing?</td>   <td>Updated</td>
                       <asp:Literal ID="LitRows" runat="server"></asp:Literal>
          

                </tr>
            </tbody>
        </table>
                <asp:Button ID="btn_save" runat="server" Text="Save" OnClick="btn_save_Click" />
        <asp:Literal ID="lit_debug" runat="server"></asp:Literal>

    </form>
</body>
</html>
