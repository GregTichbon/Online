<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Greg2.aspx.cs" Inherits="UBC.Dependencies.fullcalendar.demos.Greg2" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link href="../fullcalendar.min.css" rel="stylesheet">
    <style>
        td {
            border: solid;
            border-color: red;
        }
    </style>
</head>
<body>
    <div class="fc">
        <table>
            <tbody class="fc-body">
                <tr>
                    <td class="fc-widget-content">
                        <div class="fc-scroller fc-day-grid-container">
                            <div class="fc-day-grid fc-unselectable">
                                <div>
                                    <div>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="fc-content-skeleton">
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td class="fc-event-container" colspan="3">
                                                        <a class="fc-day-grid-event fc-h-event fc-event fc-start fc-end">
                                                            <div class="fc-content">
                                                                <span class="fc-title">Long Event</span>
                                                            </div>
                                                        </a>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <table><tr><td>x</td><td>x</td></tr></table>
</body>
</html>
