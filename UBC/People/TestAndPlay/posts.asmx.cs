using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Services;

namespace UBC.People.TestAndPlay
{
    /// <summary>
    /// Summary description for Data
    /// </summary>
    /// GREG [WebService(Namespace = "http://tempuri.org/")]
    /// GREG [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    /// GREG [System.ComponentModel.ToolboxItem(false)]
    /// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]   //GREG  -  THIS IS REQUIRED FOR POSTS
    public class posts : System.Web.Services.WebService
    {

        [WebMethod]
        public standardResponseID test()    //you can't pass any querystring params
        {
            Thread.Sleep(2000);
            string now = DateTime.Now.ToString("hh:mm:ss.fff");
            standardResponseID resultclass = new standardResponseID();
            resultclass.status = now;
            resultclass.message = "";
            resultclass.id = "";

            return (resultclass);

        }


    }
}
