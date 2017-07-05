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
    public partial class DonorList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public static string get_donorlist(string path)
        {
            string donor_ctr;
            string donorname;
            string seq;
            string hide;
            string item_ctr;
            string title;
            string items = "";
            string delim = "";
            string images = "";
            string html = "";
            string[] validimages = new string[] { ".jpg",".gif",".png" };


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
                        seq = dr["seq"].ToString();
                        hide = dr["hide"].ToString();
                        items = "";
                        delim = "";

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
                        images = "";
                        string imagepath = path + "\\auction\\donors\\" + donor_ctr;
                        if (Directory.Exists(imagepath))
                        {
                            //foreach (string dirFile in Directory.GetDirectories(imagepath))
                            //{
                                foreach (string fileName in Directory.GetFiles(imagepath))
                                {
                                    if (validimages.Contains(Path.GetExtension(fileName)))
                                    {
                                        images += "<img src=\"../images/auction/donors/" + donor_ctr + "/" + Path.GetFileName(fileName) + "\" border=\"0\" />";
                                    }
                                }
                            //}
                            images = "<div class=\"cycle-slideshow\" data-cycle-timeout=2000 data-cycle-log=false>" + images + "</div>";
                        }
                        html += "<tr><td><a href=donor.aspx?id=" + donor_ctr + ">" + donorname + "</a><td>" + seq + "</td><td>" + hide + "</td><td>" + items + "</td><td>" + images + "</td></tr>";
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