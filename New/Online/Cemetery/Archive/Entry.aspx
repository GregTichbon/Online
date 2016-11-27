<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Entry.aspx.cs" Inherits="Online.Cemetery.Archive.Entry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_warrant">Warrant</label>
        <div class="col-sm-8">
            <input id="tb_warrant" name="tb_warrant" type="text" class="form-control" maxlength="50" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_burydate">Internment Date</label>
        <div class="col-sm-8">
            <input id="tb_burydate" name="tb_burydate" type="text" class="form-control" maxlength="50" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dob">Date of Birth</label>
        <div class="col-sm-8">
            <input id="tb_dob" name="tb_dob" type="text" class="form-control" maxlength="50" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dod">Date of Death</label>
        <div class="col-sm-8">
            <input id="tb_dod" name="tb_dod" type="text" class="form-control" maxlength="50" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_fullname">Full Name</label>
        <div class="col-sm-8">
            <input id="tb_fullname" name="tb_fullname" type="text" class="form-control" maxlength="250" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_surname">Surname</label>
        <div class="col-sm-8">
            <input id="tb_surname" name="tb_surname" type="text" class="form-control" maxlength="150" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_forenames">Forenames</label>
        <div class="col-sm-8">
            <input id="tb_forenames" name="tb_forenames" type="text" class="form-control" maxlength="150" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_age">Age</label>
        <div class="col-sm-8">
            <input id="tb_age" name="tb_age" type="text" class="form-control" maxlength="50" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_residence">Residential Address</label>
        <div class="col-sm-8">
            <textarea id="tb_residence" name="tb_residence" class="form-control" rows="3" maxlength="150"></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_occupation">Occupation</label>
        <div class="col-sm-8">
            <input id="tb_occupation" name="tb_occupation" type="text" class="form-control" maxlength="150" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_minister">Minister</label>
        <div class="col-sm-8">
            <input id="tb_minister" name="tb_minister" type="text" class="form-control" maxlength="150" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_director">Director</label>
        <div class="col-sm-8">
            <input id="tb_director" name="tb_director" type="text" class="form-control" maxlength="150" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_cemetery">Cemetery</label>
        <div class="col-sm-8">
            <input id="tb_cemetery" name="tb_cemetery" type="text" class="form-control" maxlength="50" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_thearea">Area</label>
        <div class="col-sm-8">
            <input id="tb_thearea" name="tb_thearea" type="text" class="form-control" maxlength="150" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_theblock">Block</label>
        <div class="col-sm-8">
            <input id="tb_theblock" name="tb_theblock" type="text" class="form-control" maxlength="150" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_thediv">Division</label>
        <div class="col-sm-8">
            <input id="tb_thediv" name="tb_thediv" type="text" class="form-control" maxlength="150" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_theplot">Plot</label>
        <div class="col-sm-8">
            <input id="tb_theplot" name="tb_theplot" type="text" class="form-control" maxlength="150" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_cemetery_new">Cemetery</label>
        <div class="col-sm-8">
            <select id="dd_cemetery_new" name="dd_cemetery_new" class="form-control">
                <option></option></select>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_thearea_new">Area</label>
        <div class="col-sm-8">
            <select id="dd_thearea_new" name="dd_thearea_new" class="form-control">
                <option></option>
</select>        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_theblock_new">Block</label>
        <div class="col-sm-8">
            <select id="dd_theblock_new" name="dd_theblock_new" class="form-control">
                <option></option>
</select>        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_thediv_new">Division</label>
        <div class="col-sm-8">
            <select id="dd_thediv_new" name="dd_thediv_new" class="form-control">
                <option></option>
</select>        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_theplot_new">Plot</label>
        <div class="col-sm-8">
            <select id="dd_theplot_new" name="dd_theplot_new" class="form-control">
                <option></option>
</select>        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_remarks">Remarks</label>
        <div class="col-sm-8">
            <textarea id="tb_remarks" name="tb_remarks" class="form-control" rows="3" maxlength="1000"></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_book">Book</label>
        <div class="col-sm-8">
            <input id="tb_book" name="tb_book" type="text" class="form-control" maxlength="20" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_pageref">Page</label>
        <div class="col-sm-8">
            <input id="tb_pageref" name="tb_pageref" type="text" class="form-control" maxlength="20" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dateentered">Date Entered</label>
        <div class="col-sm-8">
            <input id="tb_dateentered" name="tb_dateentered" type="text" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dateupdated">Date Last Updated</label>
        <div class="col-sm-8">
            <input id="tb_dateupdated" name="tb_dateupdated" type="text" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_datechecked">Date Checked</label>
        <div class="col-sm-8">
            <input id="tb_datechecked" name="tb_datechecked" type="text" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_ischecked">Checked</label>
        <div class="col-sm-8">
            <input id="tb_ischecked" name="tb_ischecked" type="text" class="form-control" maxlength="3" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_actiontype">Action Type</label>
        <div class="col-sm-8">
            <input id="tb_actiontype" name="tb_actiontype" type="text" class="form-control" maxlength="50" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_sextonreference">Sexton's Reference</label>
        <div class="col-sm-8">
            <input id="tb_sextonreference" name="tb_sextonreference" type="text" class="form-control" maxlength="20" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
