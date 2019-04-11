<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FullCalendar2.aspx.cs" Inherits="Online.TestAndPlay.FullCalendar2" %>

<!DOCTYPE html>
<html>
<head>
    <title>Calendar</title>
    <style>
        .di {
            text-align: left;
        }

        .di-row {
            position: relative;
        }

        .di-event {
            position: relative;
            display: block;
            /* make the <a> tag block */
            border-radius: 3px;
            border: 1px solid white;
            background-color: red;
            color: white;
            padding: 2px;
        }

        .di table {
            width: 100%;
            box-sizing: border-box;
            /* fix scrollbar issue in firefox */
            table-layout: fixed;
            border-collapse: collapse;
            border-spacing: 0;
            font-size: 1em;
            /* normalize cross-browser */
        }

        .di td {
            border-style: solid;
            border-width: 1px;
            padding: 0;
            vertical-align: top;
        }

        .di .di-row {
            /* extra precedence to overcome themes w/ .ui-widget-content forcing a 1px border */
            /* no visible border by default. but make available if need be (scrollbar width compensation) */
            border-style: solid;
            border-width: 0;
        }

        .di-row table {
            height: 100%;
            /* don't put left/right border on anything within a fake row.
               the outer tbody will worry about this */
            border-left: 0 hidden transparent;
            border-right: 0 hidden transparent;
            /* no bottom borders on rows */
            border-bottom: 0 hidden transparent;
        }

        .di-row:first-child table {
            border-top: 0 hidden transparent;
            /* no top border on first row */
        }
    </style>


</head>
<body>
    <div class="di">
        <div class="di-view-container">
            <table>
                <tbody>
                    <tr>
                        <td>
                            <div class="di-row">
                                <div class="di-content-skeleton">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>M</td>
                                                <td>T</td>
                                                <td>W</td>
                                                <td>T</td>
                                                <td>F</td>
                                                <td>S</td>
                                                <td>S</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="di-content-skeleton">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td colspan="6" class="di-event-container">
                                                    <span class="di-event">Long Event 1</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="di-content-skeleton">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="di-event-container">
                                                    <span class="di-event">Long Event 2A<br />
                                                        Line 2</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="di-content-skeleton">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="di-event-container">
                                                    <span class="di-event">Long Event 2B<br />
                                                        Line 2</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="di-content-skeleton">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td colspan="4" class="di-event-container">
                                                    <span class="di-event">Long Event 3<br />
                                                        Line 2</span>
                                                </td>
                                                <td></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div class="di-row">
                                <div class="di-content-skeleton">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>M</td>
                                                <td>T</td>
                                                <td>W</td>
                                                <td>T</td>
                                                <td>F</td>
                                                <td>S</td>
                                                <td>S</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="di-content-skeleton">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td colspan="6" class="di-event-container">
                                                    <span class="di-event">Long Event 1</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="di-content-skeleton">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="di-event-container">
                                                    <span class="di-event">Long Event 2A<br />
                                                        Line 2</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="di-content-skeleton">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="di-event-container">
                                                    <span class="di-event">Long Event 2B<br />
                                                        Line 2</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="di-content-skeleton">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td colspan="4" class="di-event-container">
                                                    <span class="di-event">Long Event 3<br />
                                                        Line 2</span>
                                                </td>
                                                <td></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </td>
                    </tr>


                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
