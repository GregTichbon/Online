<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Mapping.aspx.cs" Inherits="Online.Administration.CRM.Mapping" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            var combo = $("<select></select>"); //.attr("id", "id_").attr("name", "id_");
            var optionList = ["a", "b", "c", "d"];

            $.each(optionList, function (i, el) {
                combo.append("<option>" + el + "</option>");
            });



            var c1 = 0;
            $(".td_mapping").each(function () {
                c1++;
                newcombo = combo.clone();
                newcombo.attr("id", "id_" + c1).attr("name", "id_" + c1);
                newcombo.val($(this).closest('td').prev('td').text());

                $(this).append(newcombo);

            });

        })
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <th>Passed</th>
                <th>Mapped</th>
            </tr>
            <tr>
                <td>1111</td>
                <td class="td_mapping"></td>
            </tr>
            <tr>
                <td>b</td>
                <td class="td_mapping"></td>
            </tr>
            <tr>
                <td>3333</td>
                <td class="td_mapping"></td>
            </tr>
            <tr>
                <td>c</td>
                <td class="td_mapping"></td>
            </tr>
            <tr>
                <td>5555</td>
                <td class="td_mapping"></td>
            </tr>
        </table>


    </form>
</body>
</html>
