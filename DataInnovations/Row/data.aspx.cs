using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace DataInnovations.Row
{
    public partial class data1 : System.Web.UI.Page
    {
        public string html;
        protected void Page_Load(object sender, EventArgs e)
        {
            string mode = Request.QueryString["mode"];

            switch (mode)
            {
                case "get_entry":
                    html = get_entry();
                    break;
                case "get_crewmembers":
                    html = get_crewmembers();
                    break;
            }

            /*
    Functions genericfunctions = new Functions();
    Dictionary<string, string> functionoptions = new Dictionary<string, string>();
    functionoptions.Add("storedprocedure", "");
    functionoptions.Add("usevalues", "");
    functionoptions.Add("parameters", "|" + Discipline + "|");
    //html = genericfunctions.buildandpopulateselect(strConnString, "@boats", "", functionoptions, "None");
    */
        }
        public string get_crewmembers()
        {
            string crew = Request.QueryString["crew"];
            string discipline = Request.QueryString["discipline"];
            string boat = Request.QueryString["boat"];
            string division = Request.QueryString["division"];
            string gender = Request.QueryString["gender"];

            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand();
            cmd1.Connection = con;
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.CommandText = "get_boat_details";

            //cmd1.Parameters.Add("@discipline_ctr", SqlDbType.VarChar).Value = discipline;
            cmd1.Parameters.Add("@boat_ctr", SqlDbType.VarChar).Value = boat;
            //cmd1.Parameters.Add("@division_ctr", SqlDbType.VarChar).Value = division;
            //cmd1.Parameters.Add("@gender_ctr", SqlDbType.VarChar).Value = gender;

            con.Open();
            SqlDataReader dr = cmd1.ExecuteReader();
            dr.Read();
            int seats = (int)dr["seats"];
            string coxed = dr["coxed"].ToString();
            dr.Close();
            
            #region original javascript
            /*
            jresult = $.parseJSON(result);
                                record = jresult[0];
                                prognostic_ctr = record.prognostic_ctr;
                                description = record.description;
                                code = record.code;
                                seats = record.seats;
                                coxed = record.coxed;
                                prognostictime = record.prognostictime;

                                if (seats != 1) {
                                    var divisionoptions = "";
                                    $.ajax({
                                        url: "data.asmx/division?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val(),
                                        dataType: 'json',
                                        async: false,
                                        success: function (data) {
                                            $.each(data, function (i, item) {
                                                if ($('#dd_division').val() == item.value) {
                                                    selected = ' selected';
                                                } else {
                                                    selected = '';
                                                }
                                                divisionoptions += '<option value="' + item.value + '"' + selected + '>' + item.label + '</option>';
                                            });
                                        }
                                    });


                                    //$.getJSON("data.asmx/division?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val(), function (data) {
                                    //    $.each(data, function (i, item) {
                                    //        if ($('#dd_division').val() == item.value) {
                                    //            selected = ' selected';
                                    //        } else {
                                    //            selected = '';
                                    //        }
                                    //        divisionoptions += '<option value="' + item.value + '">' + item.label + '</option>';
                                    //    });
                                    //});

                                    var genderoptions = "";
                                    $.ajax({
                                        url: "data.asmx/gender?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val() + "&division=" + $('#dd_division').val(),
                                        dataType: 'json',
                                        async: false,
                                        success: function (data) {
                                            $.each(data, function (i, item) {
                                                if ($('#dd_gender').val() == item.value) {
                                                    selected = ' selected';
                                                } else {
                                                    selected = '';
                                                }
                                                genderoptions += '<option value="' + item.value + '"' + selected + '>' + item.label + '</option>';
                                            });
                                        }
                                    });

                                    //$.getJSON("data.asmx/gender?discipline=" + $('#dd_discipline').val() + "&boat=" + $('#dd_boat').val() + "&division=" + $('#dd_division').val(), function (data) {
                                    //    $.each(data, function (i, item) {
                                    //        if ($('#dd_gender').val() == item.value) {
                                    //            selected = ' selected';
                                    //        } else {
                                    //            selected = '';
                                    //        }
                                    //        genderoptions += '<option value="' + item.value + '">' + item.label + '</option>';
                                    //    });
                                    //});
                                }

                                /-*
                                for (f1 = 0; f1 < seats; f1++) {
                                    if (seats > 1) {
                                        switch (f1) {
                                            case 0:
                                                role = 'Stroke '
                                                break;
                                            case seats - 1:
                                                role = 'Bow '
                                                break;
                                            default:
                                                role = f1 + 1 + ' ';
                                        }
                                    }
                                    myhtml += role + 'Name: <input type="text" name="xxx" /><select>' + options + '</select><br />';

                                }
                                *-/

            myhtml = "";
            myhtml += 'Prognostic: <span id="span_prognostic">' + prognostictime + '</span><br />';
            myhtml += "<table><thead><tr><th>Name</th><th>Division</th><th>Gender</th><th>Prognostic</th></tr></thead>"
                                for (f1 = 0; f1 < seats; f1++)
            {
                myhtml += '<tr><td><input type="text" name="seatname_' + (f1 + 1) + '" /></td>';
                if (seats != 1)
                {
                    myhtml += '<td><select class="seatdivision" id="seatdivision_' + (f1 + 1) + '" name="seatdivision_' + (f1 + 1) + '">' + divisionoptions + '</select></td><td><select class="seatgender" id="seatgender_' + (f1 + 1) + '" name="seatgender_' + (f1 + 1) + '">' + genderoptions + '</select></td>';
                    myhtml += '<td><span id="span_prognostic_' + (f1 + 1) + '">' + prognostictime + '</span></td>';
                }
                myhtml += '</tr>';
            }
            if (coxed == 1)
            {
                myhtml += '<tr><td colspan="4">Cox: <input type="text" name="cox" /></td></tr>';
            }

            myhtml += '</tbody></table>';

                                $('#html').html(myhtml);
            */
            #endregion

            string html = "";
            html += "<table><thead><th>Name</th>";
            if (seats > 1)
            {
                html += "<th>Club</th><th>Division</th><th>Gender</th><th>Prognostic</th>";
            }
            html += "</tr></thead><tbody>";
            int c1 = 0;
            if (crew != "")
            {
                //Don't need to enter club, division, and gender if using Competitor Table
                cmd1.CommandText = "get_crewmembers";
                cmd1.Parameters.Clear();
                cmd1.Parameters.Add("@crew_ctr", SqlDbType.VarChar).Value = crew;
                cmd1.Parameters.Add("@discipline_ctr", SqlDbType.VarChar).Value = discipline;
                cmd1.Parameters.Add("@boat_ctr", SqlDbType.VarChar).Value = boat;
                cmd1.Parameters.Add("@division_ctr", SqlDbType.VarChar).Value = division;
                cmd1.Parameters.Add("@gender_ctr", SqlDbType.VarChar).Value = gender;
                dr = cmd1.ExecuteReader();

                while (dr.Read())
                {
                    c1++;
                    string name = dr["name"].ToString();
                    string prognostictime = dr["prognostictime"].ToString();
                    html += "<tr><td><input type=\"text\" name=\"name_" + c1 + "\" value=\"" + name + "\" /></td><td><select name=\"club_" + c1 + "\"></select></td><td><select name=\"division_" + c1 + "\"></select></td><td><select name=\"gender_" + c1 + "\"></select></td><td>" + prognostictime + "</td></tr>";
                }

                dr.Close();
            }

            for (int c2 = c1 + 1; c2 <= seats; c2++)
            {
                html += "<tr><td><input type=\"text\" name=\"name_" + c1 + "\" /></td><td><select name=\"club_" + c1 + "\"></select></td><td><select name=\"division_" + c1 + "\"></select></td><td><select name=\"gender_" + c1 + "\"></select></td><td></td></tr>";
            }

            html += "</tbody></table>";

            con.Close();
            con.Dispose();

            return html;
        }

        public string get_entry()
        {
            string entry_id = Request.QueryString["id"];
            string discipline = Request.QueryString["Discipline"];

            //get_event_person event_id mode='Recorded'
            string strConnString = "Data Source=toh-app;Initial Catalog=Rowing;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd1 = new SqlCommand("get_entry", con);
            cmd1.Parameters.Add("@entry_id", SqlDbType.VarChar).Value = entry_id;
            cmd1.Parameters.Add("@discipline", SqlDbType.VarChar).Value = discipline;

            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd1.ExecuteReader();
                if (dr.HasRows)
                {

                    html = "<table><thead><tr><th>Name</th><th>Attendance</th><th>Note</th><th>Person's Note</th></tr></thead><tbody>";

                    while (dr.Read())
                    {
                        string name = dr["name"].ToString();
                        string attendance = dr["attendance"].ToString();
                        string note = dr["note"].ToString();
                        string personnote = dr["personnote"].ToString();

                        html += "<tr><td>" + name + "</td><td>" + attendance + "</td><td>" + note + "</td><td>" + personnote + "</td></tr>";

                    }
                    html += "</tbody></table>";
                }
                dr.Close();
            }

            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return "";
        }
    }
}