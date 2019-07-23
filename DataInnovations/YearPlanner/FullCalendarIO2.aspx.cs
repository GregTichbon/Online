using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.YearPlanner
{
    public partial class FullCalendarIO2 : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            int year = 2019;
            int lastpos = 0;
            for (int month = 1; month <= 12; month++)
            {
                DateTime sdate = new DateTime(year, month, 1);
                int dayofweek = (int)sdate.DayOfWeek; //Sunday is 0     MOD(xxx-1,7)
                dayofweek = mod(dayofweek - 1, 7);
                int daysinmonth = DateTime.DaysInMonth(year, month);
                if (dayofweek + daysinmonth > lastpos)
                {
                    lastpos = dayofweek + daysinmonth;
                }
            }

            html += @"<thead class=""fc-head"">
            <tr><td class=""fc-head-container fc-widget-header""><div class=""fc-row fc-widget-header"">
            <table><thead><tr>";
            DateTime tdate = new DateTime(2019, 7, 1);  //it's a Monday :-)
            for (int day = 0; day < lastpos; day++)
            {
                html += @"<th class=""fc-day-header fc-widget-header"">" + tdate.AddDays(day).ToString("ddd") + "</th>";
            }
            html += "</tr></thead></table></div></td></tr></thead>";

            html += @"<tbody class=""fc-body"">
                        <tr>
                        <td class=""fc-widget-content"">
                        <div class=""fc-scroller fc-day-grid-container"" style=""overflow: hidden; height: 1800px;"">
                        <div class=""fc-day-grid"">";


            for (int month = 1; month <= 12; month++)
            {
                html += @"<div class=""fc-row fc-week fc-widget-content fc-rigid"" style=""height: 150px;"">
                <div class=""fc-bg"">
                <table>
                <tbody>
                <tr>";

                for (int c1 = 0; c1 < lastpos; c1++)
                {
                    html += @"<td class=""fc-day fc-widget-content""></td>";
                }
                html += @"</tr>
                </tbody>
                </table>
                </div>";
                html += @"<div class=""fc-content-skeleton"">
                <table>
                <thead>
                <tr>";
                int d1 = 0;
                DateTime sdate = new DateTime(year, month, 1);
                int dayofweek = (int)sdate.DayOfWeek; //Sunday is 0     MOD(xxx-1,7)
                dayofweek = mod(dayofweek - 1, 7);
                int daysinmonth = DateTime.DaysInMonth(year, month);
                for (int c1 = 0; c1 < lastpos; c1++)
                {
                    string day = "";
                    if (c1 >= dayofweek && c1 < dayofweek + daysinmonth)
                    {
                        d1++;
                        day = d1.ToString();
                    }
                    html += @"<td class=""fc-day-top"">
                    <a class=""fc-day-number"">" + day + @"</a>
                    </td>";
                }
                html += @"</tr>
                </thead>";
                html += @"<tbody>
                <tr>";
                for (int c1 = 0; c1 < lastpos; c1++)
                {
                    html += @"<td></td>";
                }
                html += @"</tr>";
                html += @"</tbody>
                </table>
                </div>
                </div>";
            }
            html += @" </div>
            </div>
            </td>
            </tr>
            </tbody>";
           
        }



        public Int16 mod(double a, double b)
        {
            return Convert.ToInt16(a - b * Math.Floor(a / b));
        }
    }
}