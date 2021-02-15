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

        .photo {
            display: inline;
        }

        .answered {
            display: none;
        }

        .versions {
            /*border: 5px solid red;*/
            display: none;
        }

        .toggleversions {
            font-size: large;
        }

        .container {
            position: relative;
            text-align: center;
            color: white;
        }

        .top-left {
            background-color: red;
            font-size: large;
            position: absolute;
            top: 8px;
            left: 16px;
        }

        .button {
            box-shadow: 3px 4px 0px 0px #8a2a21;
            background: linear-gradient(to bottom, #c62d1f 5%, #f24437 100%);
            background-color: #c62d1f;
            border-radius: 18px;
            border: 1px solid #d02718;
            display: inline-block;
            cursor: pointer;
            color: #ffffff;
            font-family: Arial;
            font-size: 17px;
            padding: 7px 25px;
            text-decoration: none;
            text-shadow: 0px 1px 0px #810e05;
            margin: 10px 10px 10px 10px;
        }

            .button:hover {
                background: linear-gradient(to bottom, #f24437 5%, #c62d1f 100%);
                background-color: #f24437;
            }

            .button:active {
                position: relative;
                top: 1px;
            }


    </style>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="<%: ResolveUrl("~/Dependencies/colorbox/jquery.colorbox-min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $('.togglephoto').click(function () {
                div = $(this).parent().nextAll().filter("div").first();
                if ($(this).val().substring(0, 1) == "H") {
                    $(div).hide();
                    $(this).val('Show');
                } else {
                    $(div).show();
                    $(this).val('Hide');
                }
            })

            $('.toggleversions').click(function () {
                //div = $(this).parent().nextAll().filter("div").first();
                if ($(this).val().substring(0, 1) == "H") {
                    $(this).next('div').hide();
                    $(this).val('Show Previous Versions');
                } else {
                    $(this).next('div').show();
                    $(this).val('Hide Previous Versions');
                }
              
            })

            $('.shownextversion').click(function () {
                alert("Greg is testing");
                
                direction = $(this).attr('id').substring(0, 1);
                //alert(direction);
                if (direction == 'B') {
                    ans = true;
                } else {
                    ans = confirm("Are you sure that you want to show the next version of this photo?")
                }
                if (ans) {
                    photo = $(this).attr('id').substring(2);
                    $.ajax({
                        url: "data.asmx/get_next_version?groupcode=<%=groupcode%>&photo=" + photo + "&direction=" + direction, success: function (result) {
                            location.reload();
                            /*
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
                            */
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
