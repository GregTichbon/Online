using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Online.Cemetery.DataMatching
{
    public partial class LocationControl_TreeMaint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lit_body.Text = "";
            string id = "";

            lit_body.Text += "<ul class='Cemetery C_'>\n";
            lit_body.Text += "<li class='Add'><span id='Add_C_' class='Add Cemetery'>Add Cemetery</span></li>\n";


            String strConnString = ConfigurationManager.ConnectionStrings["CemeteryBusinessConnectionString"].ConnectionString;
            SqlConnection conC = new SqlConnection(strConnString);
            SqlCommand cmdC = new SqlCommand("GetCemeteries", conC);
            cmdC.CommandType = CommandType.StoredProcedure; 
            cmdC.Connection = conC;
            try
            {
                conC.Open();
                SqlDataReader drC = cmdC.ExecuteReader();
                if (drC.HasRows)
                {
                    while (drC.Read())
                    {
                        id = drC["cemeteryid"].ToString();

                        if (id == "1")
                        {

                            lit_body.Text += "<li><span id='Disp_Edit_C_" + id + "'>" + drC["cemeteryname"].ToString() + "</span> <span class='Edit' id='Edit_C_" + id + "'>Edit</span>\n";
                            lit_body.Text += "<ul class='Area A_" + id + "'>\n";
                            lit_body.Text += "<li class='Add'><span id='Add_A_" + id + "' class='Add Area'>Add Area</span></li>\n";
                            //-------------------------------------AREAS START---------------------------------------
                            SqlConnection conA = new SqlConnection(strConnString);
                            SqlCommand cmdA = new SqlCommand("GetAreas", conA);
                            cmdA.CommandType = CommandType.StoredProcedure;
                            cmdA.Parameters.Add("@cemeteryid", SqlDbType.VarChar).Value = id;
                            cmdA.Parameters.Add("@datamode", SqlDbType.VarChar).Value = "New";

                            cmdA.Connection = conA;
                            try
                            {
                                conA.Open();
                                SqlDataReader drA = cmdA.ExecuteReader();
                                if (drA.HasRows)
                                {
                                    while (drA.Read())
                                    {
                                        id = drA["areaid"].ToString();
                                        lit_body.Text += "<li><span id='Disp_Edit_A_" + id + "'>" + drA["areaname"].ToString() + "</span> <span class='Edit' id='Edit_A_" + id + "'>Edit</span>\n";
                                        lit_body.Text += "<ul class='Division D_" + id + "'>\n";
                                        lit_body.Text += "<li class='Add'><span id='Add_D_" + id + "' class='Add Division'>Add Division</span></li>\n";
                                        //-----------------------------DIVISION START-----------------------------------------------
                                        SqlConnection conD = new SqlConnection(strConnString);
                                        SqlCommand cmdD = new SqlCommand("GetDivisions", conD);
                                        cmdD.CommandType = CommandType.StoredProcedure;
                                        cmdD.Parameters.Add("@AreaID", SqlDbType.VarChar).Value = id;
                                        cmdD.Parameters.Add("@datamode", SqlDbType.VarChar).Value = "New";
                                        cmdD.Connection = conD;
                                        try
                                        {
                                            conD.Open();
                                            SqlDataReader drD = cmdD.ExecuteReader();
                                            if (drD.HasRows)
                                            {
                                                while (drD.Read())
                                                {
                                                    id = drD["divisionid"].ToString();
                                                    lit_body.Text += "<li><span id='Disp_Edit_D_" + id + "'>" + drD["divisionname"].ToString() + "</span> <span class='Edit' id='Edit_D_" + id + "'>Edit</span></li>\n";
                                                }
                                            }
                                        }
                                        catch (Exception ex)
                                        {
                                            throw ex;
                                        }
                                        finally
                                        {
                                            conD.Close();
                                            conD.Dispose();
                                        }
                                        lit_body.Text += "</ul></li>";
                                        //-----------------------------DIVISION END-----------------------------------------------
                                    }
                                }
                            }

                            catch (Exception ex)
                            {
                                throw ex;
                            }
                            finally
                            {
                                conA.Close();
                                conA.Dispose();
                            }
                            lit_body.Text += "</ul></li>";
                            //-----------------------------AREAS END-----------------------------------------------
                            //break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conC.Close();
                conC.Dispose();
            }
            lit_body.Text += "</ul></li></ul>";

        }
    }
}