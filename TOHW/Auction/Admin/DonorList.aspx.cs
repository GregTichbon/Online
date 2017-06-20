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

namespace TOHW.Auction.Admin
{
    public partial class donorlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public static string get_donorlist(string path)
        {
            string donor_ctr;
            string donorname;
            string item_ctr;
            string title;
            string items = "";
            string delim = "";
            string images = "";
            string html = "";

            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlConnection con2 = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("Get_Donors", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@auction_ctr", SqlDbType.Int).Value = 1;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        donor_ctr = dr["donor_ctr"].ToString();
                        donorname = dr["donorname"].ToString();
                        items = "";

                        cmd = new SqlCommand("Get_Donor_Items", con2);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@donor_ctr", SqlDbType.Int).Value = donor_ctr;
                        cmd.Connection = con2;
                        try
                        {
                            con2.Open();
                            SqlDataReader dr2 = cmd.ExecuteReader();
                            if (dr2.HasRows)
                            {
                                while (dr2.Read())
                                {
                                    item_ctr = dr2["item_ctr"].ToString();
                                    title = dr2["title"].ToString();

                                    items += delim + title;
                                    delim = "<br />";

                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                        finally
                        {
                            con2.Close();
                        }

                        string imagepath = path + "\\donors\\" + donor_ctr;
                        if (Directory.Exists(imagepath))
                        {
                            images = "<div class=\"slideshow\" data-cycle-fx=scrollHorz data-cycle-timeout=2000 data-cycle-center-horz=true data-cycle-center-vert=true>";

                            foreach (string dirFile in Directory.GetDirectories(imagepath))
                            {
                                foreach (string fileName in Directory.GetFiles(dirFile))
                                {
                                    images += "<img src=\"../images/donors/" + donor_ctr + "/" + Path.GetFileName(fileName) + "\" height=\"80\" border=\"0\">";
                                }
                            }
                            images += "</div>";
                        }
                        html += "<tr><td><a href=donor.aspx?id=" + donor_ctr + ">" + donorname + "</a><td>" + items + "</td><td>" + images + "</td></tr>";
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con2.Close();
                con.Close();
                con.Dispose();
            }
            return html;
        }
    }
}