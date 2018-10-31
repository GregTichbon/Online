<%@ Page ValidateRequest="false" Title="Union Boat Club Communicate" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Communicate.aspx.cs" Inherits="UBC.People.Communicate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

    <script>

        $(document).ready(function () {
            $('.fb_clipboard').click(function () {
                link = $(this).data('link');
                //alert(link);
                textarea = $(this).next();
                $(textarea).focus();
                $(textarea).select();
                document.execCommand('copy');

                window.open(link, 'facebook');
                //alert("Copied to clipboard");
            });

            $('#dd_categories_filter').select2();

            processrows();

            $('#btn_refresh').click(function () {
                //Now will have all data but just hidden alert('Get data from server for categories: ' + $('#dd_categories_filter').val());
                processrows();
            })

        });

        function processrows() {
            category = $('#dd_categories_filter').val();
            if (category == null) {
                $('.tr_person').show();
            } else {

                $('.tr_person').each(function () {
                    found = false;
                    for (f1 = 0; f1 < category.length; f1++) {
                        usecategory = '|' + category[f1] + '|';
                        person_category = $(this).attr('data-category');
                        if (person_category.indexOf(usecategory) != -1) {
                            found = true;
                            break;
                        }
                        if (found) {
                             $(this).show();
                        } else {
                            $(this).hide();

                        }
                    }
                });
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA">
        Use ||link|| to include the link, it will be displayed as &quot;here&quot; in the body of the email.<br />
        Also can use ||firstname||, ||caregivername||<br />
        <br />
        Email messages will not be sent where there is no email subject<br />
        Txt messages will not be sent where there is no text body.<br />
        <br />
        Email Subject:<br />
        &nbsp;<asp:TextBox ID="tb_subject" runat="server" Width="512px">Union Boat Club Learn to Row 21 - 23 Sep</asp:TextBox><br />
        <br />
        Email Body (HTML):<br />
        &nbsp;<asp:TextBox ID="tb_htmlbody" runat="server" Height="110px" TextMode="MultiLine" Width="901px">&lt;p&gt;Hi ||firstname||&lt;/p&gt;
&lt;p&gt;Just a reminder of the Learn to Row Weekend this weekend.&lt;/p&gt;&lt;p&gt;For more information, to check and maintain your details,  and to confirm you are coming please go to ||link||.&lt;/p&gt;&lt;p&gt;Thanks&lt;/p&gt;</asp:TextBox><br />
        <br />
        Email/Facebook Body (Text):<br />
        &nbsp;<asp:TextBox ID="tb_textbody" runat="server" Height="110px" TextMode="MultiLine" Width="902px">Hi ||firstname||

Just a reminder of the Learn to Row Weekend this weekend.

For more information, to check and maintain your details,  and to confirm you are coming please go to ||link||.</asp:TextBox><br />
        <br />
        Email Reply-To Address:<br />
        &nbsp;<asp:TextBox ID="tb_replyto" runat="server" Width="512px">Not currently used</asp:TextBox><br />
        <br />
        Text Body:<br />
        &nbsp;<asp:TextBox ID="tb_txt" runat="server" Height="122px" TextMode="MultiLine" Width="910px">Hi ||firstname||

Just a reminder of the Learn to Row Weekend this weekend.

For more information, to check and maintain your details,  and to confirm you are coming please go to ||link||.</asp:TextBox><br />
        <br />

        <br />
        <hr />

        <%=html_facebook %>

        <select class="form-control" id="dd_categories_filter" name="dd_categories_filter" multiple="multiple">
          <%= categories_values %>
        </select>
        <button type="button" id="btn_refresh">Refresh</button><br />



        <table class="table table-hover">

            <%=html %>
        </table>
         <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Send" />
            </div>
        </div><br />
    </div>
</asp:Content>
