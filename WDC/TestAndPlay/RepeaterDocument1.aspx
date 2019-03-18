<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RepeaterDocument1.aspx.cs" Inherits="Online.TestAndPlay.RepeaterDocument1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script src="<%: ResolveUrl("~/Scripts/wdc.js")%>"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            datestimes_ctr = 1;

            $('.adddatesofuse').click(function () {
                var cloned = $('#tr_site_').clone()
                datestimes_ctr++;
                cloned = cloned.repeater_changer(datestimes_ctr);
                var place = $('#table_datesofuse tr:last');
                cloned.insertAfter(place);
                return false;
            });

            $('body').on('click', '.deletedatesofuse', function () {
                trid = this.id;
                trid = 'tr_datesofuse' + trid.substring(11);
                alert(trid);
                $('#' + trid).remove();
            });
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
                  <asp:FileUpload ID="fu_dummy" runat="server" style="display:none" /> <!--Forces form to be rendered with enctype="multipart/form-data" -->
                                        <input id="fu_upload" name="fu_upload" type="file" multiple="multiple" />
&nbsp;<div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="xxxxxx">Date(s) and time(s) of use</label>
                <div class="col-sm-8">
                    <a href="javascript:void(0);" class="adddatesofuse" id="adddatesofuse">Add</a>
                    <div class="table-responsive table-bordered">
                        <table class="table" id="table_datesofuse">
                            <thead>
                                <tr>
                                    <th class="col-md-2">Date(s) and Time(s) of use</th>
                                    <th class="col-md-2">Files</th>
                                    <th class="col-md-1">Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <input id="repeat_site_tb_thedatesofuse_1" name="repeat_site_tb_thedatesofuse_1" type="text" class="form-control" required />
                                    </td>
                                    <td>
                                        <input id="repeat_site_fu_scopeofoperations_1" name="repeat_site_fu_scopeofoperations_1" type="file" multiple="multiple" />
                                    </td>
                                    <td>Required</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            <!-- REPEATER SECTION-->
            <div style="display: none">
                <table>
                    <tr id="tr_site_">
                        <td>
                            <input id="repeat_site_tb_thedatesofuse_" type="text" class="form-control datetime" /></td>
                        <td>
                            <input id="repeat_site_fu_scopeofoperations_" type="file" multiple="multiple" /></td>
                        <td><a href="javascript:void(0)" id="href_delete_" class="deletedatesofuse repeatupdateid">Delete</a></td>
                    </tr>
                </table>
                <!-- END OF REPEATER SECTION -->
            </div>
        </div>
    </form>
</body>
</html>
