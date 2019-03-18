using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Xml;

using System.Xml.Linq;
using System.Data.SqlTypes;
using System.Data;

namespace Online.TestAndPlay
{
    public partial class xml1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            XElement rootXml = new XElement("root");

            rootXml.Add(new XElement("A", "A"));
            rootXml.Add(new XElement("B", "B"));

            for (int i = 1; i <= 5; i++)
            {
                XElement subXml = new XElement("sub" + i);
                subXml.Add(new XElement("S1", "1"));
                subXml.Add(new XElement("S2", "2"));

            }

            //rootXml.Add(subXml);

            //rootXml.Elements();

            //IEnumerable<XElement> childElements =
            //    from el in rootXml.Elements()
            //    select el;
            //foreach (XElement el in childElements)
            //    Console.WriteLine("Name: " + el.Name);


            string myxml = rootXml.ToString();

            Response.Write(myxml);

        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            XmlDocument doc = new XmlDocument();
            XmlNode docNode = doc.CreateXmlDeclaration("1.0", "UTF-8", null);
            doc.AppendChild(docNode);

            XmlNode sitesNode = doc.CreateElement("sites");
            doc.AppendChild(sitesNode);


            XmlNode siteNode = doc.CreateElement("site");
            XmlAttribute siteAttribute = doc.CreateAttribute("siteid");
            siteAttribute.Value = "01";
            siteNode.Attributes.Append(siteAttribute);
            sitesNode.AppendChild(siteNode);

            XmlNode nameNode = doc.CreateElement("Name");
            nameNode.AppendChild(doc.CreateTextNode("Java"));
            siteNode.AppendChild(nameNode);
            XmlNode priceNode = doc.CreateElement("Price");
            priceNode.AppendChild(doc.CreateTextNode("Free"));
            siteNode.AppendChild(priceNode);

            // Create and add another site node.
            siteNode = doc.CreateElement("site");
            siteAttribute = doc.CreateAttribute("id");
            siteAttribute.Value = "02";
            siteNode.Attributes.Append(siteAttribute);
            sitesNode.AppendChild(siteNode);

            nameNode = doc.CreateElement("Name");
            nameNode.AppendChild(doc.CreateTextNode("C#"));
            siteNode.AppendChild(nameNode);
            priceNode = doc.CreateElement("Price");
            priceNode.AppendChild(doc.CreateTextNode("Free"));
            siteNode.AppendChild(priceNode);

            doc.Save(Console.Out);

        }

        protected void Unnamed3_Click(object sender, EventArgs e)
        {

            List<string> testdata = new List<string>();
            testdata.Add("site|1|field1|value1");
            testdata.Add("site|1|field2|value2");
            testdata.Add("site|2|field1|value1");
            testdata.Add("site|2|field2|value2");
            testdata.Add("site|2|field3|value3");
            testdata.Add("owner|1|field1|value1");
            testdata.Add("owner|1|field2|value2");
            testdata.Add("owner|2|field1|value1");

            DataTable repeatertable = new DataTable("Repeater");
            repeatertable.Columns.Add("Name", typeof(string));
            repeatertable.Columns.Add("Index", typeof(int));
            repeatertable.Columns.Add("Field", typeof(string));
            repeatertable.Columns.Add("Value", typeof(string));

            foreach (string line in testdata)
            {
                string[] linevals = line.Split('|');
                repeatertable.Rows.Add(linevals[0], linevals[1], linevals[2], linevals[3]);
            }

            XElement rootXml = new XElement("root");
            rootXml.Add(new XElement("Test", "Test Value"));

            DataView dv2 = new DataView(repeatertable);
            DataTable dvSites = dv2.ToTable(true, "Name");
            foreach (DataRow siterow in dvSites.Rows)
            {
                XElement repeaterXml = new XElement(siterow["Name"].ToString() + "Repeater");

                Response.Write(siterow["Name"] + "<br />");


                string sel = "[Name] = '" + siterow["Name"] + "'";
                DataView dv3 = new DataView(repeatertable, sel, "", DataViewRowState.CurrentRows);
                DataTable dvindexess = dv3.ToTable(true, "Index");
                foreach (DataRow indexrow in dvindexess.Rows)
                {
                    XElement subXml = new XElement(siterow["Name"].ToString());

                    Response.Write(" - " + indexrow["Index"] + "<br />");
                    subXml.Add(new XElement(siterow["Name"].ToString() + "Index", indexrow["Index"].ToString()));

                    sel = "[Name] = '" + siterow["Name"] + "' AND [Index] = '" + indexrow["Index"] + "'";
                    DataView dv4 = new DataView(repeatertable, sel, "", DataViewRowState.CurrentRows);
                    DataTable dvfields = dv4.ToTable();
                    foreach (DataRow fieldrow in dvfields.Rows)
                    {
                        Response.Write(" - - " + fieldrow["Field"] + " = " + fieldrow["Value"] + "<br />");
                        subXml.Add(new XElement(fieldrow["Field"].ToString(), fieldrow["Value"].ToString()));

                    }
                    repeaterXml.Add(subXml);
                }
                rootXml.Add(repeaterXml);
            }



            Response.Write(rootXml.CreateReader().ToString());


            /*
ROOT
    values
    SITEREPEATER
        SITE
            values
        </SITE>
        SITE
            values
        </SITE>
    </SITEREPEATER>    
</ROOT>
             */






        }


        public class repeater
        {
            public string name;
            public string index;
            public string fields;

        }
    }
}