<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="Sort1.aspx.cs" Inherits="TeOranganui.Sort1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

var thIndex = 0,
    curThIndex = null;

        $(document).ready(function () {

             $('.sort').click(function() {
                var thIndex = 0,
                curThIndex = null;

                thIndex = $(this).index();
                if(thIndex != curThIndex){
                    curThIndex = thIndex;
                    sorting = [];
                    tbodyHtml = null;
                    $('table tbody tr').each(function(){
alert($(this).children('td').text());
                        sorting.push($(this).children('td').eq(curThIndex).html() + ', ' + $(this).index());
                    });
      
                    sorting = sorting.sort();
                    sortIt();
                }
            })
        });

    function sortIt(){
        for(var sortingIndex = 0; sortingIndex < sorting.length; sortingIndex++){
            rowId = parseInt(sorting[sortingIndex].split(', ')[1]);
            tbodyHtml = tbodyHtml + $('table tbody tr').eq(rowId)[0].outerHTML;
        }
        $('table tbody').html(tbodyHtml);
    }



    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="datagrid">
        <table id="tbl_systems">
            <tbody>
                <tr>
                    <th style="width: 50px; text-align: right"></th>
                    <th class="sort">System</th>
                </tr>
                <tr id="sub-group_system-22" class="rowdata">
                    <td style="text-align: center">x</td>
                    <td>
                        <!--<input name="sub-group_system-22-system_id" id="sub-group_system-22-system_id" class="form-control" value="c" />-->
                        c
                    </td>
                </tr>
                <tr id="sub-group_system-23" class="rowdata">
                    <td style="text-align: center">y</td>
                    <td>
                        <!--<input name="sub-group_system-23-system_id" id="sub-group_system-23-system_id" class="form-control" value="a" />-->
                        a
                    </td>
                </tr>

                <tr id="sub-group_system-24" class="rowdata">
                    <td style="text-align: center">z</td>
                    <td>
                        <!--<input name="sub-group_system-24-system_id" id="sub-group_system-24-system_id" class="form-control" value="b" />-->
                        b
                    </td>
                </tr>

            </tbody>
        </table>
    </div>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
