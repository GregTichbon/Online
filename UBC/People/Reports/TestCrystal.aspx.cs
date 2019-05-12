using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UBC.People.Reports
{
    public partial class TestCrystal : System.Web.UI.Page
    {

        ReportDocument rpt;
        protected void Page_Load(object sender, EventArgs e)
        {

            string strConnString = "Data Source=toh-app;Initial Catalog=UBC;Integrated Security=False;user id=OnlineServices;password=Whanganui497";


            string r = Request.QueryString["id"];
            string report;
            DataSet ds = new DataSet();
            rpt = new ReportDocument();


            switch (r)
            {
                case "1":
                    SqlConnection con1 = new SqlConnection(strConnString);
                    SqlDataAdapter adp1 = new SqlDataAdapter("Report_RegattaTransactions", con1);
                    adp1.Fill(ds);
                    report = Server.MapPath("~/people/reports/crystal/RegattaStatements.rpt");
                    rpt.Load(report);
                    rpt.SetDataSource(ds.Tables["Table"]);

                    crv_report.ReportSource = rpt;
                    int PageCount = rpt.FormatEngine.GetLastPageNumber(new ReportPageRequestContext());

                    Literal1.Text = PageCount.ToString();
                   
                    ExportOptions CrExportOptions;
                    DiskFileDestinationOptions CrDiskFileDestinationOptions = new DiskFileDestinationOptions();
                    PdfRtfWordFormatOptions CrFormatTypeOptions = new PdfRtfWordFormatOptions();
                    CrDiskFileDestinationOptions.DiskFileName = "C:\\inetpub\\ubc.org.nz\\people\\test.pdf";
                    CrExportOptions = rpt.ExportOptions;

                    CrExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
                    CrExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
                    CrExportOptions.DestinationOptions = CrDiskFileDestinationOptions;
                    CrFormatTypeOptions.UsePageRange = true;

                    CrFormatTypeOptions.FirstPageNumber = 1;
                    CrFormatTypeOptions.LastPageNumber = 1;

                    CrExportOptions.FormatOptions = CrFormatTypeOptions;

                    rpt.Export();
 
                    break;
                case "2":
                    SqlConnection con2 = new SqlConnection(strConnString);
                    SqlDataAdapter adp2 = new SqlDataAdapter("select * from person", con2);
                    adp2.Fill(ds);
                    report = Server.MapPath("~/people/reports/crystal/Simple1.rpt");
                    rpt.Load(report);
                    rpt.SetDataSource(ds.Tables["Table"]);

                    crv_report.ReportSource = rpt;
                    crv_report.RefreshReport();

                    break;
                case "3":
                    report = Server.MapPath("~/people/reports/crystal/testNoData.rpt");
                    rpt.Load(report);

                    crv_report.ReportSource = rpt;

                    break;
                case "4":

                    //string emailbodyTemplate = "RegisterEmail.xslt";
                    string emailBCC = "greg@datainn.co.nz";
                    string host = "70.35.207.87";
                    string emailfrom = "UnionBoatClub@datainn.co.nz";
                    string emailfromname = "Union Boat Club";
                    string password = "39%3Zxon";
                    Generic.Functions gFunctions = new Generic.Functions();


                    report = Server.MapPath("~/people/reports/crystal/RegattaStatements.rpt");
                    rpt.Load(report);

                    SqlConnection con = new SqlConnection(strConnString);
                    SqlCommand cmd1 = new SqlCommand("get_people_for_statements", con);
                    //cmd1.Parameters.Add("@asatDate", SqlDbType.VarChar).Value = person_id;
                    cmd1.Parameters.Add("@include_zero", SqlDbType.VarChar).Value = "Yes";
                    cmd1.Parameters.Add("@system", SqlDbType.VarChar).Value = "Friends";

                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Connection = con;
                    try
                    {
                        con.Open();
                        SqlDataReader dr = cmd1.ExecuteReader();

                        while (dr.Read())
                        //dr.Read();
                        {
                            SqlConnection con4 = new SqlConnection(strConnString);
                            //ctr = (dr["ctr"] is DBNull) ? 0 : Convert.ToInt32(dr["ctr"]);
                            string person_id = dr["person_id"].ToString();
                            string name = dr["name"].ToString();
                            string invoicerecipient = dr["invoicerecipient"].ToString();
                            string invoiceaddresstype = dr["invoiceaddresstype"].ToString();
                            string invoiceaddress = dr["invoiceaddress"].ToString();
                            decimal balance = (decimal)dr["balance"];

                            SqlDataAdapter adp4 = new SqlDataAdapter("Report_RegattaTransactions", con4);
                            adp4.SelectCommand.CommandType = CommandType.StoredProcedure;
                            adp4.SelectCommand.Parameters.Add("@person_id", SqlDbType.VarChar).Value = person_id;
                            ds.Clear();
                            adp4.Fill(ds);

                            //DataTable dt = ds.Tables["Table"];
                            //Literal1.Text = dt.Rows.Count.ToString();
                            //Response.Write(person_id + "=" + dt.Rows.Count.ToString() + "<br />");

                            rpt.SetDataSource(ds.Tables["Table"]);
                            //crv_report.ReportSource = rpt;

                            string filename = "C:\\inetpub\\ubc.org.nz\\people\\Statement " + name + ".pdf";
                            rpt.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, filename);
                            string[] attachments = new string[0]; 

                            Array.Resize(ref attachments, attachments.Length + 1);
                            attachments[attachments.GetUpperBound(0)] = filename;

                            Dictionary<string, string> functionoptions = new Dictionary<string, string>();
                            //functionoptions.Add("storedprocedure", "");

                            string emailhtml = "<html><head></head><body>";
                            emailhtml += "<p>To: " + invoicerecipient + "</p>";
                            emailhtml += "<p>Please find attached the current statement for " + name + " being regatta fees.</p>";
                            emailhtml += "<p>This statement represents transport, boat transportation, accomodation, meals and other incidentals which are handled by theFriends of UBC.<br />";
                            emailhtml += "Please note this does not include club subs and regatta races fees which are managed through the Club.</p>";
                            if (balance < 0)
                            {
                                emailhtml += "<p>Your account is in credit.  There is nothing to pay</p>";
                            }
                            else if (balance == 0)
                            {
                                emailhtml += "<p>Your account is paid up to date.  There is nothing to pay</p>";
                            }
                            else
                            {
                                emailhtml += "<p>It is payable to the \"Friends of Union Boat Club\" KiwiBank: 38-9018-0421031-00 <br />";
                                emailhtml += "Please use: \"" + name + "\" as the reference.</p>";
                            }
                            emailhtml += "<p>Please contact us at <a href=\"mailto:" + emailfrom + "\">" + emailfrom + "</a> (027) 2495088 if you have any queries.</p>";

                            emailhtml += "</body></html>";

                            string emailto = "";
                            if (invoiceaddresstype == "Email" && invoiceaddress != "")
                            {
                                emailto = invoiceaddress;
                                //emailto = "greg@datainn.co.nz";
                            }
                            else
                            {
                                emailto = "greg@datainn.co.nz";
                            }

                            gFunctions.sendemailV4(host, emailfrom, emailfromname, password, "Friends of Union Boat Club Regattas Statement for " + name, emailhtml, emailto, emailBCC, "", attachments, functionoptions);



                        }
                        dr.Close();
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


                    /*
                                        Dim rptDocument As New CrystalDecisions.CrystalReports.Engine.ReportDocument
                                        Dim crtreport As String = "\\Wdc-pr\t1\Pro1\Rel104\Ci\software\Custom\rts\crystal\crw_us\RAT_Notice_Wanganui2014.rpt"
                                        rptDocument.Load(crtreport)
                                        rptDocument.ReportDefinition.ReportObjects("Logo").ObjectFormat.EnableSuppress = False   'Display Logo
                                        rptDocument.ReportDefinition.Sections("GroupHeaderSection4").SectionFormat.EnableSuppress = True 'Display Back page
                                        rptSubDocument.ReportDefinition.ReportObjects("Logo").ObjectFormat.EnableSuppress = False   'Display Logo
                                        rptSubDocument.ReportDefinition.Sections("GroupFooterSection4").SectionFormat.EnableSuppress = True 'Display Back page
                                        Dim propertyNo As String
                                        Dim headerctr As String
                                        Dim strConnection As String = "Data Source=WDC-PRSQL1;Initial Catalog=proprod;User Id=ratesnotice;Password=ratesnotice; Connection Timeout=30"
                                        Dim cn As SqlConnection = New SqlConnection(strConnection)
                                        cn.Open()
                                        Dim strSelect As String = "SELECT header_ctr, table_no, ref_11 as emailaddress FROM notnoticeheader 
                                        Dim dscmd As New SqlDataAdapter(strSelect, cn)
                                        Dim ds As New DataSet()
                                        dscmd.Fill(ds, "Notices")
                                        cn.Close()
                                        Dim dt As DataTable = ds.Tables.Item("Notices")
                                        Dim rowNotice As DataRow
                                        For Each rowNotice In dt.Rows
                                            headerctr = rowNotice.Item("Header_ctr")
                                            propertyNo = rowNotice.Item("Table_no")
                                            emailaddress = rowNotice.Item("emailaddress").ToString.ToLower
                                            rptDocument.RecordSelectionFormula = " (  {NOTNOTICEDETAIL.HEADER_CTR} = " & headerctr & "  )  "
                                            rptDocument.Refresh()
                                            rptDocument.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, "c:\$RatesEmail\" & propertyNo & ".pdf")
                                            emailaddresses = Split(emailaddress, ";")
                                            For Each seperateemailaddress In emailaddresses
                                                If cb_attachment.Checked = True Then
                                                    SendMail("ratesbyemail@whanganui.govt.nz", seperateemailaddress, txtSubject.Text & "  Property Number: " & propertyNo, txtbody.Text, True, New String() {"C:\$RatesEmail\" & propertyNo & ".pdf"}) ', "smtpsend@whanganui.govt.nz", "wDc!m@1l")
                                                Else
                                                    SendMail("ratesbyemail@whanganui.govt.nz", seperateemailaddress, txtSubject.Text & "  Property Number: " & propertyNo, txtbody.Text, True, New String() {}) ', "smtpsend@whanganui.govt.nz", "wDc!m@1l")
                                                End If
                                            Next
                                        Next
                                        rptDocument.Dispose()
                                        rptSubDocument.Dispose()
                    */

                    /*
                    SqlConnection con4 = new SqlConnection(strConnString);
                    SqlDataAdapter adp4 = new SqlDataAdapter("Report_RegattaTransactions", con4);

                    //adp4.SelectCommand.Parameters.Add("@Par1", SqlDbType.Int).Value = "xxx";

                    adp4.Fill(ds);
                    report = Server.MapPath("~/people/reports/crystal/RegattaStatements.rpt");
                    rpt.Load(report);
                    rpt.SetDataSource(ds.Tables["Table"]);

                    int PageCount4 = rpt.FormatEngine.GetLastPageNumber(new ReportPageRequestContext());

                    Literal1.Text = PageCount4.ToString();

                    ExportOptions CrExportOptions4;
                    DiskFileDestinationOptions CrDiskFileDestinationOptions4 = new DiskFileDestinationOptions();
                    PdfRtfWordFormatOptions CrFormatTypeOptions4 = new PdfRtfWordFormatOptions();
                    CrDiskFileDestinationOptions4.DiskFileName = "C:\\inetpub\\ubc.org.nz\\people\\test.pdf";
                    CrExportOptions4 = rpt.ExportOptions;

                    CrExportOptions4.ExportDestinationType = ExportDestinationType.DiskFile;
                    CrExportOptions4.ExportFormatType = ExportFormatType.PortableDocFormat;
                    CrExportOptions4.DestinationOptions = CrDiskFileDestinationOptions4;

                    if(1==2) {
                    CrFormatTypeOptions4.UsePageRange = true;

                    CrFormatTypeOptions4.FirstPageNumber = 1;
                    CrFormatTypeOptions4.LastPageNumber = 1;
                    }
                    CrExportOptions4.FormatOptions = CrFormatTypeOptions4;

                    rpt.Export();
                    */
                    break;
                default:
                    break;
            }

            //Response.Write(report);

            //int x = ds.Tables["Table"].Rows.Count;
            //Response.Write(x.ToString());

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int PageCount = rpt.FormatEngine.GetLastPageNumber(new ReportPageRequestContext());

            /*
            //Option 1
            for (int f1 = 1; f1 <= 3; f1++)
            {
                Literal1.Text = f1.ToString();
                ExportOptions exportOpts = new ExportOptions();
                DiskFileDestinationOptions CrDiskFileDestinationOptions = new DiskFileDestinationOptions();
                CrDiskFileDestinationOptions.DiskFileName = "C:\\inetpub\\ubc.org.nz\\people\\test" + f1.ToString() + ".pdf";

                PdfRtfWordFormatOptions pdfOpts = ExportOptions.CreatePdfRtfWordFormatOptions();
                pdfOpts.UsePageRange = true;

                exportOpts.ExportFormatType = ExportFormatType.PortableDocFormat;
                exportOpts.DestinationOptions = CrDiskFileDestinationOptions;

                pdfOpts.FirstPageNumber = f1;
                pdfOpts.LastPageNumber = f1;
                exportOpts.ExportFormatOptions = pdfOpts;

                //rpt.ExportToHttpResponse(exportOpts, Response, true, "Crystal" + f1.ToString());
                //rpt.ExportToHttpResponse(exportOpts, Response, false, "");
                rpt.Export();

            }
            */


            /*
                        //Option 2

                        ExportFormatType formatType = ExportFormatType.NoFormat;
                        formatType = ExportFormatType.PortableDocFormat;
                        rpt.ExportToHttpResponse(formatType, Response, true, "Crystal");
            */


            //Option 3


            //string report = Server.MapPath("~/people/reports/crystal/RegattaStatements.rpt");
            //rpt.Load(report);


            for (int f1 = 1; f1 <= 3; f1++)
            {
                ExportOptions CrExportOptions;
                DiskFileDestinationOptions CrDiskFileDestinationOptions = new DiskFileDestinationOptions();
                PdfRtfWordFormatOptions CrFormatTypeOptions = new PdfRtfWordFormatOptions();
                CrDiskFileDestinationOptions.DiskFileName = "C:\\inetpub\\ubc.org.nz\\people\\test" + f1.ToString() + ".pdf";
                CrExportOptions = rpt.ExportOptions;


                CrExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
                CrExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
                CrExportOptions.DestinationOptions = CrDiskFileDestinationOptions;
                CrFormatTypeOptions.UsePageRange = true;


                CrFormatTypeOptions.FirstPageNumber = f1;
                CrFormatTypeOptions.LastPageNumber = f1;

                CrExportOptions.FormatOptions = CrFormatTypeOptions;

                rpt.Export();
            }

        }
    }
}
