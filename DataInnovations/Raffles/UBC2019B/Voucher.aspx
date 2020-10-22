﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Voucher.aspx.cs" Inherits="DataInnovations.Raffles.UBC2019B.Voucher" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        img {
            display: block;
            margin-left: auto;
            margin-right: auto;
            width: 50%;
        }

        .pc {
            text-align: center;
        }

        html, body {
            width: 100%;
        }

        table {
            margin: 0 auto;
        }

        th, td {
            border: solid;
            border-width: thin;
            border-collapse: collapse;
            padding: 5px;
            text-wrap: none;
        }

        th {
            text-align: left;
        }

        .centered {
            position: absolute;
            width: 100px;
            top: 40%;
            left: 45%;
        }

        .bigfont {
            font-size: x-large;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script type="text/javascript">


        $(document).ready(function () {



            var statusstring = "Winner,Printed,Notified,Received Voucher,Ordered,Collected";
            var statusoptions = statusstring.split(',');

            $('tbody tr').each(function () {
                id = $(this).data('id');
                var s = $('<select class="form-control sel_statusfull" name="" winnerid="' + id + '" />');
                value = $(this).find('td').eq(6).text();
                statusoptions.forEach(function (item, index) {
                    if (value == item) {
                        selectedvalue = true;
                    } else {
                        selectedvalue = false;
                    }
                    $("<option />", { value: item, text: item, selected: selectedvalue }).appendTo(s);
                });
                $(this).find('td').eq(6).html(s);
            });

            filter();

            $('.sel_statusfull').change(function () {
                id = $(this).attr("winnerid");
                value = $(this).val();
                //alert(id + ', ' + value);

                $.ajax({
                    url: "../data.asmx/updaterafflestatus?id=" + id + "&status=" + value, success: function (result) {
                        //alert('Success');
                    }, error: function (XMLHttpRequest, textStatus, error) {
                        alert("AJAX error: " + textStatus + "; " + error);
                    }
                });
                filter();

            });


            $('#sel_status').change(function () {
                $('#processing').show();

                $.ajax({
                    url: "../data.asmx/updaterafflestatus?id=" + $('#hf_id').val() + "&status=" + $(this).val(), success: function (result) {
                        //alert('Success');
                    }, error: function (XMLHttpRequest, textStatus, error) {
                        alert("AJAX error: " + textStatus + "; " + error);
                    }
                });
                setTimeout(
                    function () {
                        $('#processing').hide();
                    }, 1000);
            });
            $(':checkbox').change(function () {
                
                //console.log(selected);
                filter();


            });
        });

        function filter() {
            var selected = [];
            $(':checkbox:checked').each(function () {
                selected.push($(this).val());
            });
            var c1 = 0;
            var c2 = 0;
            $('tbody tr').each(function () {
                c1++;
                //thisstatus = $(this).find('td').eq(6).text();
                thisstatus = $(this).find('.sel_statusfull').val();
                if (selected.indexOf(thisstatus) != -1) {
                    c2++;
                    $(this).show();
                }
                else {
                    $(this).hide();
                }
            });
            $('#count').text(c2 + '/' + c1);
        }

    </script>


</head>
<body>
    <form id="form1" runat="server">

        <!--<img src="Images/ChefsChoice%20Logo.PNG" />-->
        <div>
            <p></p>
            <%= html%>
        </div>

        <div id="processing" style="display: none">
            <img src="../../Dependencies/Images/processing2.gif" class="centered" />
        </div>


    </form>

</body>
</html>
