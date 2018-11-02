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

        .add:before, .addevent:before {
            content: "+";
        }

        .add, .addevent {
            position: absolute;
            top: 0;
            right: 2px;
            cursor: pointer;
        }

       


    </style>



    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    
    <script src="<%: script %>"></script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="hf_person_id" name="hf_person_id" value="<%= hf_person_id %>" />
    <input type="hidden" id="hf_person_name" name="hf_person_name" value="<%= hf_person_name %>" />
    <input type="hidden" id="hf_person_colour" name="hf_person_colour" value="<%= hf_person_colour %>" />
    <input type="hidden" id="hf_changes" name="hf_changes" />

    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn_submit" Style="width: 100%; height: 60px" Text="Save" />

    <%= html%>
    <div id="div_coaches" title="Select Coach(es)" style="display: none">
        <%= coaches_html %>
    </div>
    <div id="div_event" title="Event" style="display: none;width:800px"></div>
</asp:Content>
