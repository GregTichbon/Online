using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Configuration;

namespace Online.WMC
{
    public partial class BookingEnquiry : System.Web.UI.Page
    {
        #region Class Parameters
        public string none = "none";
        public string selected = "selected";
        #endregion

        #region fields
        public string tb_applicant;
        public string tb_organisation;
        public string tb_charityregistration;
        public string tb_emailaddress;
        public string tb_postaladdress;
        public string tb_invoiceaddress;
        public string tb_mobilephone;
        public string tb_homephone;
        public string tb_workphone;
        public string tb_description;
        public string tb_overallnumbers;  //?
        public string tb_publictext;
        public string tb_overallfrom;//?
        public string tb_overallto;//?
        public string tb_overallattendeesfrom;//?
        public string tb_overallattendeesto;//?
        public string tb_otherinformation;
        public string tb_teacoffee;
        public string tb_glasses;
        public string tb_cupssaucers;
        public string tb_milkjugs;
        public string tb_hotwaterurns;
        public string tb_whitechaircovers;
        public string tb_colouredchairsaches;
        public string tb_roundwhitetablecloths;
        public string tb_snorkellift;
        public string tb_whiteboard;
        public string tb_lectern;
        public string tb_smokebeamisolation;
        public string tb_emptyskipbin;
        public string tb_main_projectorandscreen;
        public string tb_main_laptop;
        public string tb_main_soundsystem;
        public string tb_main_partitions;
        public string tb_main_curtains;
        public string tb_pioneer_projectorandscreen;
        public string tb_pioneer_laptop;
        public string tb_pioneer_soundsystem;
        public string tb_concert_projectorandscreen;
        public string tb_concert_laptop;
        public string tb_concert_soundsystem;
        public string tb_concert_lights;
        public string tb_concert_piano;
        public string tb_concert_pianotuning;


        #endregion
        
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["populate"] == "True")
            {
                tb_applicant = "Applicant";
                tb_organisation = "Organisation";
                tb_postaladdress = "Postal Address";
                tb_invoiceaddress = "Invoice Address";
                tb_emailaddress = "greg.tichbon@whanganui.govt.nz";
                tb_mobilephone = "021 1234567";
                tb_homephone = "06 3441234";
                tb_workphone = "06 3490001";
                tb_description = "Event Description";
                tb_overallnumbers = "100";
                tb_overallfrom = "22 Jun 2016 3:00 PM";
                tb_overallto = "23 Jun 2016 10:00 AM";
                tb_overallattendeesfrom = "22 Jun 2016 8:00 PM";
                tb_overallattendeesto = "23 Jun 2016 2:00 AM";
                tb_otherinformation = "Other information";
            }
           
            string html_venues = "";


            String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_WMC_Venues", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                string id = "";
                string link = "";

                while (reader.Read())
                {
                    ID = reader["WMC_Venue_CTR"].ToString();
                    link = reader["Link"].ToString();
                    if (link != "")
                    {
                        link = " <a href='" + reader["Link"].ToString() + "' target='WMCVenue'>See detail</a>";
                    }


                    html_venues = html_venues + "<tr>";
                    html_venues = html_venues + "<td>" + reader["Name"].ToString() + link + "</td>";
                    html_venues = html_venues + "<td><input id=\"required_" + id + "\" type=\"checkbox\" /></td>";
                    html_venues = html_venues + "<td><input type=\"text\" id=\"accessfrom_" + id + "\" class=\"datetime\"/></td>";
                    html_venues = html_venues + "<td><input type=\"text\" id=\"accessto_" + id + "\" class=\"datetime\"/></td>";
                    html_venues = html_venues + "<td><input type=\"text\" id=\"attendanceaccessfrom_" + id + "\" class=\"datetime\"/></td>";
                    html_venues = html_venues + "<td><input type=\"text\" id=\"attendanceaccessto_" + id + "\" class=\"datetime\"/></td>";
                    html_venues = html_venues + "</tr>";

                }


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

            lit_venues.Text = html_venues;

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
}