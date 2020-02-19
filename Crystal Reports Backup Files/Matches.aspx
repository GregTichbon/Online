<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Matches.aspx.cs" Inherits="DataInnovations.StrengthFinders.Matches" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Strength Finders</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link href="../Dependencies/StickyTableCells/jquery.stickytable.min.css" rel="stylesheet" />
    <style>
        /*
        .dropdown {
            background-color: yellow;
        }
          
        .strength {
            transform: rotate(90deg);
            -webkit-transform: rotate(90deg);
            -moz-transform: rotate(90deg);
        }
                */

        .filtered {
            background-color: aqua;
        }

        .subgroup {
            font-size: smaller;
        }

        select {
            background-color: yellow;
        }

        td {
            text-align: center;
            white-space: nowrap;
        }

            td.left {
                text-align: left;
            }

      
 
    </style>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!--<script src="../Dependencies/TableHeadFixer/tableHeadFixer.js"></script>-->
    <script src="../Dependencies/StickyTableCells/jquery.stickytable.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {

            //$("#fixTable").tableHeadFixer({ "left": 1 });

            //$('#parent').css('height', $(window).height() - 0);

            //$(window).resize(function () {
                //$('#parent').css('height', $(window).height() - 0);
            //});

            /*
            $('.sticky-table').css('height', $(window).height() + 200);

            $(window).resize(function () {
                $('.sticky-table').css('height', $(window).height() + 200);
            });
            */

            $('.strength').click(function () {
                $('tr:hidden').show();
                $('th:hidden').show();
                $('td:hidden').show();
                if ($(this).hasClass('filtered')) {
                    $(this).removeClass('filtered');
                } else {
                    $('.filtered').removeClass('filtered');
                    $(this).addClass('filtered');
                    strength = $(this).attr('id').substring(1);
                    $("[strength=" + strength + "]").each(function (i, obj) {
                        if ($(obj).text() == "") {
                            $(obj).parent().hide();
                        }
                    });
                }
            });


            $('.person').click(function () {
                $('tr:hidden').show();
                $('th:hidden').show();
                $('td:hidden').show();
                if ($(this).hasClass('filtered')) {
                    $(this).removeClass('filtered');
                } else {
                    $('.filtered').removeClass('filtered');
                    $(this).addClass('filtered');
                    person = $(this).attr('id').substring(1);
                    $("[person=" + person + "]").each(function (i, obj) {

                        if ($(obj).text() == "") {
                            strength = $(obj).attr('strength');
                            $('[strength=' + strength + ']').hide();
                            $('#S' + strength).hide();
                            //alert($(obj).text());
                            //$(obj).parent().hide();
                        }
                    });
                }
            });

        }) //document.ready

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Literal ID="LitRows" runat="server"></asp:Literal>
        </div>

    </form>
</body>
</html>
