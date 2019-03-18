<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="propertyselect1.aspx.cs" Inherits="Online.TestAndPlay.propertyselect1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">
         var location_maxline = 0;

         $(document).ready(function () {

             $('body').on('click', '#a_propertyaddress', function () {
                 //not using line at this stage
                 $.colorbox({ href: "../functions/PropertySelect.aspx", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
             });

            

             $("#form1").validate({
                 ignore: [],
             });


         }); //document.ready

         function passproperty(line, label, value, area, legaldescription, assessment_no) {
             $("#tb_propertyaddress").val(label);
             $("#hf_propertyaddress").val(value);
             $.colorbox.close();
         }




    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_premiselocation">Property address:</label>
        <div class="col-sm-6">
            <input type="text" id="tb_propertyaddress" name="tb_propertyaddress" readonly="readonly" class="form-control" required value="">
            <input id="hf_propertyaddress" name="hf_propertyaddress" type="hidden" value="" />
        </div>
        <div class="col-sm-2">
            <a id="a_propertyaddress">Select</a>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
