<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Entry.aspx.cs" Inherits="DataInnovations.StrengthFinders.Entry" %>

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

   
        .centered {
  position: fixed; /* or absolute */
  top: 20%;
  left: 50%;
}
    </style>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="../Dependencies/StickyTableCells/jquery.stickytable.min.js"></script>

    <script type="text/javascript">

        var options = "<select><option></option>";;
        for (f1 = 0; f1 < 34; f1++) {
            options += "<option>" + f1 + "</option>";
        }
        options += "</select>";



        var newctr = 0;
        var lastid = '';

        $(document).ready(function () {

            $("form").submit(function (e) {
                var valid = true;
                $('.newname').each(function (i, obj) {
                    name = $(obj).val().trim();
                    if (name == '') {
                        alert('Missing Name');
                        valid = false;
                        return;
                    }
                });
                if (valid) {
                    $('#processing').show();
                    $('.rank').each(function (i, obj) {
                        if ($(obj).attr('rank') != $(obj).text()) {
                            $('<input>').attr({
                                type: 'hidden',
                                name: $(obj).attr('id'),
                                value: $(obj).text()
                            }).appendTo('#form1');
                        }
                    });
                }
            });

            $('#btn_add').click(function () {
                newctr++;
                newrow = '';
                newrow += '<tr>';
                newrow += '<td class="left"><input class="newname" id="name_' + newctr + '" name="newname_' + newctr + '" /></td>';
                for (f1 = 1; f1 < 34; f1++) {
                    newrow += '<td id="new_' + newctr + '_' + f1 + '" class="rank" person="new_' + newctr + '" strength="' + f1 + '" rank=""></td>';
                }
                newrow += '</tr>';
                $('table').append(newrow);
                $('#name_' + newctr).focus();
            });

            $(document).on('click', '.rank', function () {
                td = this;
                if ($(td).hasClass('dropdown')) {
                    $(td).find('select').change(function () {
                        $(td).removeClass('dropdown');
                        $(td).text($(this).val());
                    });
                } else {
                    if ($(this).attr('id') != lastid && lastid != '') {
                        $('#' + lastid).removeClass('dropdown');
                        $('#' + lastid).text($('#' + lastid).find('select').val());
                    }
                    lastid = $(this).attr('id');
                    val = $(this).text();
                    $(this).text('');
                    $(this).addClass('dropdown');
                    $(this).append(options);
                    $(this).find('select').val(val);
                    $(this).find('select').focus();

                }
            });

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
                        }
                    });
                }
            });

            $(document).keyup(function (e) {
                if (e.keyCode == 27) { // escape key maps to keycode `27`
                    $('tr:hidden').show();
                    $('th:hidden').show();
                    $('td:hidden').show();
                    $('.filtered').removeClass('filtered');

                    td = $('.dropdown');
                    $(td).text($(td).find('select').val());
                    $(td).removeClass('dropdown');
                }
            });

        }) //document.ready

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Literal ID="LitRows" runat="server"></asp:Literal>
            <a href="javascript:void(0)" id="btn_add">Add</a>  <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Save" Height="34px" Width="156px" />
        </div>
                <div id="processing" style="display:none">
            <img src="../Dependencies/Images/processing2.gif" class="centered"/></div>
    </form>
</body>
</html>
