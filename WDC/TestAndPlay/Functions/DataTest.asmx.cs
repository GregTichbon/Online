using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Web.Script.Serialization;

namespace Online.TestAndPlay.Functions
{
    /// <summary>
    /// Summary description for DataTest
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class DataTest : System.Web.Services.WebService
    {

        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void TestMethodGet()
        {

            if (1 == 2)
            {
                List<TestList> resultlist = new List<TestList>();

                resultlist.Add(new TestList
                {
                    id = "1",
                    value = "Brown"
                });
                resultlist.Add(new TestList
                {
                    id = "2",
                    value = "Black"
                });
                resultlist.Add(new TestList
                {
                    id = "3",
                    value = "Blue"
                });
                resultlist.Add(new TestList
                {
                    id = "4",
                    value = "Red"
                });
                resultlist.Add(new TestList
                {
                    id = "5",
                    value = "White"
                });

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultlist);

                Context.Response.Write(passresult);
            }
            else
            {
                TestClass resultclass = new TestClass();
                resultclass.id = "ID";

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultclass);

                Context.Response.Write(passresult);
            }
        }


        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string TestMethodPost(NameValue[] formVars)   //                                                        No methods work with the params in here
        {
            if (1 == 2)
            {
                List<TestList> resultlist = new List<TestList>();

                resultlist.Add(new TestList
                {
                    id = "1",
                    value = "Brown"
                });
                resultlist.Add(new TestList
                {
                    id = "2",
                    value = "Black"
                });
                resultlist.Add(new TestList
                {
                    id = "3",
                    value = "Blue"
                });
                resultlist.Add(new TestList
                {
                    id = "4",
                    value = "Red"
                });
                resultlist.Add(new TestList
                {
                    id = "5",
                    value = "White"
                });

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultlist);

                return (passresult);

            }
            else
            {
                TestClass resultclass = new TestClass();

                resultclass.id = formVars.Form("Text1");

                JavaScriptSerializer JS = new JavaScriptSerializer();
                string passresult = JS.Serialize(resultclass);

                return (passresult);
            }
        }

    }

    #region classes
    public class NameValue
    {
        public string name { get; set; }
        public string value { get; set; }
    }

    public class TestClass
    {
        public string id;
    }

    public class TestList
    {
        public string id;
        public string value;
    }

    #endregion

    public static class NameValueExtensionMethods
    {
        /// <summary>
        /// Retrieves a single form variable from the list of
        /// form variables stored
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">formvar to retrieve</param>
        /// <returns>value or string.Empty if not found</returns>
        public static string Form(this  NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).FirstOrDefault();
            if (matches != null)
                return matches.value;
            return string.Empty;
        }

        /// <summary>
        /// Retrieves multiple selection form variables from the list of 
        /// form variables stored.
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">The name of the form var to retrieve</param>
        /// <returns>values as string[] or null if no match is found</returns>
        public static string[] FormMultiple(this  NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.name.ToLower() == name.ToLower()).Select(nv => nv.value).ToArray();
            if (matches.Length == 0)
                return null;
            return matches;
        }
    }
}
