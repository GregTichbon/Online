<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ToDo.aspx.cs" Inherits="TeOranganui.ToDo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        table, th, td {
            border: 1px solid black;
        }

        .auto-style1 {
            width: 100%;
        }

        .auto-style2 {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>


            <table class="auto-style1">
                <tr>
                    <td><strong>Date</strong></td>
                    <td class="auto-style2"><strong>Detail</strong></td>
                    <td><b>Notes</b></td>
                    <td><b>Completed</b></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>School - Add address tab</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>School | People - Role (currently in Role Table, should it be in the list table? Should it be categorised by group type?&nbsp; Requires making ....)<br />

                        <ul>
                            <li>New Table List_Field - Defines fields: Text1, DateTime1, Number1 ....... in List_Items</li>
                            <li>List_Items | Field name = DataType (Number, DateTime, Text) + FieldNumber</li>
                            <li>ControlType: Text, TextArea, Dropdown</li>
                            <li>LIST.ASPX: Tables can now be dynamically defined.</li>
                        </ul>


                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>School | Roll - I&#39;ve added a &quot;Roll Group&quot; to the table as a seperate field.&nbsp; It would be better if it was actually a field against the classification</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Get double click on person working </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>School | Add Tab - Engagement - Date and level (0-3) maybe need description</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Person - is not refreshing on Create ?</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>School | Add Tab - Key Priority (Description, Start Date, End Date, Notes) Make Narrative field to link to this. </td>
                    <td>Done, Still need to add narrative to this</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>

                        <p>Reporting</p>
                        <ul>
                            <li>Simple criteria</li>
                            <li>Define routines to show associated data</li>
                            <li>Maybe use BRIT - need to access MSSQL DB remotely</li>
                            <li>Reporting Services</li>
                        </ul>


                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Computercare - hosting</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Shouldn&#39;t be able to access Tab data when no record loaded</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Calendar plugin</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Increase Note size to nvarchar(500)</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Make each user signon with there own SQL user account</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Audit Log (Ensure unchanged data not saved)</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Where there is a validation error in a tab that is hidden there could be a better message</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Date format needs to be stipulated (dd mmm yyyy)</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>Deleting a newly added row&nbsp;requires validation which it shouldn&#39;t.&nbsp; Either set a class or actually delete it.&nbsp;
    
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>4/5/17</td>
                    <td>Add Location as a drop down to the static information of the school</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>4/5/17</td>
                    <td>Add a new tab: Priority.&nbsp; Date, Activity(DD), Note, and Status(DD) but ...... I&#39;m wondering if we actually need to create a new screen for &quot;visits&quot; which would include Engagement and Priority</td>
                    <td>See Key Priority in a task above.&nbsp; I think the former was a better way</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>4/5/17</td>
                    <td>Get google co-ordinates for addresses
                    <ul>
                        <li>Quote</li>
                    </ul>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>4/5/17</td>
                    <td>Consider a &quot;System&quot; List for lists that will be over all groups ie: Location - maybe better to be able to associate a list to multiple group types</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <br />
            <br />

        </div>
    </form>
</body>
</html>
