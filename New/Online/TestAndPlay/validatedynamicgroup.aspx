<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="validatedynamicgroup.aspx.cs" Inherits="Online.TestAndPlay.validatedynamicgroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var sitectr = 0;

        $(document).ready(function () {

            /*
            groups: getGroups(),
            groups: { personphone_1: "tb_personphonemobile_1 tb_personphonehome_1" },  //the name of the group is not important
            */

            var validator = $("#form1").validate({
                ignore: []
            });

            $('.addsite').click(function () {
                addrepeater();
            });

            function addrepeater() {

                var cloned = $('#div_site_').clone()

                sitectr = sitectr + 1;
                cloned = cloned.repeater_changer(sitectr);

                var place = $('.addsite');
                cloned.insertAfter(place);

                validator.groups['tb_personphonehome_' + sitectr] = 'personphone_' + sitectr;
                validator.groups['tb_personphonemobile_' + sitectr] = 'personphone_' + sitectr;

                $("#tb_personphonemobile_" + sitectr).rules("add", {
                    require_from_group: [1, ".validgroup_personphone_" + sitectr],   //this should match the class on the element
                    pattern: /02[0-9] \d{5,9}/,
                    messages: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    }
                });

                $("#tb_personphonehome_" + sitectr).rules("add", {
                    require_from_group: [1, ".validgroup_personphone_" + sitectr],    //this should match the class on the element
                    pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/,
                    messages: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    }
                });

                return false;
            };

            addrepeater();
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a href="javascript:void(0);" class="addsite">Add Site</a>
    <br />
    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />

    <div style="display: none">
        <div id="div_site_" class="repeatupdateid">
            Mobile phone :               
            <input id="tb_personphonemobile_" placeholder="eg: 027 123456..." name="tb_personphonemobile_" type="text" class="repeatupdatevalidgroup validgroup_personphone_" />
            <br />
            Home phone :

                <input id="tb_personphonehome_" name="tb_personphonehome_" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="repeatupdatevalidgroup validgroup_personphone_" />
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
