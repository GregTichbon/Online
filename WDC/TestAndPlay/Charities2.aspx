<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Charities2.aspx.cs" Inherits="Online.TestAndPlay.Charities2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="<%: ResolveUrl("~/Scripts/odatajs/odatajs-4.0.0.min.js")%>"></script>
    <script type="text/javascript">

        $(document).ready(function () {

            $('#btn_submit').click(function () {

                //var serviceRoot = 'http://services.odata.org/V3/Northwind/Northwind.svc/Regions';
                var serviceRoot = 'http://www.odata.charities.govt.nz/Organisations(52384)';
                var headers = { 'Content-Type': 'application/json', Accept: 'application/json' };
                var request = {
                    requestUri: serviceRoot,
                    method: 'GET',
                    headers: headers,
                    data: null
                };
                odatajs.oData.request(
                    request,
                    function (data, response) {
                        var people = data.value;
                    },
                    function (err) {
                        alert('Fail: ' + err.Message);
                    }
                );
            });
        });

    </script>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input type="button" id="btn_submit" class="btn btn-info submit" value="Submit" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
