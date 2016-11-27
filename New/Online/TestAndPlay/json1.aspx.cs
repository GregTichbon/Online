using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Xml.Linq;


namespace Online.TestAndPlay
{
    public partial class json1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string val;
            Dictionary<string, string> testdict = new Dictionary<string, string>();

            XElement myXml = new XElement("paramList");


            foreach (string key in Request.Form)
            {
                if (key.Substring(0, 2) != "__"  && key.Substring(0,3) != "ctl")
                {
                    val = Request.Form[key];
                    testdict[key] = Request.Form[key];

                     myXml.Add(
                               new XElement(key, Request.Form[key])
                     );

               }
            }

            //XElement xml = new XElement("Root", from keyValue in testdict select new XElement(keyValue.Key, keyValue.Value) );

            myXml.Add(
                      new XElement("test", myXml)
            );



            string json = JsonConvert.SerializeObject(testdict);

        }


        /*
DECLARE @x xml;
SET @x='
<vehicles>
	<licensePlate>ABC123</licensePlate>
	<vehicle>
	  <model>Ford</model>
	  <color>Blue</color>
	  <carPool>
		 <employee>
			<empID>111</empID>
		 </employee>
		 <employee>
			<empID>222</empID>
		 </employee>
		 <employee>
			<empID>333</empID>
		 </employee>
	  </carPool>
	</vehicle>
	<vehicle>
	  <model>Ford</model>
	  <color>Blue</color>
	  <carPool>
		 <employee>
			<empID>111</empID>
		 </employee>
		 <employee>
			<empID>222</empID>
		 </employee>
		 <employee>
			<empID>333</empID>
		 </employee>
	  </carPool>
	</vehicle>	
	<driver>
		<name>Bob</name>
	</driver>
	<driver>
		<name>Bruce</name>
	</driver>
	
</vehicles>
'

SELECT  vehicles.x2.value('color[1]', 'VARCHAR(100)') as 'color',
        vehicles.x2.value('model[1]', 'VARCHAR(100)') as 'model',
        vehicles.x2.value('../licensePlate[1]', 'VARCHAR(100)') as 'licensePlate',
        GETDATE(),
        vehicles.x2.query('./carPool')
FROM   @x.nodes('/vehicles/vehicle') AS vehicles(x2)


SELECT  drivers.x2.value('name[1]', 'VARCHAR(100)') as 'name',
        GETDATE(),
        drivers.x2.query('./carPool')
FROM   @x.nodes('/vehicles/driver') AS drivers(x2)


SELECT  drivers.x2.value('licensePlate[1]', 'VARCHAR(100)') as 'name'
FROM   @x.nodes('/vehicles') AS drivers(x2)
*/



    }
}