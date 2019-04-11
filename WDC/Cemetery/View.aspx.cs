using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

namespace Online.Cemetery
{
    public partial class View : System.Web.UI.Page
    {
        #region fields
        public string hf_id;

        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            hf_id = Request.QueryString["ID"];
            string mode = Request.QueryString["mode"];

            //List<BurialRecord> BurialRecordList = new List<BurialRecord>();

            //String strConnString = ConfigurationManager.ConnectionStrings["WSOnlineConnectionString"].ConnectionString;
            String strConnString = "Data Source=172.16.5.49;Initial Catalog=OnlineApplications;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("cemeteryview", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@accessid", SqlDbType.VarChar).Value = hf_id;

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    //BurialRecordList.Add(new BurialRecord
                    //{
                    string Name = dr["Name"].ToString();
                    string Age = dr["Age"].ToString();
                    string Date_of_Death = dr["Date_of_Death"].ToString();
                    string Gender = dr["Gender"].ToString();

                    string Warrant = dr["Warrant"].ToString();
                    string Date_of_Burial = dr["Date_of_Burial"].ToString();
                    string Date_of_Birth = dr["Date_of_Birth"].ToString();
                    string Residence = dr["Residence"].ToString();
                    string Occupation = dr["Occupation"].ToString();
                    string Minister = dr["Minister"].ToString();
                    string Director = dr["Director"].ToString();

                    string Date_of_Medical_Certificate = dr["Date_of_Medical_Certificate"].ToString();
                    string Marital_Status = dr["Marital_Status"].ToString();
                    string Place_of_Death = dr["Place_of_Death"].ToString();
                    string Register_No = dr["Register_No"].ToString();

                    string Stillborn = dr["Stillborn"].ToString();
                    string inscription = dr["inscription"].ToString();
                    string Location = dr["Location"].ToString();
                    string GISID = dr["GISID"].ToString();
                    string Area = dr["Area"].ToString();

