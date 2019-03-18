<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Autosize1.aspx.cs" Inherits="Online.TestAndPlay.Autosize1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {

            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
        
            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                autosize.update($('textarea'));
                //var x = $(event.target).text();         // active tab
                //var y = $(event.relatedTarget).text();  // previous tab
                //$(".act span").text(x);
                //$(".prev span").text(y);
            });
            
            autosize(document.querySelectorAll('textarea'));

        });
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Community Contracts Application
    </h1>

    <ul class="nav nav-tabs">
        <li class="active"><a data-target="#div_application">Application Details</a></li>
        <li><a data-target="#div_leadingedge">Whanganui - Leading Edge</a></li>
    </ul>
    <!------------------------------------------------------------------------------------------------------>
    <div class="tab-content">
        <div id="div_application" class="tab-pane fade in active">
            <h3>Application Details</h3>
            <textarea>a
    b
    c
    d
    e
    f
    g
    h
    i
    j
    k
    l
</textarea>
        </div>
        <!------------------------------------------------------------------------------------------------------>
        <div id="div_leadingedge" class="tab-pane fade">
            <h3>Whanganui Leading Edge</h3>
            <textarea id="xx">a
    b
    c
    d
    e
    f
    g
    h
    i
    j
    k
    l
</textarea>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
