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
    public partial class Answer : System.Web.UI.Page
    {
        public string groupcode;
        public string photo_ctr;
        public string showupload;

        protected void Page_Load(object sender, EventArgs e)
        {
            groupcode = Request.QueryString["group"];
            photo_ctr = Request.QueryString["photo"];
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            string path = Server.MapPath("\\PhotoHunt11Jun18\\images\\answers\\" + groupcode + "\\" + photo_ctr );
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            foreach (HttpPostedFile postedFile in fu_answer.PostedFiles)
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

                }

            }

            string strConnString = "Data Source=toh-app;Initial Catalog=TeOraHou;Integrated Security=False;user id=OnlineServices;password=Whanganui497";
            SqlConnection con = new SqlConnection(strConnString);

            SqlCommand cmd = new SqlCommand("PH_Update_Group_Photos", con);
            cmd.Parameters.Add("@GroupCode", SqlDbType.VarChar).Value = groupcode; //1111; //
            cmd.Parameters.Add("@Photo_CTR", SqlDbType.VarChar).Value = photo_ctr; 

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            try
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                //while (dr.Read())
                //{
                //}

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
            Lit_Response.Text = "Successfully saved."; // < span id=\"span_message\">Your image has been recorded.  You may click \"Close\" or \"Upload\" another image.</span><br /><input id=\"btn_close\" type=\"button\" value=\"Close\" /> <input id=\"btn_upload\" type=\"button\" value=\"Upload\" />";
            showupload = " style=\"display: none\"";
            //Response.Write(path + "<br />");
            //Response.Write("Close this page and refresh the calling page");
        }
    }
}