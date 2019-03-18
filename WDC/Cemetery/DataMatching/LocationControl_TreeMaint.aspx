<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LocationControl_TreeMaint.aspx.cs" Inherits="Online.Cemetery.DataMatching.LocationControl_TreeMaint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btn_toggle_divisions').click(function () {
                $('.Division').toggle();
            });
           
            $('#btn_toggle_areas').click(function () {
                $('.Area').toggle();
            });
            $('#btn_toggle_addbuttons').click(function () {
                $('.Add').toggle();
            });
            //$('.Edit').click(function () {
            $('body').on('click', '.Edit', function () {
                id = $(this).attr('id');
                value = $("#Disp_" + id).text();
                maint(id, value);
            });
            //$('span.Add').click(function () {
            $('body').on('click', 'span.Add', function () {
                id = $(this).attr('id');
                maint(id, '');
            });
            $('body').on('click', '#btn_save', function () {
                var returnedid;
                id = $('#hf_id').val();
                value = $('#tb_value').val();
                $.ajax({
                    url: "../data.asmx/updatelocationcontrol?id=" + id + "&value=" + value, success: function (result) {
                        response = $.parseJSON(result);
                        returnedid = response.id;
                        if (id.substring(0, 4) == 'Edit') {
                            //alert('Edit');
                            $('#Disp_' + id).text(value);
                        } else {

                            //alert(id);
                            idparts = id.split('_');
                            addtype = idparts[1]; 
                            typeid = idparts[2];

                            switch (addtype) {
                                case 'C':
                                    newaddclass = 'Area';
                                    break;
                                                               case 'B':
                                    newaddclass = 'Division';
                                    break;
                                default:
                                    newaddclass = '';
                            }
                            newaddclassletter = newaddclass.substring(0, 1);
                            //alert(newaddclassletter);

                            if (newaddclass == '') {
                                addnextlevel = '';
                            } else {
                                addnextlevel = "<ul class='" + newaddclass + " " + newaddclassletter + "_" + returnedid + "'>   <li class='Add'><span id='Add_" + newaddclassletter + "_" + returnedid + "' class='Add " + newaddclass + "'>Add " + newaddclass + "</span>"
                            }

                            $("ul." + addtype + "_" + typeid).append("<li><span id='Disp_Edit_" + addtype + "_" + returnedid + "'>" + value + "</span> <span class='Edit' id='Edit_" + addtype + "_" + returnedid + "'>Edit</span>" + addnextlevel);
                        }
                        $("#dialog").dialog("close");
                    }
                });
            });
        });

        function maint(id, value) {
            idparts = id.split('_');
            mode = idparts[0];
            type = idparts[1];

            switch (type) {
                case 'C':
                    type = 'Cemetery';
                    break;
                case 'A':
                    type = 'Area';
                    break;
                               case 'D':
                    type = 'Divsion';
                    break;
            }
            //id = idparts[2];
            //value = value.substring(0, value.length - 5);

            $('#hf_id').val(id);
            $('#tb_value').val(value);

            //$("#dialog").html('<input type="hidden" id="hf_id" class="xxxx" value="' + id + '" /><input type="text" id="tb_value" value="' + value + '" /><br /><input type="button" id="btn_save" value="Save" />');
            $("#dialog").dialog({
                title: mode + ' ' + type,
                resizable: false,
                height: 340,
                modal: true
            });

        }

    </script>
    <style>
        <!--
        .Cemetery {
            color: #FF0000;
        }

        .Area {
            color: #0000FF;
        }

      
        .Division {
            color: #000000;
        }


        .Add, .Edit {
            text-decoration: underline;
            cursor: pointer;
        }
        -->
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <span class="Cemetery">Cemetery</span> <span class="Area">Area</span> <span class="Division">Divsion</span>


    <input type="button" id="btn_toggle_addbuttons" value="Toggle Add Buttons" />
    <input type="button" id="btn_toggle_areas" value="Toggle Areas" />
    <input type="button" id="btn_toggle_divisions" value="Toggle Divisions" />
    <br />


    <asp:Literal ID="lit_body" runat="server"></asp:Literal>
    <div id="dialog" title="" style="display: none">
        <input type="text" id="tb_value" /><input type="hidden" id="hf_id" name="hf_id" /><input type="button" id="btn_save" value="Save" /></div>
    <!--
    <ul class='Cemetery C_'>
        <li class='Add'><span id='Add_C_' class='Add Cemetery'>Add Cemetery</span></li>
        <li>
            <span id='Disp_Edit_C_1'>Aramoho Cemetery</span> <span class='Edit' id='Edit_C_1'>Edit</span>
            <ul class='Area A_1'>
                <li class='Add'><span id='Add_A_1' class='Add Area'>Add Area</span></li>
                <li>
                    <span id='Disp_Edit_A_43'>Cremation Lawn A</span> <span class='Edit' id='Edit_A_43'>Edit</span>
                    <ul class='Division D_43'>
                        <li class='Add'><span id='Add_D_43' class='Add Division'>Add Division</span></li>
                        <li><span id='Disp_Edit_D_496'>7</span> <span class='Edit' id='Edit_D_496'>Edit</span></li>
                    </ul>
                </li>
                <li>
                    <span id='Disp_Edit_A_44'>Cremation Lawn B</span> <span class='Edit' id='Edit_A_44'>Edit</span>
                    <ul class='Division D_44'>
                        <li class='Add'><span id='Add_D_44' class='Add Division'>Add Division</span></li>
                        <li><span id='Disp_Edit_D_497'>7</span> <span class='Edit' id='Edit_D_497'>Edit</span></li>
                    </ul>
                </li>
            </ul>
        </li>
    </ul>

    <ul>
        <li>ADD CEMETERY</li>
        <li>cemetery
            <ul class="AREAS">
                <li>ADD AREA</li>
                <li>area 1
                    <ul class="DIVISIONS">
                        <li>ADD DIVISION</li>
                        <li>division 1</li>
                    </ul>
                </li>
                <li>area 2
                   <ul class="DIVISIONS">
                        <li>ADD DIVISION</li>
                        <li>division 1</li>
                        <li>division 2</li>
                    </ul>
                </li>
            </ul>
        </li>
    </ul>
    -->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
