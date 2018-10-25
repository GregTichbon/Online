<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="EventPlanner.aspx.cs" Inherits="UBC.People.EventPlanner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }

        table {
            table-layout: fixed;
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: solid;
            vertical-align: top;
        }

        .date {
            background-color: lightcoral;
            padding: 5px;
            margin: 2px
        }

        .title {
            padding: 10px;
            color: red;
        }

        .event {
            border: solid;
            border-color: red;
            padding: 5px;
            margin: 2px;
        }

        .person, .coach {
            padding: 10px;
        }


        .wrapper {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .remove:before {
            content: "\00d7";
        }

        .remove {
            position: absolute;
            top: 0;
            right: 2px;
            cursor: pointer;
        }

        .add:before {
            content: "+";
        }

        .add {
            position: absolute;
            top: 0;
            right: 2px;
            cursor: pointer;
        }
    </style>



    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>


    <script>
        var event_id;

        $(document).ready(function () {

            //$('.remove').click(function () {
            $(document).on('click','.remove',function(){
                $(this).parent().remove();
            });



            $('.add').click(function () {
                event_id = $(this).parent().parent().attr('id');
                $("#div_coaches").dialog({
                    resizable: false,
                    modal: true,
                    buttons: {
                        "Done": function () {
                            $(this).dialog("close");
                        }
                    }
                });

                //alert('add')
            });
            $('.title').mouseover(function () {

                //alert('mouseover')
            });

            $('.title').tooltip({
                content: function () {
                    var element = $(this);
                    return element.attr("title");
                }
            });


            $('.title').click(function () {
                alert('title clicked - open event')
            });

            $('.coach').click(function () {
                person_id = $(this).attr('id').substring(6);
                selectorid = 'coach_' + event_id + '_';
                selector = '[id^=' + selectorid + ']';
                alreadyused = false;
                $(selector).each(function () {
                    thisid = $(this).attr('id').substring(selectorid.length);
                    if (person_id == thisid) {
                        alreadyused = true;
                    }
                })

                if (!alreadyused) {
                    name = $(this).text();
                    colour = $(this).css("backgroundColor");
                    $('#' + event_id).append('<div class="wrapper"><div class="person" id="coach_' + event_id + '_' + person_id + '" style="background-color:' + colour + ';">' + name + '</div><span class="remove"></span></div>');
                }
            });

        }); //document ready

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%= html%>
    <div id="div_coaches" title="Select Coach(es)" style="display:none">
        <%= coaches_html %>
    </div>
</asp:Content>
