using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Script.Serialization;

namespace Online.TestAndPlay
{
    public partial class nestedclass1 : System.Web.UI.Page
    {
        public string json;
        protected void Page_Load(object sender, EventArgs e)
        {
            var Addresslist = new List<AddressClass> {
                new AddressClass {
                    Address = "A"
                },                
                new AddressClass {
                    Address = "B"
                }
            };
            var Personlist = new List<PersonClass> 
            {
                new PersonClass {  
                    Name = "Name1", 
                    Age = 11, 
                    //How do I add AddressList to this Person????
                    
                    //,Hobby = new List<string> { "h1", "h2" }
                },
                new PersonClass {  
                    Name = "Name2", 
                    Age = 22, 
                    Address = new AddressClass { Address = "ca2" }
                    //,Hobby = new List<string> { "h3", "h3" }
                },
            };
            json = new JavaScriptSerializer().Serialize(Personlist);
            //Response.Write(json);
        }
    }
    public class PersonClass
    {
        public string Name;
        public int Age;
        public AddressClass Address;
        //public List<string> Hobby { get; set; }
    }
    public class AddressClass
    {
        public string Address;
    }
}