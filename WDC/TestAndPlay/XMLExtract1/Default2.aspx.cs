using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

namespace Online.TestAndPlay.XMLExtract1
{
    public partial class Default2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = Server.MapPath(".");
            XmlDataDocument xmldoc = new XmlDataDocument();
            //XmlNodeList xmlnode;
            int i = 0;
            //int f1;
            string str = null;
            FileStream fs = new FileStream(path + "\\products.xml", FileMode.Open, FileAccess.Read);
            xmldoc.Load(fs);



            string xpath;
            xpath = "XML/Section[count(ancestor::node())=1]";  //nothing
            xpath = "XML/Section[count(ancestor::*)=1]";  //all
            xpath = "XML/Section[not(ancestor::XML/Section)]";  //nothing
            xpath = "//Section[not(ancestor::Section)]";  //all

            xpath = "//Section[not(parent::Section)]";  //all
            xpath = "XML/Section";
            xpath = "XML/Section[parent::XML]";

            XmlNodeList xnList = xmldoc.SelectNodes(xpath);

            foreach (XmlNode xn in xnList)
            {
                str += "<br />" + xn.InnerXml + "|" + xn.ParentNode.Name;

            }


            /*
            XmlNodeList xnList = xmldoc.SelectNodes("//*");
            foreach (XmlNode xn in xnList)
            {
                XmlNode anode = xn.SelectSingleNode("ANode");
                if (anode != null)
                {
                    string id = anode["ID"].InnerText;
                    string date = anode["Date"].InnerText;
                    XmlNodeList CNodes = xn.SelectNodes("ANode/BNode/CNode");
                    foreach (XmlNode node in CNodes)
                    {
                        XmlNode example = node.SelectSingleNode("Example");
                        if (example != null)
                        {
                            string na = example["Name"].InnerText;
                            string no = example["NO"].InnerText;
                        }
                    }
                }
            }
            */

            /*

                xmlnode = xmldoc.GetElementsByTagName("Section");

            XmlNode firstnode = xmldoc.FirstChild;

            
            for (i = 0; i <= xmlnode.Count - 1; i++)
            {
                for(f1 = 0; f1< xmlnode[i].ChildNodes.Count; f1++)
                {
                    str = xmlnode[i].ChildNodes.Item(f1).InnerText;
                }
                xmlnode[i].ChildNodes.Item(0).InnerText.Trim();
                str = xmlnode[i].ChildNodes.Item(0).InnerText.Trim();
                //MessageBox.Show(str);
            }
            */
            /*

            xmlnode = xmldoc.GetElementsByTagName("Product");
            for (i = 0; i <= xmlnode.Count - 1; i++)
            {
                xmlnode[i].ChildNodes.Item(0).InnerText.Trim();
                str = xmlnode[i].ChildNodes.Item(0).InnerText.Trim() + "  " + xmlnode[i].ChildNodes.Item(1).InnerText.Trim() + "  " + xmlnode[i].ChildNodes.Item(2).InnerText.Trim();
                //MessageBox.Show(str);
            }
            */

            Label1.Text = str;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
          
        }
    }
}