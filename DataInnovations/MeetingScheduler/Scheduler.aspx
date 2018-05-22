﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Scheduler.aspx.cs" Inherits="DataInnovations.MeetingScheduler.Scheduler" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Meeting Scheduler</title>
    <style>
        .s0 {
            background-color: yellow;
        }

        .s1 {
            background-color: black;
        }

        .s2 {
            background-color: green;
        }

        .s3 {
            background-color: yellow;
        }

        .save {
            padding: 10px;
            text-align: center;
            font: normal 10px Arial, sans-serif;
            border: solid 2px;
            border-color: white;
            width: 100px;
            background-color: red;
        }

        .selector {
            padding: 10px;
            text-align: center;
            font: normal 10px Arial, sans-serif;
            border: solid 2px;
            border-color: white;
            width: 100px;
        }


        .zui-table {
            border: none;
            border-right: solid 1px #DDEFEF;
            border-collapse: separate;
            border-spacing: 0;
            font: normal 10px Arial, sans-serif;
        }

            .zui-table thead th {
                background-color: #DDEFEF;
                border: none;
                color: #336B6B;
                padding: 5px;
                text-align: left;
                text-shadow: 1px 1px 1px #fff;
                white-space: nowrap;
            }

                .zui-table thead th.day {
                    text-align: center;
                }

                .zui-table thead th.d0 {
                    background-color: aqua;
                }

                .zui-table thead th.d1 {
                    background-color: mediumaquamarine;
                }


            .zui-table tbody td {
                border-bottom: solid 1px #DDEFEF;
                border-right: solid 1px #DDEFEF;
                color: #333;
                padding: 5px;
                text-shadow: 1px 1px 1px #fff;
                white-space: nowrap;
            }

        .zui-wrapper {
            position: relative;
        }

        .zui-scroller {
            margin-left: 201px; /* A) 21 More than B */
            overflow-x: scroll;
            overflow-y: visible;
            padding-bottom: 5px;
            width: 800px;
        }

        .zui-table .zui-sticky-col {
            border-left: solid 1px #DDEFEF;
            border-right: solid 1px #DDEFEF;
            left: 0;
            position: absolute;
            top: auto;
            width: 180px; /* B) 21 less than A */
            background-color: aqua;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>

    <script type="text/javascript">


        $(document).ready(function () {


            $('.zui-scroller').css('width', $(window).width() - 200);

            $(window).resize(function () {
                $('.zui-scroller').css('width', $(window).width() - 200);
            });

            var down = false;
            $(document).mousedown(function () {
                down = true;
            }).mouseup(function () {
                down = false;
            });

            var newrank = "";

            $(".selector").click(function () {
                $(".selector").css("border-color", "white");
                newrank = $(this).data('rank');
                $(this).css("border-color", "red");
            });

            $(".slot").mouseover(function () {
                document.getSelection().removeAllRanges();
                if (down && newrank != "") {
                    rank = $(this).attr('data-rank');
                    if (rank != newrank) {
                        $(this).removeClass('s' + rank);
                        $(this).attr('data-rank', newrank);
                        $(this).addClass('s' + newrank);
                    }
                }
            });

            $(".slot").mousedown(function () {
                document.getSelection().removeAllRanges();
                rank = $(this).attr('data-rank');
                $(this).removeClass('s' + rank);
                if (newrank == "") {
                    rank++;
                    if (rank > 2) {
                        rank = 0;
                    }
                } else {
                    rank = newrank;
                }
                $(this).attr('data-rank', rank);
                $(this).attr('data-changed', '1');
                $(this).addClass('s' + rank);
                document.getSelection().removeAllRanges();

            });

            $(".slot").mouseup(function () {
                document.getSelection().removeAllRanges();
            });

            $(".slot").dblclick(function () {
                document.getSelection().removeAllRanges();
            });

            $('.day').click(function () {
                if (newrank == "") {
                    alert('You must select an option below');
                } else {
                    day = $(this).data('day');
                    days = $('*[data-day="' + day + '"]');
                    days.attr("data-rank", newrank)
                    days.attr('data-changed', 1);
                    days.removeClass('s0');
                    days.removeClass('s1');
                    days.removeClass('s2');
                    days.removeClass('s3');
                    days.addClass('s' + newrank);

                }
            });


            $("form").submit(function (e) {
                //e.preventDefault();
                $('*[data-changed="1"]').each(function (index) {
                    rank = $(this).attr('data-rank');
                    reference = $(this).attr('data-reference');
                    $('<input>').attr({
                        type: 'hidden',
                        name: reference,
                        value: rank
                    }).appendTo('#form1');                    //alert(startdatetime + "=" + rank);
                });
            });

        }); //document.ready
    </script>
</head>
<body>
    <form id="form1" runat="server">
         <!--
        <div class="zui-wrapper">
            <div class="zui-scroller">
                <table class="zui-table">
                    <thead>
                        <tr>
                            <th class="zui-sticky-col">Name</th>
                            <th colspan='2'>xxxxxx</th>
                        </tr>
                        <tr>
                            <th class="zui-sticky-col">Name</th>
                            <th>Number</th>
                            <th>Position</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="zui-sticky-col">DeMarcus Cousins</td>
                            <td>15</td>
                            <td>C</td>
                        </tr>
                        <tr>
                            <td class="zui-sticky-col">Isaiah Thomas</td>
                            <td>22</td>
                            <td>PG</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
      
      -->
        <div class="zui-wrapper">
            <div class="zui-scroller">
                <table class="zui-table">
                    <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
                </table>
            </div>
        </div>

        <!--
        <p>--------------------------------------------------------------</p>
        <div class="zui-wrapper">
            <div class="zui-scroller">
                <table class="zui-table">
                    <thead>
                        <tr>
                            <th class="zui-sticky-col" rowspan="2">Name</th>
                            <th class="day" colspan="2">02/05/18</th>
                        </tr>
                        <tr>
                            <th>10:00</th>
                            <th>10:30</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="zui-sticky-col">Greg Tichbon</td>
                            <td class="slot s0" data-rank="0">&nbsp;</td>
                            <td class="slot s0" data-rank="0">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="zui-sticky-col">Helen</td>
                            <td class="s0" data-rank="0">&nbsp;</td>
                            <td class="s0" data-rank="0">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="zui-sticky-col">Jordin Haami</td>
                            <td class="s0" data-rank="0">5</td>
                            <td class="s0" data-rank="0">6</td>
                        </tr>
                        <tr>
                            <td class="zui-sticky-col">Judy Kumeroa</td>
                            <td class="s0" data-rank="0">7</td>
                            <td class="s0" data-rank="0">8</td>
                        </tr>
                        <tr>
                            <td class="zui-sticky-col">Kathy Parnell</td>
                            <td class="s0" data-rank="0">9</td>
                            <td class="s0" data-rank="0">0</td>
                        </tr>
                      </tbody>
                </table>
            </div>
        </div>
        -->

        <table>
            <tr>
                <td class="selector" data-rank="" style="background-color: aqua; border-color: red">Click</td>
                <td class="selector s1" data-rank="1" style="color: white">Unavailable</td>
                <td class="selector s3" data-rank="3">Not Sure</td>
                <td class="selector s2" data-rank="2">OK</td>
                <td><asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Save" Height="34px" Width="156px" />
                </td>
            </tr>
        </table>

        <div id="debug"></div>

    </form>
</body>
</html>
