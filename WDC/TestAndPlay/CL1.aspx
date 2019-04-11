<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CL1.aspx.cs" Inherits="Online.TestAndPlay.CL1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .group {
            font-size:x-large;
            color:deeppink;
        }
        
    </style>
 <script type="text/javascript">

     var colours = {
         FDAVerRslt: { "Performing": "Red", "Conforming": "Blue", "Non-Conforming": "Aqua", "Non-Compliant": "Yellow", "Critical": "Orange", "Non-Compliance": "Green", "Not Applicable": "Purple", "Not Verified": "Black" },
         ChkNAYesNo: { "Not Applicable": "Red", "No": "Blue", "Yes": "Yellow" }
     };

     $(document).ready(function () {
         $('.usecolour').change(function () {
             setcolour(this);


         });
         $('.usecolour').each(function () {
             setcolour(this);
         });

     }); //document load



     function setcolour(obj) {
         list = $(obj).attr("data-list");
         val = $(obj).val();
         //alert(list + ":" + val);
         //alert(colours[ list ][val]);
         $(obj).css('background-color', colours[list][val]);
     }


 </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%=html%>
   
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info submit" Text="Submit" />
        </div>
    </div>




    <asp:Literal ID="lit_result" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
