﻿using System;
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
        public string images;
        string[] validimages = new string[] { ".jpg", ".gif", ".png" };
        public string[] yesno_values = new string[2] { "Yes", "No" };

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

                string path = Server.MapPath("..\\images\\auction\\donors\\" + donor_ctr);
                if (Directory.Exists(path))
                {
                    images = "<table><tr>";
                    //foreach (string dirFile in Directory.GetDirectories(path))
                    //{
                        foreach (string fileName in Directory.GetFiles(path))
                        {
                            if (validimages.Contains(Path.GetExtension(fileName)))
                            {
                                images += "<td><img src=\"../images/auction/donors/" + donor_ctr + "/" + Path.GetFileName(fileName) + "\" height=\"160\" border=\"0\" alt=\"" + Path.GetFileName(fileName) + "\"><br />Delete <input name=\"_imgdelete_" + Path.GetFileName(fileName) + "\" type=\"checkbox\" id=\"_imgdelete_" + Path.GetFileName(fileName) + "\" value=\"-1\"></td>";
                            }
                        }
                    //}
                    images += "</tr></table>";
                }
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string donor_ctr = Request.Form["donor_ctr"];
            String strConnString = ConfigurationManager.ConnectionStrings["AuctionConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "Update_Donor";
            cmd.Parameters.Add("@donor_ctr", SqlDbType.VarChar).Value = donor_ctr;
            cmd.Parameters.Add("@donorname", SqlDbType.VarChar).Value = Request.Form["donorname"];
            cmd.Parameters.Add("@description", SqlDbType.VarChar).Value = Request.Form["description"];
            cmd.Parameters.Add("@url", SqlDbType.VarChar).Value = Request.Form["url"];
            cmd.Parameters.Add("@seq", SqlDbType.VarChar).Value = Request.Form["seq"];
            cmd.Parameters.Add("@hide", SqlDbType.VarChar).Value = Request.Form["hide"];

            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    donor_ctr = dr["donor_ctr"].ToString();
                }
            }
            catch (Exception ex)
            {
                General.Functions.Functions.Log(Request.RawUrl, ex.Message, "greg@datainn.co.nz");
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            //don't need to go through here if it's a new donor - will fix sometime
            string path = Server.MapPath("..\\images\\auction\\donors\\" + donor_ctr);
            string deletepath = Server.MapPath("..\\images\\auction\\donors\\" + donor_ctr + "\\deleted");

            foreach (string fld in Request.Form)
            {
                if (fld.StartsWith("_imgdelete_"))
                {
                   string filename = fld.Substring(11);
                    if (!Directory.Exists(deletepath))
                    {
                        Directory.CreateDirectory(deletepath);
                    }
                    int c1 = 0;
                    string newfilename = "";
                    string wpextension = System.IO.Path.GetExtension(filename);
                    string wpfilename = System.IO.Path.GetFileNameWithoutExtension(filename);

                    do
                    {
                        c1++;
                        newfilename = wpfilename + "_" + c1.ToString("000") + wpextension;
                    } while (File.Exists(deletepath + "\\" + newfilename));
                    File.Move(path + "\\" + filename, deletepath + "\\" + newfilename);
                }
            }

            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            string originalpath = Server.MapPath("..\\images\\auction\\donors\\" + donor_ctr + "\\originals");
            if (!Directory.Exists(originalpath))
            {
                Directory.CreateDirectory(originalpath);
            }

            foreach (HttpPostedFile postedFile in fu_images.PostedFiles)
            {
                if (postedFile.FileName != "")
                {
                    int c1 = 0;
                    string newfilename = "";
                    string wpextension = System.IO.Path.GetExtension(postedFile.FileName);
                    string wpfilename = System.IO.Path.GetFileNameWithoutExtension(postedFile.FileName);

                    do
                    {
                        c1++;
                        newfilename = wpfilename + "_" + c1.ToString("000") + wpextension;
                    } while (File.Exists(newfilename));

                    postedFile.SaveAs(path + "\\" + newfilename);
                    postedFile.SaveAs(originalpath + "\\" + newfilename);
                }

            }

            /*
            if all <> "" then
                response.redirect "donor.asp?all=true&id=" & id
            else
                response.redirect "donorlist.asp"
            end if		
            */
            Response.Redirect("DonorList.aspx");
        }
    }
}