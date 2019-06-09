<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test1.aspx.cs" Inherits="DataInnovations.YearPlanner.Test1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        table {
            border: none;
            height: 300px;
            width: 100%;
            border-collapse: collapse;
        }

        td {
            border: none;
        }

        span.day {
            line-height: 20px; /* just to give it a height */
            display: block;
            color: red;
            text-align: center;
            font-size: 100px;
        }

        span.contents {
            position: relative;
            top: -20px;
        }

        div.day {
            position: relative;
            line-height: 20px; /* just to give it a height */
            display: block;
            color: yellow;
            text-align: center;
            vertical-align: middle;
            font-size: 100px;
            z-index: 9999;
        }

        div.contents {
            position: relative;
            top: -20px;
            z-index: 1;
        }

        .left {
            background-color: red;
            width: 80%;
            height: 100%;
            text-align: left;
        }

        .right {
            background-color: green;
            width: 80%;
            text-align: right;
        }

        .both {
            background-color: blue;
        }

        .l {
            width: 20%;
        }

        .m {
            width: 60%;
        }

        .r {
            width: 20%;
        }

        .cr {
            background-color: red;
        }

        .cb {
            background-color: blue;
        }

        .cg {
            background-color: green;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td>1</td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <div class="left">xxxx</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="right"></td>
                        </tr>
                        <tr>
                            <td class="both"></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                    </table>
                </td>
                <td>3</td>
            </tr>
        </table>

        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td class="l cr"></td>
                            <td class="m cr"></td>
                            <td class="r cr"></td>
                        </tr>
                        <tr>
                            <td class="l"></td>
                            <td class="m cb"></td>
                            <td class="r cb"></td>
                        </tr>
                        <tr>
                            <td class="l cg"></td>
                            <td class="m cg"></td>
                            <td class="r"></td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td class="l cr"></td>
                            <td class="m cr"></td>
                            <td class="r cr"></td>
                        </tr>
                        <tr>
                            <td class="l cb"></td>
                            <td class="m cb"></td>
                            <td class="r"></td>
                        </tr>
                        <tr>
                            <td class="l cg"></td>
                            <td class="m cg"></td>
                            <td class="r"></td>
                        </tr>
                    </table>
                </td>
                <td>
                    <div class="day">6</div>
                    <div class="contents">
                        <table>
                            <tr>
                                <td class="l cr"></td>
                                <td class="m cr"></td>
                                <td class="r cr"></td>
                            </tr>
                            <tr>
                                <td class="l"></td>
                                <td class="m cb"></td>
                                <td class="r cb"></td>
                            </tr>
                            <tr>
                                <td class="l cg"></td>
                                <td class="m cg"></td>
                                <td class="r"></td>
                            </tr>
                        </table>
                    </div>

                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <span class="day">6</span>
                    <span class="contents">Contents go here</span>
                </td>
                <td>X</td>
                <td>X</td>
            </tr>

        </table>
    </form>
</body>
</html>
