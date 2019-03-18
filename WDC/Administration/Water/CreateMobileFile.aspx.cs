using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;



namespace Online.Administration.Water
{
    public partial class CreateMobileFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string line = "Sequence,RouteNo,PeopertyNo,AccountNo,Address,MeterLocation,UnitofReading,MeterType,LastReading,LastReadingDate";
            Response.Write(line + "<br />");
            var xmlDoc = new XmlDocument();
            xmlDoc.Load(@"C:\_GregDevelopment\OnlineServices\Online\Online\Administration\Water\ExportedfromPandR.xml");

            XmlNodeList ReadingProcessList = xmlDoc.SelectNodes("/ReadingProcesses/ReadingProcess");

            foreach (XmlNode ReadingProcessNode in ReadingProcessList)
            {
                line = "";
                //Response.Write(ReadingProcessNode.Attributes["Key"].Value + "<br />");
                //Response.Write(ReadingProcessNode["ReadingProcessId"].InnerText + "<br />");

                XmlNodeList RouteList = ReadingProcessNode.SelectNodes("Routes/Route");

                foreach (XmlNode RouteNode in RouteList)
                {
                   // Response.Write("---" + RouteNode.Attributes["Key"].Value + "<br />");
                    //Response.Write("---" + RouteNode["RouteID"].InnerText + "<br />");

                    XmlNodeList ConnectionList = RouteNode.SelectNodes("Connections/Connection");

                    foreach (XmlNode ConnectionNode in ConnectionList)
                    {
                        line = ConnectionNode["Sequence"].InnerText
                            + "," + ConnectionNode["RouteNo"].InnerText
                            + "," + ConnectionNode["PropertyNo"].InnerText
                            + "," + ConnectionNode["AccountNumber"].InnerText
                            + "," + ConnectionNode["Address"].InnerText
                            + ",\"" + ConnectionNode["MeterLocation"].InnerText + "\""
                            + "," + ConnectionNode["UnitOfRecording"].InnerText;

                        /*
                        Response.Write("------" + ConnectionNode["Sequence"].InnerText + "<br />");
                        Response.Write("------" + ConnectionNode["RouteNo"].InnerText + "<br />");
                        Response.Write("------" + ConnectionNode["PropertyNo"].InnerText + "<br />");
                        Response.Write("------" + ConnectionNode["AccountNumber"].InnerText + "<br />");
                        Response.Write("------" + ConnectionNode["Address"].InnerText + "<br />");
                        Response.Write("------" + ConnectionNode["MeterLocation"].InnerText + "<br />");
                        Response.Write("------" + ConnectionNode["UnitOfRecording"].InnerText + "<br />");
                        */

                        XmlNodeList ReadingList = ConnectionNode.SelectNodes("Readings/Reading");

                        foreach (XmlNode ReadingNode in ReadingList)
                        {
                            line += "," + ReadingNode["MeterNo"].InnerText
                                + "," + ReadingNode["MeterType"].InnerText
                                + "," + ReadingNode["LastReading"].InnerText
                                + "," + ReadingNode["LastReadingDate"].InnerText;

                            /*
                            Response.Write("---------" + ReadingNode["MeterNo"].InnerText + "<br />");
                            Response.Write("---------" + ReadingNode["MeterType"].InnerText + "<br />");
                            Response.Write("---------" + ReadingNode["LastReading"].InnerText + "<br />");
                            Response.Write("---------" + ReadingNode["LastReadingDate"].InnerText + "<br />");
                            */
                        }

                        XmlNodeList MeterList = ConnectionNode.SelectNodes("Meters/Meter");

                        foreach (XmlNode MeterNode in MeterList)
                        {

                        }
                        Response.Write(line + "<br />");

                    }
                }
            }
        }


        /*
        using (XmlReader reader = XmlReader.Create(@"C:\_GregDevelopment\OnlineServices\Online\Online\Administration\Water\ExportedfromPandR.xml"))
        {
            while (reader.Read())
            {
                if (reader.IsStartElement())
                {
                    switch (reader.Name.ToString())
                    {
                        case "ReadingProcess":
                            Response.Write("Name of the Element is : " + reader.ReadString());
                            break;
                        case "ReadingProcessId":
                            Response.Write("Your Location is : " + reader.ReadString());
                            break;
                    }
                }
                Response.Write("<br />");
            }
        }
        */
                            /*

                            string line;
                            Int32 propertyid = 0;
                            string address = "";
                            string meter = "";
                            System.IO.StreamReader file = new System.IO.StreamReader(@"C:\_GregDevelopment\OnlineServices\Online\Online\Administration\Water\ExportedfromPandR.txt");
                            while ((line = file.ReadLine()) != null)
                            {
                                if (line.StartsWith("MR2"))
                                {
                                    propertyid = Convert.ToInt32(line.Substring(10, 10));
                                    address = line.Substring(80, 32);
                                }
                                else if (line.StartsWith("MR3"))
                                {
                                    meter = line.Substring(15, 15);
                                }
                                if(meter != "")
                                {
                                    Response.Write(propertyid.ToString() + " | " + address + " | " + meter + "<br />");
                                    meter = "";
                                }
                            }


                            */
                        }

                    }