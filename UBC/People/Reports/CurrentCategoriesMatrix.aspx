<%@ Page Title="Union Boat Club - Current Categories Matrix" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="CurrentCategoriesMatrix.aspx.cs" Inherits="UBC.People.Reports.CurrentCategoriesMatrix" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <link href="<%: ResolveUrl("~/Dependencies/StickyTableCells/jquery.stickytable.css")%>" rel="stylesheet" />
    <script src="<%: ResolveUrl("~/Dependencies/StickyTableCells/jquery.stickytable.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

    <style>
        td, th {
            text-align: center;
            vertical-align: middle;
            border: 1px #eee solid;
        }

        .me {
            background-color: chartreuse;
        }

        .selectedrow, .selectedcol {
            background-color: orange;
        }
    </style>

    <script>
        $(document).ready(function () {
            /*
            $('td').click(function () {
                $(this).parent().toggleClass('selectedrow');
            })
             */
            $('#dd_categories_filter').select2();

            $('td').mousedown(function (event) {
                switch (event.which) {
                    case 1:
                        $(this).parent().toggleClass('selectedrow');
                        break;
                    case 2:
                        alert('Middle Mouse button pressed.');
                        break;
                    case 3:
                        //alert('Right Mouse button pressed.');
                        thisclass = $(this).attr('class');
                        if (thisclass == 'sticky-cell') {
                            $(this).closest('tr').hide();
                        }
                        break;
                    default:
                        alert('You have a strange Mouse!');
                }
            });



            // $('th').click(function () {
            //     var pattern = /c[0-9]*/;
            //     thisclass = $(this).attr('class');
            //     thisclass = thisclass.match(pattern);
            //     $('.' + thisclass).toggleClass('selectedcol');
            //  })


            $('th').mousedown(function (event) {
                switch (event.which) {
                    case 1:
                        var pattern = /c[0-9]*/;
                        thisclass = $(this).attr('class');
                        thisclass = thisclass.match(pattern);
                        $('.' + thisclass).toggleClass('selectedcol');
                        break;
                    case 2:
                        alert('Middle Mouse button pressed.');
                        break;
                    case 3:
                        //event.preventDefault();
                        //var pattern = /c[0-9]*/;
                        thisclass = $(this).attr('class');
                        //alert(thisclass);
                        //thisclass = thisclass.match(pattern);
                        $('.' + thisclass).hide();
                        text = $(this).text();

                        $('#div_hiddencolumns').append($('<button/>', {
                            text: text,
                            type: 'Button',
                            id: thisclass,
                            class: 'btn_showcolumn'
                        }));

                        break;
                    default:
                        alert('You have a strange Mouse!');
                }
            });


            $('body').on('click', '.btn_showcolumn', function () {
                //alert($(this).attr('id'));
                $('.' + $(this).attr('id')).show();
                $(this).remove();
            });


        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="button" id="menu" class="toprighticon btn btn-info" value="MENU" />

    <h1>Union Boat Club - Current Categories Matrix
    </h1>
    <div id="div_hiddencolumns"></div>

    <div oncontextmenu="return false;">
        <%= html%>
    </div>
</asp:Content>
