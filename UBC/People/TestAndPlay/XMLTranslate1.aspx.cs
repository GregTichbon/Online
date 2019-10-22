using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Xsl;

namespace UBC.People.TestAndPlay
{
    public partial class XMLTranslate1 : System.Web.UI.Page
    {
        public string html = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string rootXml = @"<root>
  <hf_guid>new</hf_guid>
  <firstname>firstname</firstname>
  <lastname>lastname</lastname>
  <gender>Male</gender>
  <birthdate>1 Jan 2011</birthdate>
  <school>Girls College</school>
  <schoolyear>13</schoolyear>
  <medical>medical</medical>
  <dietary>dietary</dietary>
  <emailaddress>greg@datainn.co.nz</emailaddress>
  <residentialaddress>residentialaddress</residentialaddress>
  <swimmer>I CAN NOT swim 50 meters in light clothes unassisted</swimmer>
  <invoicerecipient>invoicerecipient</invoicerecipient>
  <invoicetype>Hand deliver</invoicetype>
  <invoiceaddress>invoiceaddress</invoiceaddress>
  <invoicenote>invoicenote</invoicenote>
  <membershiptype>Gym Membership Only</membershiptype>
  <familydiscount>Yes</familydiscount>
  <previousclub>previousclub</previousclub>
  <boatinstorage>Yes</boatinstorage>
  <agreement>Yes</agreement>
  <correspondence>Yes</correspondence>
  <PhoneRepeater>
    <Phone>
      <number>repeat_phone_number_1</number>
      <type>Other</type>
      <note>repeat_phone_note_1</note>
      <number>repeat_parent_phone_number_1_1</number>
      <type>Other</type>
      <note>repeat_parent_phone_note_1_1</note>
    </Phone>
    <Phone>
      <number>repeat_phone_number_2</number>
      <type>Other</type>
      <note>repeat_phone_note_2</note>
      <number>repeat_parent_phone_number_2_2</number>
      <type>Other</type>
      <note>repeat_parent_phone_note_2_2</note>
    </Phone>
    <Phone>
      <number>repeat_phone_number_3</number>
      <type>Other</type>
      <note>repeat_phone_note_3</note>
      <number>repeat_parent_phone_number_1_3</number>
      <type>Other</type>
      <note>repeat_parent_phone_note_1_3</note>
    </Phone>
  </PhoneRepeater>
  <ParentRepeater>
    <Parent>
      <name>repeat_parent_name_1</name>
      <relationship>Other</relationship>
      <email>repeat_parent_email_1</email>
      <note>repeat_parent_note_1</note>
      <Phone>
        <number>repeat_parent_phone_number_1_1</number>
        <type>Other</type>
        <note>repeat_parent_phone_note_1_1</note>
      </Phone>
      <Phone>
        <number>repeat_parent_phone_number_1_3</number>
        <type>Other</type>
        <note>repeat_parent_phone_note_1_3</note>
      </Phone>
      <Phone>
        <number>repeat_parent_phone_number_1_4</number>
        <type>Other</type>
        <note>repeat_parent_phone_note_1_4</note>
      </Phone>
    </Parent>
    <Parent>
      <name>repeat_parent_name_2</name>
      <relationship>Other</relationship>
      <email>repeat_parent_email_2</email>
      <note>repeat_parent_note_2</note>
      <Phone>
        <number>repeat_parent_phone_number_2_2</number>
        <type>Other</type>
        <note>repeat_parent_phone_note_2_2</note>
      </Phone>
      <Phone>
        <number>repeat_parent_phone_number_2_5</number>
        <type>Other</type>
        <note>repeat_parent_phone_note_2_5</note>
      </Phone>
      <Phone>
        <number>repeat_parent_phone_number_2_6</number>
        <type>Other</type>
        <note>repeat_parent_phone_note_2_6</note>
      </Phone>
    </Parent>
  </ParentRepeater>
</root>";

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(rootXml);

            string firstname = doc.SelectSingleNode("/root/firstname").InnerText;

            XmlNodeList x1 = doc.SelectNodes("/root/PhoneRepeater/Phone");
            foreach(XmlNode x2 in x1)
            {

                string x3 = x2.InnerText;
            }

            /*
            foreach(XElement step in doc.SelectNodes)
{
                // Start looping through that step's checks
                foreach (XElement substep in step.Elements())
                {
                    Console.WriteLine(step.Attribute("Name").Value + ""
                                    + substep.Attribute("Name").Value);
                }
            }


            XmlNode rootNode = doc.DocumentElement;
            XmlNodeList children = rootNode.ChildNodes;
            foreach (XmlNode child in children)


                foreach (XmlNodeList node in doc.DocumentElement.SelectNodes("/root/PhoneRepeater"))
            {
                // output the group name
                Console.WriteLine("Request: " + el.Name);
                foreach (XElement fields in el.Elements("Fields"))
                {
                    foreach (XElement group in fields.Elements("Group"))
                    {
                        //output = group.Attribute("name").Value.ToString();
                        foreach (XElement field in group.Elements("Phone"))
                        {
                            Console.WriteLine(field.Element("Name").Value);
                        }
                    }
                }
            }

    */

            string emailbodyTemplate = "RegisterEmail.xslt";

            string path = Server.MapPath(".");
            XmlDocument reader = new XmlDocument();
            reader.LoadXml(rootXml.ToString());

            XslCompiledTransform EmailXslTrans = new XslCompiledTransform();
            //EmailXslTrans.Load(path + "\\" + emailbodyTemplate);
            EmailXslTrans.Load(@"C:\Users\gtichbon\Source\Repos\Online\UBC\People\" + emailbodyTemplate);

            StringBuilder EmailOutput = new StringBuilder();
            TextWriter EmailWriter = new StringWriter(EmailOutput);

            EmailXslTrans.Transform(reader, null, EmailWriter);
            string emailbodydocument = EmailOutput.ToString();

            html = emailbodydocument;






        }
    }
}