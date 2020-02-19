<%@ Page validateRequest="false" Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="News.aspx.cs" Inherits="UBC.People.News" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />


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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/dirty.js")%>"></script>
    <style>
        .personnote {
            color: red;
        }
    </style>

       <script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
    <script>
        tinymce.init({
            selector: '.tinymce',
            plugins: "code paste",
            menubar: "tools edit format view",
            paste_as_text: true
        });
        var tr_changed = [];

        $(document).ready(function () {

            $("#myForm").dirty();

            $(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });

            if ($('#hf_news_id').val() != 'new') {
                $('#togglepeople').show();
                //$('#export').show();
            }
            /*
            $('#export').click(function () {
                var table = "<table>";
                $('table > tbody  > tr').each(function () {
                    table += "<tr>";
                    $(this).find('td').each(function () {
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
                $.ajax({
                    type: "POST",
                    url: "posts.asmx/TabletoExcelCSV",
                    data: '{"table": "' + table + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {

                        //alert(result);
                        details = $.parseJSON(result.d);
                        //console.log(details);
                        $('#div_downloadtext').html('Download: <a href="downloads/' + details.message + '">File</a>');
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
                //alert(table);
            });
            */

            $('#newslist').click(function () {
                window.location.href = "<%: ResolveUrl("newslist.aspx")%>";
            })
            $('#newsviewer').click(function () {
                window.location.href = "<%: ResolveUrl("newsviewer.aspx")%>";
            })

            $("#form1").validate({
            rules: {
                tb_date: {
                    pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                }
            },
            messages: {
                tb_date: {
                    pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                }
            }
        });

            $("#div_date").on("dp.change", function (e) {
                theday = moment(e.date).format('dddd');
                $('#day').text(theday);
            });

            $('#togglepeople').click(function () {
                if ($(this).val() == "Show people") {
                    $('#div_people').show();
                    $(this).val('Hide people');
                } else {
                    $('#div_people').hide();
                    $(this).val('Show people');
                }
            })

            $('#div_date').datetimepicker({
            format: 'D MMM YYYY HH:mm',
            extraFormats: ['D MMM YY HH:mm', 'D MMM YYYY HH:mm', 'DD/MM/YY HH:mm', 'DD/MM/YYYY HH:mm', 'DD.MM.YY HH:mm', 'DD.MM.YYYY HH:mm', 'DD MM YY HH:mm', 'DD MM YYYY HH:mm'],
            //daysOfWeekDisabled: [0, 6],
            showClear: true,
            viewDate: false,
            useCurrent: false,
            sideBySide: true,
            viewMode: 'days',
            stepping: 15
            //,maxDate: moment().add(-1, 'year')
        });

            $('#dd_categories').select2();
            $('#dd_categories_filter').select2();

            processrows();

            $('.tr_field').change(function () {
                //id = $(this).parent().parent().attr('id').substring(3);
                id = $(this).data('id');
                tr_changed.indexOf(id) === -1 ? tr_changed.push(id) : null;
                $("#hf_tr_changed").val(tr_changed.toString());
            });


            $('#btn_refresh').click(function () {
                //Now will have all data but just hidden alert('Get data from server for categories: ' + $('#dd_categories_filter').val());
                processrows();
            })

        });



        function processrows() {
            category = $('#dd_categories_filter').val();
            $('#tbl_people tr[id^=tr_').each(function () {
                tr = $(this);
                personid = $(this).attr("id").substring(3);
                personcategory = $(this).attr("data-category");
                show = true;
                if (category != null) {
                    found = false;
                    for (f1 = 0; f1 < category.length; f1++) {
                        usecategory = '|' + category[f1] + '|';
                        if (personcategory.indexOf(usecategory) != -1) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        show = false;
                    }
                }
                if (show) {
                    $(tr).show();
                } else {
                    $(tr).hide();
                }
            });

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="hf_tr_changed" name="hf_tr_changed" />
    <input type="hidden" id="hf_news_id" name="hf_news_id" value="<%: news_id %>" />
    <div class="container" style="background-color: #FCF7EA">
        <div class="toprighticon">
            <!--<input type="button" id="export" style="display: none" class="btn btn-info" value="Export" />-->
            <input type="button" id="newsviewer" class="btn btn-info" value="News Viewer" />
            <input type="button" id="newslist" class="btn btn-info" value="News List" />
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - News
        </h1>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_date">Date/time</label>
            <div class="col-sm-8">
                <div class="input-group date" id="div_date">
                    <input id="tb_date" name="tb_date" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: date %>" maxlength="20" required />
                   <span id="day" class="input-group-addon"><%= day %></span> 
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_title">Title</label>
            <div class="col-sm-8">
                <input id="tb_title" name="tb_title" type="text" class="form-control" value="<%: title %>" maxlength="100" required />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_article">Article</label>
            <div class="col-sm-8">
                <textarea id="tb_article" name="tb_article" class="tinymce form-control" required><%: article %></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_categories">
                <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="Select the categories of those that should see this article.  You can add other people outside of these cateories by changing the people view below." />
                Categories</label>
            <div class="col-sm-8">
                <select id="dd_categories" name="dd_categories" class="form-control" multiple="multiple">
                    <%= categories_values %>
                </select>
            </div>
        </div>
        
        <input type="button" id="togglepeople" class="btn btn-info" style="display: none" value="Hide people" />
        <h3>I haven't set up to be able to add individuals not included in a category yet!<br />SP will need a "union" clause</h3>
        <div id="div_people">
            <%=html_persons %>
        </div>
        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>
    </div>

    <div id="div_download" title="Download" style="display: none;">
        <div id="div_downloadtext"></div>
    </div>


</asp:Content>
