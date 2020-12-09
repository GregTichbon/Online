<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="ContactDetails.aspx.cs" Inherits="UBC.People.Reports.ContactDetails" %>

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
    <!--<script src='//cdn.tinymce.com/4/tinymce.min.js'></script>-->
    <script src="https://cdn.tiny.cloud/1/72kumvg7ceuy157moyvp1m3056ca3ubthxyi6szh4jvuzapk/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    <script>
        tinymce.init({
            selector: '.tinymce',
            plugins: "code paste",
            menubar: "tools edit format view",
            paste_as_text: true
        });
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

            $('[name^="cb_email_"]').click(function () {
                name = $(this).attr('name');
                address = $(this).val();
                if ($(this).is(':checked')) {
                    $('#emailaddresses').append('<span id="' + name + '">' + address + ';</span>');
                } else {
                    $('#' + name).remove();
                }
            })
            $('#export').click(function () {
                var temptable = $('table').clone();
                 
                $(temptable).find('td').each(function () {
                    //console.log($(this).html());
                    $(this).html($(this).html().replace(/<br>/g, '\r\n'));
                });
 
                var table = "<table>";
                //$('table > tbody  > tr').each(function () {
                $(temptable).find('tr').each(function () {
                    table += "<tr>";
                    $(this).find('td:not(:first-child)').each(function () {
                        table += "<td>";
                        if ($(this).find('select').length > 0) {
                            table += $("option:selected", this).text();
                        } else {
                            table += $(this).text();
                        }
                        table += "</td>";
                    });
                    table += "</tr>";
                });
                table += "</table>";
                //console.log(table);
                //copyStringToClipboard(table);

 
                $.ajax({
                    type: "POST",
                    url: "../posts.asmx/TabletoExcelCSV",
                    data: '{"table": "' + table + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {

                        //alert(result);
                        details = $.parseJSON(result.d);
                        //console.log(details);
                        $('#div_downloadtext').html('Download: <a href="../downloads/' + details.message + '">File</a>');
                        $("#div_download").dialog({
                            resizable: false,
                            width: 800,
                            modal: true
                        });

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Status: " + textStatus); alert("Error: " + errorThrown);
                    }
                });
              
            });

        });
        function copyStringToClipboard(str) {
            // Create new element
            var el = document.createElement('textarea');
            // Set value (string to be copied)
            el.value = str;
            // Set non-editable to avoid focus and move outside of view
            el.setAttribute('readonly', '');
            el.style = { position: 'absolute', left: '-9999px' };
            document.body.appendChild(el);
            // Select text inside element
            el.select();
            // Copy text to clipboard
            document.execCommand('copy');
            // Remove temporary element
            document.body.removeChild(el);
        }

        function processrows() {
            category = $('#dd_categories_filter').val();
            if (category == null) {
                $('.tr_person').show();
            } else {
                $('.tr_person').each(function () {
                    found = false;
                    for (f1 = 0; f1 < category.length; f1++) {
                        usecategory = '|' + category[f1] + '|';
                        person_category = '|' + $(this).attr('data-category') + '|';
                        //console.log(person_category + '-' + usecategory + '=' + person_category.indexOf(usecategory));
                        if (person_category.indexOf(usecategory) != -1) {
                            found = true;
                            //console.log('found');
                            break;
                        }
                    }
                    if (found) {
                        $(this).show();
                        //console.log('show ' + thename);
                    } else {
                        $(this).hide();
                        //console.log('hide ' + thename);
                    }
                });
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA; width: 100%">
        <div class="toprighticon">
            <input type="button" id="export" class="btn btn-info" value="Export" />
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Contact Details
        </h1>


        <table class="table table-hover">
            <thead><tr>
                <th>Image</th><th>Name</th><th>Category</th><th>Phone</th><th>Email</th><th>Facebook</th><th>Relationships</th>
                   </tr></thead><tbody>

            <%=html %>
                </tbody>
        </table>
        <div id="emailaddresses"></div>


        <div id="div_download" title="Download" style="display: none;">
            <div id="div_downloadtext"></div>
        </div>
    </div>
</asp:Content>
