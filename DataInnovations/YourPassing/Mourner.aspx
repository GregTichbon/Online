<%@ Page Title="" Language="C#" MasterPageFile="~/YourPassing/Main.Master" AutoEventWireup="true" CodeBehind="Mourner.aspx.cs" Inherits="DataInnovations.YourPassing.Mourner" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>

    <link href="_Includes/jquery-ui-themes-1.12.1/jquery-ui.min.css" rel="stylesheet" />

    <script>
        agent_ctr = "<%= Session["K4U_Agent_CTR"] %>";
        $(document).ready(function () {
            $('[data-id="btn_view"]').click(function () {
                id = $(this).closest('tr').attr('data-id');
                name = $(this).closest('tr').attr('data-name');
                $('#dialog_deceased').dialog({
                    open: function () {
                        $(this).load('deceased.aspx?id=' + id);
                    },
                    modal: true,
                    width: $(window).width() * .5,
                    height: 600,
                    position: { my: "top", at: "centre top" },
                    title: name
                });
            });

            
        }); //$(document).ready
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%=html %>
    
    <div id="dialog_deceased" title="Information" style="display: none">
        

    </div>


</asp:Content>
