using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online.Cemetery.Administration
{
    public partial class ImportGIS : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_go_Click(object sender, EventArgs e)
        {
            String strConnString = "Data Source=172.16.5.152;Initial Catalog=Cemetery;Integrated Security=False;user id=OnlineServices;password=Whanganui101";
            SqlConnection con = new SqlConnection(strConnString);

            con = new SqlConnection(strConnString);
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                Boolean firstline = true;
                //string filename = @"F:\InternetData\Cemetery\AramohoCemeteryPlots 7_12_2018.csv";
                //filename = @"C:\temp\AramohoCemeteryPlots 7_12_2018.csv";
                using (var reader = new StreamReader(tb_filename.Text))
                {
                    while (!reader.EndOfStream)
                    {
                        var line = reader.ReadLine();
                        line = line.Replace("\"", "");
                        var values = line.Split(',');
                        //cmd.Parameters.Clear();

                        if (!firstline)
                        {
                            //cemetery,area,division,plot,MapID
                            cmd.CommandText = "insert into GISImport (mapkey,cemetery,area,division,plot) values (" + Q(values[4]) + "," + Q(values[0]) + "," + Q(values[1]) + "," + Q(values[2]) + "," + Q(values[3]) + ")";
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            firstline = false;
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                lit_response.Text = ex.Message;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
        private string Q(string value)
        {
            return (string.Format("'{0}'", value));
        }
    }
}