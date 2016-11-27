using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using Microsoft.SharePoint.Client;
using System.Net;
using System.Security;



namespace Online.WDCFunctions
{
    /// <summary>
    /// Note you may need to reference the following items in your project
    /// Microsoft.SharePoint.Client
    /// Microsoft.SharePoint.Client.Runtime
    /// </summary>
    /// 
    public class HubbleFunctions
    {
        /// <summary>
        /// Using credential of this wdc-nt user 
        /// use name will show in hubble
        /// </summary>
        /// <returns>Network credential item</returns>
        private static NetworkCredential credentials()
        {
            SecureString passWord = new SecureString();
            foreach (char c in "Wanganui15".ToCharArray()) passWord.AppendChar(c);
            return new NetworkCredential("MobileApp", passWord, "wdc-nt");
        }


        /********************usage**********************************************************
         * spHubble = new SPHubble();
         * spHubble.UploadFile(siteURL, listName, listURL, fileName, file);
        **************************************************************************************/
        /// <summary>
        /// Save Item into hubble list
        /// </summary>
        /// <param name="siteURL">hubble Top most site</param>
        /// <param name="listName">hubble list name</param>
        /// <param name="listURL">hubble Url from site to list</param>
        /// <param name="itemName">item hubble name</param>
        /// <param name="itembytes">item to saved into hubble</param>
        public void UploadFile(string siteURL, string listName, string listURL, string itemName, byte[] itembytes)
        {
            using (ClientContext clientContext = new ClientContext(siteURL))
            {
                clientContext.Credentials = HubbleFunctions.credentials();
                List documentsList = clientContext.Web.Lists.GetByTitle(listName);//Get Document List

                var fileCreationInformation = new FileCreationInformation();
                fileCreationInformation.Content = itembytes;                    //Assign to content byte[] i.e. documentStream
                fileCreationInformation.Overwrite = true;                       //Allow owerwrite of document
                fileCreationInformation.Url = siteURL + listURL + itemName;     //Upload URL

                Microsoft.SharePoint.Client.File uploadFile = documentsList.RootFolder.Files.Add(fileCreationInformation);

                //Update the metadata for a field having name "DocType"
                uploadFile.ListItemAllFields["DocumentType"] = "APPLICATION, certificate, consent related";
                uploadFile.ListItemAllFields.Update();
                clientContext.ExecuteQuery();
            }
        }


        /*******to user************************************************************************
        existsInSmartList(Program.urlSite(), "List of Applications", "bl0000-1234");
        **************************************************************************************/
        /// <summary>
        /// check exists
        /// </summary>
        /// <param name="url"></param>
        /// <param name="listTitle">List of Applications</param>
        /// <param name="listItem">folder item</param>
        public bool existsInSmartList(string url, string listTitle, string listItem)
        {
            using (ClientContext clientContext = new ClientContext(url))
            {
                clientContext.Credentials = HubbleFunctions.credentials();
                List wList = clientContext.Web.Lists.GetByTitle(listTitle);
                try
                {
                    clientContext.Load(wList);
                    clientContext.ExecuteQuery();
                }
                catch (Exception ex)
                {
                    throw new Exception("Err from 'existsInSmartList', loading list Title: " + listTitle, ex);
                    WDCFunctions.Log("Hubble: existsInSmartList", ex.Message, "greg.tichbon@whanganui.govt.nz");
                }
                // CamlQuery query = CamlQuery.CreateAllItemsQuery(100);
                CamlQuery query = new CamlQuery();//<FieldRef Name='" + listTitle + @"'/><Eq></Eq>  or<leq>?
                query.ViewXml = @"<View><Query>
                                    <Where>
                                        <Eq>
                                            <FieldRef Name='Title' />
                                            <Value Type='text'>" + listItem + @"</Value>
                                        </Eq>
                                    </Where>     
                                    </Query></View>";  //gets the one smartlist item

                ListItemCollection items = wList.GetItems(query);
                clientContext.Load(items);
                clientContext.ExecuteQuery();

                //foreach(ListItem aListItem in items) {
                //    Console.WriteLine("title:{0},     propNo:{1}       status:{2}      narr:{3}"
                //        , aListItem["Title"]
                //        // , listItem["ApplicationNo"] //calculated
                //        , aListItem["PropertyNo"]
                //        , aListItem["SFStatus"]
                //        , aListItem["Narrative"]
                //        );
                //}
                return items.Count > 0;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="siteUrl"></param>
        /// <param name="appId"></param>
        /// <param name="propId"></param>
        /// <param name="year"></param>
        /// <param name="narrative"></param>
        public void createSmartListItem(string siteUrl, string appId, int propId, string year, string narrative)
        {

            // Starting with ClientContext, the constructor requires a URL to the site with the list
            using (ClientContext context = new ClientContext(siteUrl))
            
            {
                context.Credentials = HubbleFunctions.credentials();
                List smartList = context.Web.Lists.GetByTitle("List of Applications");

                // We are just creating a regular list item, so we don't need to 
                // set any properties. If we wanted to create a new folder, for 
                // example, we would have to set properties such as 
                // UnderlyingObjectType to FileSystemObjectType.Folder. 
                ListItemCreationInformation itemCreateInfo = new ListItemCreationInformation();
                ListItem newItem = smartList.AddItem(itemCreateInfo);
                newItem["Title"] = appId;
                newItem["PropertyNo"] = propId.ToString();
                newItem["SFStatus"] = year;
                newItem["Narrative"] = narrative;
                newItem.Update();

                context.ExecuteQuery();
            }
        }


        public void createFolder(string siteurl, string listname, string newfolderurl)
        {
            //eg: createFolder("http://hubbletest/site/ehlthapps", "2014", "XX2015-Greg1")
            //SPWebService spSev = new SPWebService();
            using (var ctx = new ClientContext(siteurl))
            {
                ctx.Credentials = HubbleFunctions.credentials();
                var folder = CreateFolder(ctx.Web, listname, newfolderurl);
            }
        }

        /// <summary>
        /// Create Folder client object
        /// </summary>
        /// <param name="web"></param>
        /// <param name="listTitle"></param>
        /// <param name="fullFolderUrl"></param>
        /// <returns></returns>
        private Folder CreateFolder(Web web, string listTitle, string fullFolderUrl)
        {
            if (string.IsNullOrEmpty(fullFolderUrl))
                throw new ArgumentNullException("fullFolderUrl");
            var list = web.Lists.GetByTitle(listTitle);
            return CreateFolderInternal(web, list.RootFolder, fullFolderUrl);
        }


        private Folder CreateFolderInternal(Web web, Folder parentFolder, string fullFolderUrl)
        {
            var folderUrls = fullFolderUrl.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries);
            string folderUrl = folderUrls[0];
            var curFolder = parentFolder.Folders.Add(folderUrl);
            web.Context.Load(curFolder);
            web.Context.ExecuteQuery();

            if (folderUrls.Length > 1)
            {
                var subFolderUrl = string.Join("/", folderUrls, 1, folderUrls.Length - 1);
                return CreateFolderInternal(web, curFolder, subFolderUrl);
            }
            return curFolder;
        }


    }
}