<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZoneTraining.aspx.cs" Inherits="UBC.Training.ZoneTraining" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 58.5pt;
            width: 113pt;
            color: windowtext;
            font-size: 14.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: left;
            vertical-align: middle;
            white-space: normal;
            border-left: .5pt solid white;
            border-right-style: none;
            border-right-color: inherit;
            border-right-width: medium;
            border-top: .5pt solid white;
            border-bottom: .5pt solid white;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #4471C4;
        }



        .auto-style6 {
            height: 30.0pt;
            width: 113pt;
            color: black;
            font-size: 14.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: left;
            vertical-align: middle;
            white-space: normal;
            border-left: .5pt solid white;
            border-right-style: none;
            border-right-color: inherit;
            border-right-width: medium;
            border-top: .5pt solid white;
            border-bottom: .5pt solid white;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #4471C4;
        }

        .auto-style7 {
            width: 109pt;
            color: black;
            font-size: 11.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: left;
            vertical-align: middle;
            white-space: normal;
            border: .5pt solid white;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #B4C6E7;
        }



        .auto-style13 {
            width: 109pt;
            color: black;
            font-size: 11.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: left;
            vertical-align: middle;
            white-space: normal;
            border: .5pt solid white;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #D9E2F3;
        }



        .auto-style18 {
            height: 18.75pt;
            width: 113pt;
            color: black;
            font-size: 14.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: normal;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #BFBFBF;
        }



        .auto-style20 {
            width: 56pt;
            color: black;
            font-size: 14.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: normal;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #BFBFBF;
        }

        .auto-style21 {
            height: 18.75pt;
            color: black;
            font-size: 14.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #00B0F0;
        }

        .auto-style23 {
            height: 18.75pt;
            width: 113pt;
            color: black;
            font-size: 14.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: left;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #BFBFBF;
        }

        .auto-style24 {
            width: 109pt;
            color: black;
            font-size: 14.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #BFBFBF;
        }



        .auto-style26 {
            color: black;
            font-size: 11.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #99FF66;
        }

        .auto-style27 {
            color: black;
            font-size: 11.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: yellow;
        }

        .auto-style28 {
            color: black;
            font-size: 11.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #FF9900;
        }

        .auto-style29 {
            color: white;
            font-size: 11.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: red;
        }

        .auto-style30 {
            color: white;
            font-size: 11.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            background: #C00000;
        }

        .toprighticon {
            border-style: none;
            border-color: inherit;
            border-width: 0;
            position: fixed;
            top: 5px;
            right: 15px;
            z-index: 9999;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>

    <script type="text/javascript">


        $(document).ready(function () {

            $('#menu').click(function () {
                window.location.href = '../default.aspx';
            })


            $('#btn_calculate').click(function () {
                seconds = parseInt($('#minutes').val() * 60) + parseInt($('#seconds').val());
                workload = seconds / 4;
                workload = 500 / workload;
                workload = Math.pow(workload, 3);
                workload = workload * 2.8;

                //--------------------------------------------------
                thisworkload = workload * .6;
                $('#U3_1').text('< ' + thisworkload.toFixed(1));
                lastworkload = thisworkload.toFixed(1);

                split = thisworkload / 2.8;
                split = Math.pow(split, (1 / 3));
                split = 500 / split;
                split = secstotime(split);
                $('#U3_2').text('< ' + split);
                lastsplit = split;
                //--------------------------------------------------
                thisworkload = workload * .7;
                $('#U2_1').text(lastworkload + ' - ' + thisworkload.toFixed(1));
                lastworkload = thisworkload.toFixed(1);

                split = thisworkload / 2.8;
                split = Math.pow(split, (1 / 3));
                split = 500 / split;
                split = secstotime(split);
                $('#U2_2').text(lastsplit + ' - ' + split);
                lastsplit = split;
                //--------------------------------------------------                
                thisworkload = workload * .8;
                $('#U1_1').text(lastworkload + ' - ' + thisworkload.toFixed(1));
                lastworkload = thisworkload.toFixed(1);

                split = thisworkload / 2.8;
                split = Math.pow(split, (1 / 3));
                split = 500 / split;
                split = secstotime(split);
                $('#U1_2').text(lastsplit + ' - ' + split);
                lastsplit = split;
                //--------------------------------------------------
                thisworkload = workload * .85;
                $('#T_1').text(lastworkload + ' - ' + thisworkload.toFixed(1));
                lastworkload = thisworkload.toFixed(1);

                split = thisworkload / 2.8;
                split = Math.pow(split, (1 / 3));
                split = 500 / split;
                split = secstotime(split);
                $('#T_2').text(lastsplit + ' - ' + split);
                lastsplit = split;
                //--------------------------------------------------
                $('#M_1').text('> ' + lastworkload);

                $('#M_2').text('> ' + lastsplit);
                //--------------------------------------------------

                UBC_person_id = "<%= Session["UBC_person_id"] %>";
                UBC_name = "<%= Session["UBC_name"] %>";
                if (1 == 1) {
                    var arForm = [{ "name": "UBC_person_id", "value": UBC_person_id }, { "name": "UBC_name", "value": UBC_name }, { "name": "seconds", "value": seconds }];
                    var formData = JSON.stringify({ formVars: arForm });
                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        contentType: "application/json; charset=utf-8",
                        url: '../people/posts.asmx/Update_person_ergTime', // the url where we want to POST
                        data: formData,
                        dataType: 'json'
                        /*
                        , // what type of data do we expect back from the server
                        success: function (result) {
                        },
                        error: function (xhr, status) {
                            alert("An error occurred: " + status);
                        }
                        */
                    });
                }
            })

        }); //document.ready

        function secstotime(val) {
            var sec_num = val;
            var hours = Math.floor(sec_num / 3600);
            var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
            var seconds = (sec_num - (hours * 3600) - (minutes * 60)).toFixed(1);

            if (hours < 10) { hours = "0" + hours; }
            //if (minutes < 10) { minutes = "0" + minutes; }
            if (seconds < 10) { seconds = "0" + seconds; }
            //return hours + ':' + minutes + ':' + seconds;
            return minutes + ':' + seconds;
        }
    </script>

