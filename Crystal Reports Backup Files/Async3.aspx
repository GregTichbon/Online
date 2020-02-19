<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Async3.aspx.cs" Inherits="UBC.People.TestAndPlay.Async3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script>

        $(document).ready(function () {
            $('#btn_submit').click(function (e) {
                e.preventDefault();
                $("#tbl_results > tbody").empty();

                $('#dialog_sending').dialog({
                    modal: true,
                    width: ($(window).width() - 0) * .95,  //75 x 2 is the width of the question mark top right
                    height: 600, //auto
                    position: { my: "center", at: "100", of: window }
                });

                newobj = $("#tbl_people > tbody > tr > td > input:checked").toArray()
                //console.log(newobj);
                test1(0,$(newobj).length);
            });
        }); //document ready

        function test1(i, items) {
            console.log($(newobj[i]).attr('id'));
            i++;
            $.ajax({
                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                contentType: "application/json; charset=utf-8",
                url: "posts.asmx/test",
                async: false,
                //data: formData,
                dataType: 'json', // what type of data do we expect back from the server
                success: function (data) {
                    //console.log(data);
                    $('#tbl_results tbody').prepend("<tr><td>" + data.d.status + '</td></tr>');
                    //$('#test').prepend('<br />' + i + ' ' + data.d.status);
                },
                error: function (XMLHttpRequest, textStatus, error) {
                    alert("AJAX error: " + textStatus + "; " + error);
                }
            });

            if (i < items) {
                setTimeout(function () { test1(i, items); }, 100);
            } else {
                //$('#test').prepend('<br />' + 'complete');
                $('#tbl_results tbody').prepend('<tr><td>Complete</td></tr>');
            }
        }


    </script>
    <style type="text/css">
        .auto-style1 {
            height: 54px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <input type="button" id="btn_submit" class="btn btn-info" value="Send" />
        <table id="tbl_people" class="table table-hover">
            <thead>
                <tr>
                    <th>Person</th>
                    <th>
                        <input id="cb_textall" type="checkbox" />
                        Send Text</th>
                    <th>
                        <input id="cb_emailall" type="checkbox" />
                        Send Email</th>
                </tr>
            </thead>
            <tbody>
                <tr class="tr_person" id="tr_person_id_148">
                    <td><a id="name_148" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=a8be2e23-f0d1-493d-8b6e-526ff31246e6" target="link">Amanda Meltzer</a></td>
                    <td>
                        <input id="cb_text_148" name="cb_text_148" type="checkbox" value="0211542783" />
                        <a href="tel:0211542783">0211542783</a></td>
                    <td></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_147">
                    <td><a id="name_147" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=7e5fac24-30e1-4baa-8ec3-f5c2af634783" target="link">Anthony Roots</a></td>
                    <td>
                        <input id="cb_text_147" name="cb_text_147" type="checkbox" value="0275841450" />
                        <a href="tel:0275841450">0275841450</a></td>
                    <td></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_59">
                    <td><a id="name_59" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=d508cde8-8835-4b18-9896-ca2ad093a771" target="link">Bob Evans</a></td>
                    <td>
                        <input id="cb_text_59" name="cb_text_59" type="checkbox" value="0272904002" />
                        <a href="tel:0272904002">0272904002</a></td>
                    <td>
                        <input id="cb_email_59" name="cb_email_59" type="checkbox" value="bob.evans@xtra.co.nz" />
                        <a href="mailto:bob.evans@xtra.co.nz">bob.evans@xtra.co.nz</a><br />
                        <input id="cb_email_59" name="cb_email_59" type="checkbox" value="bevans@rutherford.ac.nz" />
                        <a href="mailto:bevans@rutherford.ac.nz">bevans@rutherford.ac.nz</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_139">
                    <td><a id="name_139" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=99e84955-9318-47ea-9edb-80c67aff727d" target="link">Claire Lilley</a></td>
                    <td>
                        <input id="cb_text_139" name="cb_text_139" type="checkbox" value="0274400870" />
                        <a href="tel:0274400870">0274400870</a></td>
                    <td>
                        <input id="cb_email_139" name="cb_email_139" type="checkbox" value="clairel@whanganui.govt.nz" />
                        <a href="mailto:clairel@whanganui.govt.nz">clairel@whanganui.govt.nz</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_95">
                    <td><a id="name_95" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=c2e2f044-7ff4-4d0a-8595-46cd77b8254a" target="link">Grant Ryder</a></td>
                    <td>
                        <input id="cb_text_95" name="cb_text_95" type="checkbox" value="0272264425" />
                        <a href="tel:0272264425">0272264425</a></td>
                    <td>
                        <input id="cb_email_95" name="cb_email_95" type="checkbox" value="grant.ryder@broadspectrum.com" />
                        <a href="mailto:grant.ryder@broadspectrum.com">grant.ryder@broadspectrum.com</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_1">
                    <td><a id="name_1" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=09db9e21-d49e-441f-9076-2626b37e099c" target="link">Greg Tichbon</a></td>
                    <td>
                        <input id="cb_text_1" name="cb_text_1" type="checkbox" value="0272495088" />
                        <a href="tel:0272495088">0272495088</a></td>
                    <td>
                        <input id="cb_email_1" name="cb_email_1" type="checkbox" value="greg@datainn.co.nz" />
                        <a href="mailto:greg@datainn.co.nz">greg@datainn.co.nz</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_152">
                    <td><a id="name_152" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=cf92b25e-3f70-4fea-9692-2ba6c762015f" target="link">Jamie Barrett</a></td>
                    <td>
                        <input id="cb_text_152" name="cb_text_152" type="checkbox" value="0212615280" />
                        <a href="tel:0212615280">0212615280</a></td>
                    <td></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_92">
                    <td><a id="name_92" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=1ca4b223-d2f4-4ba8-ab0a-c4b9808bfa3f" target="link">Jennie Evans</a></td>
                    <td>
                        <input id="cb_text_92" name="cb_text_92" type="checkbox" value="0272548466" />
                        <a href="tel:0272548466">0272548466</a></td>
                    <td>
                        <input id="cb_email_92" name="cb_email_92" type="checkbox" value="bob.evans@xtra.co.nz" />
                        <a href="mailto:bob.evans@xtra.co.nz">bob.evans@xtra.co.nz</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_85">
                    <td class="auto-style1"><a id="name_85" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=ea740542-3df8-46e2-8cda-21e9c9066684" target="link">John Carter</a></td>
                    <td class="auto-style1">
                        <input id="cb_text_85" name="cb_text_85" type="checkbox" value="0274064449" />
                        <a href="tel:0274064449">0274064449</a></td>
                    <td class="auto-style1">
                        <input id="cb_email_85" name="cb_email_85" type="checkbox" value="normcarter@hotmail.com" />
                        <a href="mailto:normcarter@hotmail.com">normcarter@hotmail.com</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_2">
                    <td><a id="name_2" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=eba7104a-c6cd-4f5c-9cf2-26ba0f702303" target="link">Judy Kumeroa</a></td>
                    <td>
                        <input id="cb_text_2" name="cb_text_2" type="checkbox" value="0274266494" />
                        <a href="tel:0274266494">0274266494</a></td>
                    <td>
                        <input id="cb_email_2" name="cb_email_2" type="checkbox" value="jkumeroa@teorahou.org.nz" />
                        <a href="mailto:jkumeroa@teorahou.org.nz">jkumeroa@teorahou.org.nz</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_71">
                    <td><a id="name_71" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=5a0ef118-3412-4494-ae7b-45aa083209c0" target="link">Keri Browning</a></td>
                    <td>
                        <input id="cb_text_71" name="cb_text_71" type="checkbox" value="0273028275" />
                        <a href="tel:0273028275">0273028275</a></td>
                    <td>
                        <input id="cb_email_71" name="cb_email_71" type="checkbox" value="dawndale@xtra.co.nz" />
                        <a href="mailto:dawndale@xtra.co.nz">dawndale@xtra.co.nz</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_73">
                    <td><a id="name_73" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=be1a937c-41db-42ae-a7df-963457a9537a" target="link">Kylee Thompson</a></td>
                    <td>
                        <input id="cb_text_73" name="cb_text_73" type="checkbox" value="0210642533" />
                        <a href="tel:0210642533">0210642533</a></td>
                    <td>
                        <input id="cb_email_73" name="cb_email_73" type="checkbox" value="klthompson@slingshot.co.nz" />
                        <a href="mailto:klthompson@slingshot.co.nz">klthompson@slingshot.co.nz</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_72">
                    <td><a id="name_72" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=7cd85701-5e2d-4d99-9619-01c1c60e126d" target="link">Leah Johnston</a></td>
                    <td>
                        <input id="cb_text_72" name="cb_text_72" type="checkbox" value="0211364633" />
                        <a href="tel:0211364633">0211364633</a></td>
                    <td>
                        <input id="cb_email_72" name="cb_email_72" type="checkbox" value="klthompson@slingshot.co.nz" />
                        <a href="mailto:klthompson@slingshot.co.nz">klthompson@slingshot.co.nz</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_58">
                    <td><a id="name_58" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=4c61a20d-9a50-424e-aa5a-3fc3bf67f593" target="link">Lis Nielsen</a></td>
                    <td>
                        <input id="cb_text_58" name="cb_text_58" type="checkbox" value="0272421512" />
                        <a href="tel:0272421512">0272421512</a></td>
                    <td>
                        <input id="cb_email_58" name="cb_email_58" type="checkbox" value="thenielsens@xtra.co.nz" />
                        <a href="mailto:thenielsens@xtra.co.nz">thenielsens@xtra.co.nz</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_84">
                    <td><a id="name_84" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=ccdc92e3-f21f-4f9b-a54a-e0c7b92de0e9" target="link">Martin Bridger</a></td>
                    <td>
                        <input id="cb_text_84" name="cb_text_84" type="checkbox" value="0277668763" />
                        <a href="tel:0277668763">0277668763</a></td>
                    <td></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_153">
                    <td><a id="name_153" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=156ed048-a736-46c4-9987-def5ed55c450" target="link">Michael Mcleay</a></td>
                    <td>
                        <input id="cb_text_153" name="cb_text_153" type="checkbox" value="021518536" />
                        <a href="tel:021518536">021518536</a></td>
                    <td></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_68">
                    <td><a id="name_68" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=a694cd98-a62f-461f-8b64-2e91a2f439a8" target="link">Mike Connor</a></td>
                    <td></td>
                    <td>
                        <input id="cb_email_68" name="cb_email_68" type="checkbox" value="mikec@wcc.school.nz" />
                        <a href="mailto:mikec@wcc.school.nz">mikec@wcc.school.nz</a><br />
                        <input id="cb_email_68" name="cb_email_68" type="checkbox" value="liamikeco@gmail.com" />
                        <a href="mailto:liamikeco@gmail.com">liamikeco@gmail.com</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_67">
                    <td><a id="name_67" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=f4ce1fa9-13d2-4781-abaa-60ac995a6246" target="link">Mike O'Sullivan</a></td>
                    <td>
                        <input id="cb_text_67" name="cb_text_67" type="checkbox" value="0272888015" />
                        <a href="tel:0272888015">0272888015</a></td>
                    <td>
                        <input id="cb_email_67" name="cb_email_67" type="checkbox" value="mike@nzsurveyor.co.nz" />
                        <a href="mailto:mike@nzsurveyor.co.nz">mike@nzsurveyor.co.nz</a> - Work<br />
                        <input id="cb_email_67" name="cb_email_67" type="checkbox" value="mao.sullivan@xtra.co.nz" />
                        <a href="mailto:mao.sullivan@xtra.co.nz">mao.sullivan@xtra.co.nz</a> - Personal</td>
                </tr>
                <tr class="tr_person" id="tr_person_id_94">
                    <td><a id="name_94" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=f9ab7b5c-82c6-4d2d-871b-c09b17cadab0" target="link">Pat Carroll (Patrick)</a></td>
                    <td>
                        <input id="cb_text_94" name="cb_text_94" type="checkbox" value="0274443440" />
                        <a href="tel:0274443440">0274443440</a></td>
                    <td>
                        <input id="cb_email_94" name="cb_email_94" type="checkbox" value="pwcarroll98@gmail.com" />
                        <a href="mailto:pwcarroll98@gmail.com">pwcarroll98@gmail.com</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_57">
                    <td><a id="name_57" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=258bc86c-1d0f-472c-9ea7-d9bd1c9ed117" target="link">Peer Nielsen</a></td>
                    <td>
                        <input id="cb_text_57" name="cb_text_57" type="checkbox" value="0272770075" />
                        <a href="tel:0272770075">0272770075</a></td>
                    <td>
                        <input id="cb_email_57" name="cb_email_57" type="checkbox" value="thenielsens@xtra.co.nz" />
                        <a href="mailto:thenielsens@xtra.co.nz">thenielsens@xtra.co.nz</a></td>
                </tr>
                <tr class="tr_person" id="tr_person_id_107">
                    <td><a id="name_107" href="http://private.unionboatclub.co.nz/people/maint.aspx?id=3259e87c-09d2-444d-aa3c-e6f787a57feb" target="link">Rod Calder (Rodney)</a></td>
                    <td>
                        <input id="cb_text_107" name="cb_text_107" type="checkbox" value="027 537 9249" />
                        <a href="tel:027 537 9249">027 537 9249</a></td>
                    <td>
                        <input id="cb_email_107" name="cb_email_107" type="checkbox" value="rod-calder@xtra.co.nz" />
                        <a href="mailto:rod-calder@xtra.co.nz">rod-calder@xtra.co.nz</a></td>
                </tr>

            </tbody>
        </table>
        <div id="dialog_sending" title="Sending ..." style="display: none">
            <table id="tbl_results" class="table table-hover">
                <thead>
                    <tr>
                        <th>Result</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div id="test">

            
        </div>
    </form>
</body>
</html>
