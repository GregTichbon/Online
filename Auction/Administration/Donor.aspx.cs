using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Auction.Administration
{
    public partial class Donor : System.Web.UI.Page
    {
        public string donor_ctr;
        //public string All;
        public string donorname;
        public string description;
        public string url;
        public string seq;
        public string hide;
        string[] validimages = new string[] { ".jpg", ".gif", ".png" };

        protected void Page_Load(object sender, EventArgs e)
        {
            donor_ctr = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(donor_ctr))
            {
                String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(strConnString);

                SqlCommand cmd = new SqlCommand("Get_Donor", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@donor_ctr", SqlDbType.Int).Value = donor_ctr;
                cmd.Connection = con;
                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        donorname = dr["donorname"].ToString();
                        description = dr["description"].ToString();
                        url = dr["url"].ToString();
                        seq = dr["seq"].ToString();
                        hide = dr["hide"].ToString();
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

                string images = "";
                string path = Server.MapPath("..\\images\\auction\\donors\\" + donor_ctr);
                if (Directory.Exists(path))
                {
                    images = "<table><tr>";
                    foreach (string dirFile in Directory.GetDirectories(path))
                    {
                        foreach (string fileName in Directory.GetFiles(dirFile))
                        {
                            if (validimages.Contains(Path.GetExtension(fileName)))
                            {
                                images += "<td><img src=\"../images/donor/" + donor_ctr + "/" + Path.GetFileName(fileName) + "\" height=\"160\" border=\"0\" alt=\"" + Path.GetFileName(fileName) + "\"><br />Delete <input name=\"_imgdelete_" + Path.GetFileName(fileName) + "\" type=\"checkbox\" id=\"_imgdelete_" + Path.GetFileName(fileName) + "\" value=\"-1\"></td>";
                            }
                        }
                    }
                    images += "</tr></table>";
                }
            }
        }
    }
}