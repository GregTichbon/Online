<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FullCalendarIO2.aspx.cs" Inherits="DataInnovations.YearPlanner.FullCalendarIO2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Year Planner</title>
        <link href="../Dependencies/fullcalendar/fullcalendar.min.css" rel="stylesheet" />
    <style>
        table {
            width:100%;
            border-collapse:collapse;
        }
        table, th, td {
            border:solid;
            border-width:thin;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="calendar" class="fc fc-unthemed fc-ltr">
            <div class="fc-view-container">
                <div class="fc-view">
                    <table>

                    <%=html%>
                    </table>

                </div>
            </div>
        </div>

    </form>
</body>
</html>
