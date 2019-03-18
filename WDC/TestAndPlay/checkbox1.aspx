<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="checkbox1.aspx.cs" Inherits="Online.TestAndPlay.checkbox1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#cb_foundout_8").change(function () {
                if ($(this).is(':checked')) {
                    $("#span_otherfoundout").show();
                } else {
                    $("#span_otherfoundout").hide();
                    $("#tb_otherfoundout").val("");
                }

            });
        }); //document.ready
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_foundout">How did you find out about the Long Term Plan consultation? (tick all that apply)</label>
        <div class="col-sm-8">
            <input id="cb_foundout_1" name="cb_foundout" type="checkbox" value="Council Website" />
            Council Website 
            <br />
            <input id="cb_foundout_2" name="cb_foundout" type="checkbox" value="Facebook" />
            Facebook
            <br />
            <input id="cb_foundout_3" name="cb_foundout" type="checkbox" value="Newspaper" />
            Newspaper  
            <br />
            <input id="cb_foundout_4" name="cb_foundout" type="checkbox" value="Community Link" />
            Community Link            
            <br />
            <input id="cb_foundout_5" name="cb_foundout" type="checkbox" value="River City Press" />
            River City Press<br />
            <input id="cb_foundout_6" name="cb_foundout" type="checkbox" value="Radio" />
            Radio  
             <br />
            <input id="cb_foundout_7" name="cb_foundout" type="checkbox" value="Word of Mouth" />
            Word of Mouth  
             <br />
            <input id="cb_foundout_8" name="cb_foundout" type="checkbox" value="Other" />
            Other <span id="span_otherfoundout" style="display: none">, please state:
                <input type="text" id="tb_otherfoundout" name="tb_otherfoundout" class="form-control" /></span>

        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
