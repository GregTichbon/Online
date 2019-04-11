<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SPJS1.aspx.cs" Inherits="Online.TestAndPlay.SPJS1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  

    <script
        src="//ajax.aspnetcdn.com/ajax/4.0/1/MicrosoftAjax.js"
        type="text/javascript">
    </script>
    <script
        type="text/javascript"
        src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js">
    </script>
    <script type="text/javascript">

        //https://docs.microsoft.com/en-us/sharepoint/dev/sp-add-ins/complete-basic-operations-using-javascript-library-code-in-sharepoint
        var hostweburl = 'http://hubbletest.wanganui.govt.nz';

        // Load the required SharePoint libraries.
        $(document).ready(function () {

            // Get the URI decoded URLs.
            hostweburl =
                decodeURIComponent(hostweburl
                );
            // getQueryStringParameter("SPHostUrl")


            // The js files are in a URL in the form:
            // web_url/_layouts/15/resource_file
            var scriptbase = hostweburl + "/_layouts/15/";

            // Load the js files and continue to
            // the execOperation function.
            $.getScript(scriptbase + "SP.Runtime.js",
                function () {
                    $.getScript(scriptbase + "SP.js", execOperation);
                }
            );
        });

        // Function to execute basic operations.
        function execOperation() {

            retrieveWebSite(hostweburl);
            // Continue your program flow here.

        }

        function retrieveWebSite(siteUrl) {
            var clientContext = new SP.ClientContext(siteUrl);
            this.oWebsite = clientContext.get_web();

            clientContext.load(this.oWebsite);

            clientContext.executeQueryAsync(
                Function.createDelegate(this, this.onQuerySucceeded),
                Function.createDelegate(this, this.onQueryFailed)
            );
        }

        function onQuerySucceeded(sender, args) {
            alert('Title: ' + this.oWebsite.get_title() +
                ' Description: ' + this.oWebsite.get_description());
        }

        function onQueryFailed(sender, args) {
            alert('Request failed. ' + args.get_message() +
                '\n' + args.get_stackTrace());
        }

        // Function to retrieve a query string value.
        // For production purposes you may want to use
        // a library to handle the query string.
        function getQueryStringParameter(paramToRetrieve) {
            var params =
                document.URL.split("?")[1].split("&amp;");
            var strParams = "";
            for (var i = 0; i < params.length; i = i + 1) {
                var singleParam = params[i].split("=");
                if (singleParam[0] == paramToRetrieve)
                    return singleParam[1];
            }
        }
    </script>



</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