</head>
<body>

  

    <form id="form1" runat="server">
            <input type="button" id="menu" class="toprighticon btn btn-info" value="MENU" /> 
        <table style="border-collapse: collapse">
            <tr>
                <td class="auto-style18" colspan="2">2K Erg Time</td>
            </tr>
            <tr>
                <td class="auto-style20">Minutes</td>
                <td class="auto-style20">Seconds</td>
            </tr>
            <tr>
                <td class="auto-style21">
                    <input id="minutes" type="text" /></td>
                <td class="auto-style21">
                    <input id="seconds" type="text" /></td>
            </tr>
        </table>
        <button type="button" id="btn_calculate">Calculate</button>
        <p>
            &nbsp;
        </p>
        <table style="border-collapse: collapse">
            <tr>
                <td class="auto-style23">Training Zones</td>
                <td class="auto-style24">U3</td>
                <td class="auto-style24">U2</td>
                <td class="auto-style24">U1</td>
                <td class="auto-style24">Threshold</td>
                <td class="auto-style24">Max</td>
            </tr>
            <tr>
                <td class="auto-style23">Work Load</td>
                <td class="auto-style26" id="U3_1"></td>
                <td class="auto-style27" id="U2_1"></td>
                <td class="auto-style28" id="U1_1"></td>
                <td class="auto-style29" id="T_1"></td>
                <td class="auto-style30" id="M_1"></td>
            </tr>
            <tr>
                <td class="auto-style23">Split</td>
                <td class="auto-style26" id="U3_2"></td>
                <td class="auto-style27" id="U2_2"></td>
                <td class="auto-style28" id="U1_2"></td>
                <td class="auto-style29" id="T_2"></td>
                <td class="auto-style30" id="M_2"></td>
            </tr>
        </table>
        <p>
            &nbsp;
        </p>
        <table style="border-collapse: collapse">
            <tr>
                <td class="auto-style1">Training Zone</td>
                <td class="auto-style1">&nbsp;</td>
                <td class="auto-style1">Prescriptive desciption</td>
                <td class="auto-style1">Blood lactate threshold relationship</td>
                <td class="auto-style1">Blood lactate<br />
                    concentration,
                <br />
                    mmol.L<sup>‐1</sup></td>
                <td class="auto-style1">%HR<sub>max</sub></td>
                <td class="auto-style1">%VO<sub>2</sub>max</td>
                <td class="auto-style1">RPE</td>
                <td class="auto-style1">Duration Guide</td>
                <td class="auto-style1">Rate Guide</td>
                <td class="auto-style1">Notes</td>
            </tr>
            <tr>
                <td class="auto-style6">U3</td>
                <td class="auto-style7">Recovery</td>
                <td class="auto-style7">Light aerobic</td>
                <td class="auto-style7">&lt;LT1</td>
                <td class="auto-style7">&lt;2.0</td>
                <td class="auto-style7">60‐75</td>
                <td class="auto-style7">&lt;60</td>
                <td class="auto-style7">Very light</td>
                <td class="auto-style7">&gt;3h</td>
                <td class="auto-style7">18‐20</td>
                <td class="auto-style7">Easy rowing (Could have a conversation easily)</td>
            </tr>
            <tr>
                <td class="auto-style6">U2</td>
                <td class="auto-style13">Extensive Aerobic</td>
                <td class="auto-style13">Moderate aerobic</td>
                <td class="auto-style13">Lower half between LT1 and LT2</td>
                <td class="auto-style13">1.0‐3.0</td>
                <td class="auto-style13">75‐84</td>
                <td class="auto-style13">60‐72</td>
                <td class="auto-style13">Light</td>
                <td class="auto-style13">1‐3h</td>
                <td class="auto-style13">20‐22</td>
                <td class="auto-style13">Long endurance rows (Can say longer sentences but feel breathless at the end)</td>
            </tr>
            <tr>
                <td class="auto-style6">U1</td>
                <td class="auto-style7">Intensive aerobic</td>
                <td class="auto-style7">Heavy aerobic</td>
                <td class="auto-style7">Upper half between LT1 and LT2</td>
                <td class="auto-style7">2.0‐4.0</td>
                <td class="auto-style7">82‐89</td>
                <td class="auto-style7">70‐82</td>
                <td class="auto-style7">Somewhat hard</td>
                <td class="auto-style7">20‐30min</td>
                <td class="auto-style7">23‐26</td>
                <td class="auto-style7">Continuous intensive rowing (Say only short sentences, 3‐4 words, any more lose your breath)</td>
            </tr>
            <tr>
                <td class="auto-style6">Threshold</td>
                <td class="auto-style13">Anaerobic Threshold</td>
                <td class="auto-style13">Threshold</td>
                <td class="auto-style13">LT2/AT</td>
                <td class="auto-style13">3.0‐6.0</td>
                <td class="auto-style13">88‐93</td>
                <td class="auto-style13">80‐85</td>
                <td class="auto-style13">Hard</td>
                <td class="auto-style13">12‐30min</td>
                <td class="auto-style13">25‐28</td>
                <td class="auto-style13">Long duration intervals ‐ short recovery (Hard to talk, only say short words)</td>
            </tr>
            <tr>
                <td class="auto-style6">Max aerobic</td>
                <td class="auto-style7">Max aerobic</td>
                <td class="auto-style7">Maximal aerobic</td>
                <td class="auto-style7">&gt;LT2/AT</td>
                <td class="auto-style7">&gt;5.0</td>
                <td class="auto-style7">92‐100</td>
                <td class="auto-style7">85‐100</td>
                <td class="auto-style7">Very hard</td>
                <td class="auto-style7">5‐8min</td>
                <td class="auto-style7">27‐30/30‐34/34‐42<br />
                </td>
                <td class="auto-style7">High intensity interval training (Can’t talk)</td>
            </tr>
        </table>
    </form>
</body>
</html>
