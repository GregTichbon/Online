using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataInnovations.YearPlanner
{
    public partial class FullCalendarIO : System.Web.UI.Page
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
                // = (dayofweek - 1) % 7;
                int daysinmonth = DateTime.DaysInMonth(year, month);
                if (dayofweek + daysinmonth > lastpos)
                {
                    lastpos = dayofweek + daysinmonth;
                }
            }
            html += "<thead><tr><th>Month</th>";
            DateTime tdate = new DateTime(2019, 7, 1);  //it's a Monday :-)
            for (int day = 0; day < lastpos; day++)
            {
                html += "<th>" + tdate.AddDays(day).ToString("ddd") + "</th>";
            }
            html += "</tr></thead><tbody>";
            for (int month = 1; month <= 12; month++)
            {
                int d1 = 0;
                DateTime sdate = new DateTime(year, month, 1);
                html += "<tr><td>" + sdate.ToString("MMM") + "</td>";
                int dayofweek = (int)sdate.DayOfWeek; //Sunday is 0     MOD(xxx-1,7)
                dayofweek = mod(dayofweek - 1, 7);
                //dayofweek = (dayofweek - 1) % 7;
                int daysinmonth = DateTime.DaysInMonth(year, month);
                for (int c1 = 0; c1 < lastpos; c1++)
                {
                    html += "<td>";
                    if (c1 >= dayofweek && c1 < dayofweek + daysinmonth)
                    {
                        d1++;
                        html += d1.ToString();
                    }
                    html += "</td>";
                }
                html += "</tr>";
            }
            html += "</tbody>";
        }


        public Int16 mod(double a, double b)
        {
            return Convert.ToInt16( a - b  * Math.Floor(a / b));
        }
    }
}