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
    public partial class donor : System.Web.UI.Page
    {
        public string donor_ctr;
        //public string All;
        public string donorname;
        public string description;
        public string url;
        public string seq;
        public string hide;





        protected void Page_Load(object sender, EventArgs e)
        {
            donor_ctr = Request.QueryString["id"];
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
            string path = Server.MapPath("..\\images\\donor\\" + donor_ctr);
            if (Directory.Exists(path))
            {
                images = "<table><tr>";
                foreach (string dirFile in Directory.GetDirectories(path))
                {
                    foreach (string fileName in Directory.GetFiles(dirFile))
                    {
                        images += "<td><img src=\"../images/donor/" + donor_ctr + "/" + Path.GetFileName(fileName) + "\" height=\"160\" border=\"0\" alt=\"" + Path.GetFileName(fileName) + "\"><br />Delete <input name=\"_imgdelete_" + Path.GetFileName(fileName) + "\" type=\"checkbox\" id=\"_imgdelete_" + Path.GetFileName(fileName) + "\" value=\"-1\"></td>";
                    }
                }
                images += "</tr></table>";

                /*
                    folder = Server.MapPath("..\images\donor\" & id)
                    Set fso = Server.CreateObject("Scripting.FileSystemObject")
                    If fso.FolderExists(folder) = True Then
                        response.write "<table><tr>"
                        Set fsoFolder = fso.GetFolder(folder)
                        For Each fsoFile In fsoFolder.Files
                            Response.Write "<td><img src=""../images/donor/" & id & "/" & fsoFile.Name & """ height=""160"" border=""0"" alt=""" & fsoFile.Name & """><br />Delete <input name=""_imgdelete_" & fsoFile.Name & """ type=""checkbox"" id=""_imgdelete_" & fsoFile.Name & """ value=""-1""></td>"
                        Next
                        response.write "</table>"
                    End If
                    Set fso = nothing
                    Set fsoFolder = nothing
                    */
            }
        }
    }
}