<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TOHW.PhotoHunt11Jun18.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="<%: ResolveUrl("~/Dependencies/colorbox/colorbox.css")%>" rel="stylesheet" />
    <style>
        img {
            width: 100%;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="<%: ResolveUrl("~/Dependencies/colorbox/jquery.colorbox-min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.show').click(function () {
                direction = $(this).attr('id').substring(0, 1);
                //alert(direction);
                if (direction == 'B') {
                    ans = true;
                } else {
                    ans = confirm("Are you sure that you want to show the next version of this photo?")
                }
                if(ans) {
                    photo = $(this).attr('id').substring(2);
                    $.ajax({
                        url: "data.asmx/get_next_version?groupcode=<%=groupcode%>&photo=" + photo + "&direction=" + direction, success: function (result) {
                            myresult = $.parseJSON(result);
                            src = myresult.src;
                            version = myresult.version;
                            $('#I_' + photo).attr("src", src);
                            $('#I_' + photo).attr("title", src);
                            window.location.hash = 'I_' + photo;
                            if (version == 4) {
                                $('#P_' + photo).remove();
                            } else {
                                $('#V_' + photo).text(version);
                            }
                        }
                    });
                }
            });

            $('.answer').click(function () {
                //alert('.answer');
                photo = $(this).data('photo');
                groupcode = $(this).data('groupcode');
                $.colorbox({
                    href: 'answer.aspx?group=' + groupcode + '&photo=' + photo,
                    iframe: true,
                    overlayClose: false,
                    width: '70%',
                    height: '60%',
                    onClosed: function () {
                        location.reload(true);
                    }
                });
            });



        }); //document ready

  
    </script>
</head>
<body>
    <form id="form1" runat="server">
        Your mission is to take a the most diverse and crazy photo of your group from the same place that the photos below were taken.<br />
        There are 4 versions of each photo, each version will reveal a little more of the place but for each version you view you will lose points.<br />
        Points will be allocated as follows
        <br />
        <table>
            <tr>
                <th>Version</th>
                <th>Points</th>
            </tr>
            <tr>
                <td>1</td>
                <td>50</td>
            </tr>
            <tr>
                <td>2</td>
                <td>40</td>
            </tr>
            <tr>
                <td>3</td>
                <td>25</td>
            </tr>
            <tr>
                <td>4</td>
                <td>10</td>
            </tr>
        </table>
        <br />
        You must return to Te Ora Hou by 8:45pm<br />
        &nbsp;<br />
        <asp:Literal ID="Lit_Images" runat="server"></asp:Literal>
    </form>
</body>
</html>
