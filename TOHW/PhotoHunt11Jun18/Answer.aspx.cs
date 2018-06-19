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
        public string photo;

        protected void Page_Load(object sender, EventArgs e)
        {
            groupcode = Request.QueryString["group"];
            photo = Request.QueryString["photo"];
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            string path = Server.MapPath("\\PhotoHunt11Jun18\\images\\answers\\" + groupcode + "\\" + photo );
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
            cmd.Parameters.Add("@Photo_CNT", SqlDbType.VarChar).Value = photo; 

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

            //Response.Write(path + "<br />");
            //Response.Write("Close this page and refresh the calling page");
        }
    }
}