                    //,
                    //GISID = dr["GISID"].ToString()
                    //});
                    lit_table.Text = "";
                    lit_table.Text += "<tr><td class=\"view_label\">Reference</td><td>" + hf_id + "</td></tr>";
                    if (Name != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Name</td><td>" + Name + "</td></tr>";
                    }
                    if (Age != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Age</td><td>" + Age + "</td></tr>";
                    }
                    if (Date_of_Death != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Date of Death</td><td>" + Date_of_Death + "</td></tr>";
                    }
                    if (Gender != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Gender</td><td>" + Gender + "</td></tr>";
                    }
                    if (Warrant != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Warrant</td><td>" + Warrant + "</td></tr>";
                    }
                    if (Date_of_Burial != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Date of Burial</td><td>" + Date_of_Burial + "</td></tr>";
                    }
                    if (Date_of_Birth != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Date of Birth</td><td>" + Date_of_Birth + "</td></tr>";
                    }
                    if (Residence != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Late Residence</td><td>" + Residence + "</td></tr>";
                    }
                    if (Occupation != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Occupation</td><td>" + Occupation + "</td></tr>";
                    }
                    if (Minister != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Minister</td><td>" + Minister + "</td></tr>";
                    }
                    if (Director != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Director</td><td>" + Director + "</td></tr>";
                    }
                    if (Date_of_Medical_Certificate != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Date of Medical_Certificate</td><td>" + Date_of_Medical_Certificate + "</td></tr>";
                    }
                    if (Marital_Status != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Marital Status</td><td>" + Marital_Status + "</td></tr>";
                    }
                    if (Place_of_Death != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Place of Death</td><td>" + Place_of_Death + "</td></tr>";
                    }
                    if (Register_No != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Register No</td><td>" + Register_No + "</td></tr>";
                    }
                    if (Stillborn != "")
                    {
                        lit_table.Text += "<tr><td class=\"view_label\">Stillborn</td><td>" + Stillborn + "</td></tr>";
                    }
                    if (Location != "")
                    {
                        string GISIDRef = "";
                        //if (GISID != "")
                        //{
                        //GISIDRef = " <img alt=\"View Location\" class=\"showmap\" src=\"../images/map.ico\" id=\"" + GISID + "\" />";
                        //}
                        lit_table.Text += "<tr><td class=\"view_label\">Location</td><td>" + Location + GISIDRef + "</td></tr>";
                    }
                    if (GISID != "")
                    {
                        //lit_map.Text = "<iframe style=\"width:100%;height:400px\" src=\"http://maps.whanganui.govt.nz/IntraMaps80/default.htm?project=WhanganuiCemeteries&configId=e2f871a1-7722-4ecb-96bb-331a067216de&module=Cemeteries&layer=~Cemetery%20Plots&mapkey=" + GISID + "\"></iframe>";
                        //lit_map.Text = "<iframe style=\"width:100%;height:400px\" src=\"http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&project=WhanganuiMapControls&module=Planning&layer=Land&search=false&info=false&slider=false&expand=false\"></iframe>";
                        lit_map.Text = "<iframe src=\"https://mangomap.com/wdc/maps/83667/Aramoho-Cemetery?field=ogc_fid&layer=66c5427a-dd63-11e8-9eae-06765ea3034e&preview=true&value=" + GISID + "\" allowtransparency=\"true\" frameborder=\"0\" scrolling=\"no\" allowfullscreen mozallowfullscreen webkitallowfullscreen oallowfullscreen msallowfullscreen width=\"100%\" height=\"400\"></iframe>";


                        //lit_map.Text = "<iframe style=\"width:100%;height:400px\" src=\"http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?mapkey=" + GISID + "&project=WhanganuiMapControls&module=WDCCemeteries&layer=~Cemetery%20Plots&search=false&info=false&slider=false&expand=false\"></iframe>";
                        //Greg05jul2018}
                        //lit_tabs.Text = "";
                        //lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_test\">Test</a></li>";

                        //Greg05jul2018if (GISID != "")
                        //Greg05jul2018{
                        lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_map\">Map</a></li>";
                    }
                    else
                    {
                        if (Area == "Rose Garden")
                        {
                            lit_map.Text = "<iframe style=\"width:100%;height:400px\" src=\"https://mangomap.com/wdc/maps/74982/Whanganui-Cemeteries?field=location&layer=038ea1c2-7fd2-11e8-bfd8-06765ea3034e&preview=true&value=Rose+Garden\"></iframe>";
                            lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_map\">Map</a></li>";
                        }
                    }

                    String imagepath = ConfigurationManager.AppSettings["Cemetery.ImageFolder"] + hf_id;
                    String imageurl = ConfigurationManager.AppSettings["Cemetery.ImageURL"] + hf_id + "/";

                    //lit_debug.Text += imagepath;
                    if (Directory.Exists(imagepath))
                    {
                        var files = Directory.EnumerateFiles(imagepath, "*.*", SearchOption.TopDirectoryOnly)
                            .Where(s => s.ToLower().EndsWith(".jpg") || s.ToLower().EndsWith(".jpeg"));

                        if (files.Count() > 0)
                        {
                            lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_images\">Images</a></li>";
                            foreach (string currentFile in files)
                            {
                                lit_images.Text += "<img src=\"" + imageurl + Path.GetFileName(currentFile) + "\" />";
                            }
                        }

                    }
                    if (inscription != "")
                    {
                        lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_inscription\">Inscription</a></li>";
                        lit_inscription.Text = inscription;
                    }

                    if (mode == "admin")
                    {
                        lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_notes\">Notes</a></li>";
                        lit_tabs.Text += "<li><a data-toggle=\"tab\"href=\"#div_feedback\">Feedback</a></li>";
                    }
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

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

        }
    }
    /*
        public class BurialRecord
    {
        public string Name;
        public string Age;
        public string Date_of_Death;
        public string Gender;

        public string Warrant;
        public string Date_of_Burial;
        public string Date_of_Birth;
        public string Residence;
        public string Occupation;
        public string Minister;
        public string Director;

        public string Date_of_Medical_Certificate;
        public string Marital_Status;
        public string Place_of_Death;
        public string Register_No;

        public string Stillborn;
        public string Location;
        public string AccessID;
        //public string GISID;
    }
    */
}