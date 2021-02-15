using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TOHW.PhotoHunt11Jun18
{
    public partial class Default : System.Web.UI.Page
    {
        public string groupcode;
        protected void Page_Load(object sender, EventArgs e)
        {
            string nl = System.Environment.NewLine;
            groupcode = Request.QueryString["id"] + "";
            if (groupcode != "")
            {

                string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";

                using (SqlConnection conn = new SqlConnection(strConnString))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter())
                    {
                        da.SelectCommand = new SqlCommand("PH_Get_Group_Photos", conn);
                        da.SelectCommand.CommandType = CommandType.StoredProcedure;

                        da.SelectCommand.Parameters.Add("@GroupCode", SqlDbType.Int).Value = groupcode;
                        DataTable table = new DataTable();
                        da.Fill(table);
                        int version = 0;

                        int rows = table.Rows.Count;
                        //rows = 1;
                        for (int f1 = 0; f1 < rows; f1++)

                        {
                            DataRow dr = table.Rows[f1];

                            string counter = dr["counter"].ToString();
                            if (f1 == 0 || counter != table.Rows[f1 - 1]["counter"].ToString()) //if it's the first time through or counter has changed ie (new photo)
                            {
                                version = (int)dr["version"];

                                Lit_Images.Text += "<hr />";
                                Lit_Images.Text += "<h2>";
                                Lit_Images.Text += "Photo: " + counter + " Current version: " + version;
                                string showorhide = "Hide";
                                string display = "";

                                if (dr["answered"].ToString() == "Yes")
                                {
                                    Lit_Images.Text += " (Answered)";
                                    showorhide = "Show";
                                    display = " style=\"display:none\"";
                                }


                                Lit_Images.Text += "<input class=\"button togglephoto\" type=\"button\" value=\"" + showorhide + "\" />";
                                Lit_Images.Text += "</h2>";
                                Lit_Images.Text += "<div" + display + ">"; //wraps everything about this photo; answer and versions

                                if (dr["answered"].ToString() == "Yes")
                                {
                                    //Lit_Images.Text += "<input class=\"button toggleanswer\" type=\"button\" value=\"Show Answer\" />";
                                    //Lit_Images.Text += "<div>";
                                    string imagepath = "images\\Answers\\" + groupcode + "\\" + dr["photo_ctr"];
                                    string[] files = Directory.GetFiles(MapPath(imagepath), "*", SearchOption.TopDirectoryOnly);
                                    foreach (string filename in files)
                                    {
                                        Lit_Images.Text += nl + "<div class=\"container\">" + nl;
                                        Lit_Images.Text += "<img src=\"images/Answers/" + groupcode + "/" + dr["photo_ctr"] + "/" + Path.GetFileName(filename) + "\" />" + nl;
                                        Lit_Images.Text += "<div class=\"top-left\">Photo: " + counter + " Answer</div>" + nl;
                                        Lit_Images.Text += "</div>" + nl;
                                    }
                                    //Lit_Images.Text += "</div>";
                                }
                                else
                                {
                                    if (dr["version"].ToString() != "4")
                                    {
                                        Lit_Images.Text += "<input type=\"button\" class=\"button shownextversion\" id=\"P_" + dr["photo_ctr"] + "\" value=\"Show the next version\" />";
                                    }
                                    Lit_Images.Text += "<input type=\"button\" class=\"button answer\" data-groupcode=\"" + groupcode + "\" data-photo=\"" + dr["photo_ctr"] + "\" value=\"Answer\" />";
                                }


                            }

                            if ((int)dr["version"] == version - 1)
                            {
                                Lit_Images.Text += "<input type=\"button\" class=\"button toggleversions\" value=\"Show Previous Versions\" />" + nl;
                                Lit_Images.Text += "<div class=\"versions\" id=\"versions_" + counter + "\">" + nl;
                            }

                            Lit_Images.Text += nl + "<div id=\"div_photo_" + dr["photo_ctr"] + "\" class=\"container\">" + nl;
                            Lit_Images.Text += "<img id=\"I_" + dr["photo_ctr"] + "_" + dr["version"] + "\" src=\"Images/" + dr["GUID"] + ".jpg\" title=\"Images/" + dr["GUID"] + ".jpg\" />" + nl;
                            Lit_Images.Text += "<div class=\"top-left\">Photo: " + counter + ", version: " + dr["version"].ToString() + "</div>" + nl;
                            Lit_Images.Text += "</div>" + nl;

                            // <div class="top-left">Top Left</div>

                            if ((int)dr["version"] == 1 && version > 1)
                            {
                                Lit_Images.Text += "</div>" + nl;
                            }
                            if (f1 == rows - 1 || counter != table.Rows[f1 + 1]["counter"].ToString())
                            {
                                Lit_Images.Text += "</div>" + nl;
                            }
                        }
                    }
                }
            }
        }
    }
}