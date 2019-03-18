<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IframeMap2.aspx.cs" Inherits="Online.TestAndPlay.IframeMap2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <script type="text/javascript">


          $(document).ready(function () {
              $('#btn_refresh').click(function () {
                  $('#myiframe').attr('src', $('#txt_src').val());

              })
              /*
              $('#btn_colorbox').click(function () {
                  src = $('#txt_src').val();
                  $(".view").colorbox({ href: "iframeMap2a.aspx?src=" + src, iframe: true, height: "800", width: "700", overlayClose: true });

              })
              */
              var mapsrc = 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?mapkey=10072&project=WhanganuiMapControls&module=WDCCemeteries&layer=~Cemetery%20Plots&search=false&slider=false';
              /*
              $('#btn_colorbox').live('click', function () {
                  alert(1);
                  $.colorbox({ href: "iframeMap2a.aspx?src=" + src, iframe: true, height: "800", width: "700", overlayClose: true });
                  return false;
              });
              */

              $('#txt_src').val(mapsrc);
              src = $('#txt_src').val();
              //alert(src);
              $("#btn_colorbox").colorbox({ href: "iframeMap2a.aspx?src=" + $('#txt_src').val(), width: "800", height: "800", iframe: true, overlayClose: false }); //, onClosed:function(){ location.reload(true); } });


          });
          </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

       <iframe id="myiframe" style="width:100%;height:400px" src=""></iframe>
    <textarea style="width:100%" id="txt_src" rows="5"></textarea><br />
    <input id="btn_refresh" type="button" value="Refresh" />
        <input id="btn_colorbox" type="button" value="ColorBox" />

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
