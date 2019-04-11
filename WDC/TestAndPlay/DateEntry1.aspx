<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DateEntry1.aspx.cs" Inherits="Online.TestAndPlay.DateEntry1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     $('body').on('focus', ".dateonly", function () {
                $(this).datetimepicker({
                    format: 'D MMM YYYY',
                    extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                    showClear: true,
                    viewDate: false,
                    stepping: 30,
                    minDate: moment().add(1, 'day'),
                    maxDate: moment().add(10, 'year'),
                    useCurrent: false,
                    sideBySide: true
                });
            });


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
