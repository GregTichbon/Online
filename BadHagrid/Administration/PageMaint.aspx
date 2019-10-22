<%@ Page validateRequest="false" Language="C#" AutoEventWireup="true" CodeBehind="PageMaint.aspx.cs" Inherits="BadHagrid.Administration.PageMaint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/additional-methods.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>

    <script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
    <script>
        tinymce.init({
            selector: '.tinymce',
            menubar: "tools edit format view",
            paste_as_text: true,
            plugins: [
                    "advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",
                    "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                    "save table contextmenu directionality emoticons template paste textcolor"
            ],
            content_css: "css/metro-bootstrap.min.css",
            toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | print preview media fullpage | forecolor backcolor emoticons",
            file_browser_callback: function (field, url, type, win) {
                tinyMCE.activeEditor.windowManager.open({
                    url: '/FileBrowser/FileBrowser.aspx?caller=tinymce4&langCode=en&type=' + type,
                    title: 'File Browser',
                    width: 700,
                    height: 500,
                    inline: true,
                    close_previous: false
                }, {
                    window: win,
                    field: field
                });
                return false;
            }
        });
        var tr_changed = [];

        $(document).ready(function () {



            $(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });



            $("#form1").validate();

            

        }); //document.ready

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="hf_page_ctr" name="hf_page_ctr" value="<%: page_ctr %>" />
        <div class="container" style="background-color: #FCF7EA">

            <h1>Bad Hagrid - Page Maintenance
            </h1>

            

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_title">Title</label>
                <div class="col-sm-8">
                    <input id="tb_title" name="tb_title" type="text" class="form-control" value="<%: title %>" maxlength="100" required="required" />
                </div>
            </div>

             

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_content">Content</label>
                <div class="col-sm-8">
                    <textarea id="tb_content" name="tb_content" class="tinymce form-control" required="required"><%: content %></textarea>
                </div>
            </div>


            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" /> <asp:Button ID="btn_delete" runat="server" OnClick="btn_delete_Click" class="btn btn-info" style="display:none" Text="Delete" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
