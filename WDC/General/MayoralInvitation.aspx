<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MayoralInvitation.aspx.cs" Inherits="Online.General.MayoralInvitation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FileUpload ID="fu_dummy" runat="server" Style="display: none" />
    <!--Forces form to be rendered with enctype="multipart/form-data" -->
    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <asp:Literal ID="lit_user" runat="server"></asp:Literal>
    <h1>Mayoral Invitation</h1>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_host">Name of host organisation</label><div class="col-sm-8">
            <input type="text" id="tb_host" name="tb_host" class="form-control" maxlength="100" value="<%: tb_host %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_requiredtospeak">Is Mayor Hamish McDouall required to speak at this event?</label><div class="col-sm-8">
            <input type="text" id="dd_requiredtospeak" name="dd_requiredtospeak" class="form-control" maxlength="100" value="<%: dd_requiredtospeak %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_eventtype">Type of event the Mayor is being invited to (eg conference, launch, cocktail function) </label>
        <div class="col-sm-8">
            <input type="text" id="tb_eventtype" name="tb_eventtype" class="form-control" maxlength="100" value="<%: tb_eventtype %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_eventtitle">Title of event</label><div class="col-sm-8">
            <input type="text" id="tb_eventtitle" name="tb_eventtitle" class="form-control" maxlength="100" value="<%: tb_eventtitle %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_eventpurpose">Purpose of event (objectives, planned outcomes)</label><div class="col-sm-8">
            <input type="text" id="tb_eventpurpose" name="tb_eventpurpose" class="form-control" maxlength="100" value="<%: tb_eventpurpose %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_eventdatetime">Day, date and timeframe of Mayor's attendance</label><div class="col-sm-8">
            <input type="text" id="tb_eventdatetime" name="tb_eventdatetime" class="form-control" maxlength="100" value="<%: tb_eventdatetime %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_arrivaltime">Please ensure you indicate the desired full timeframe of Mayor's attendance, ie include what time you would like her to arrive and depart as well as his speaking time</label><div class="col-sm-8">
            <input type="text" id="tb_arrivaltime" name="tb_arrivaltime" class="form-control" maxlength="100" value="<%: tb_arrivaltime %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_departuretime">Departure time</label><div class="col-sm-8">
            <input type="text" id="tb_departuretime" name="tb_departuretime" class="form-control" maxlength="100" value="<%: tb_departuretime %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_venue">Venue (please include street address and city/town)</label><div class="col-sm-8">
            <input type="text" id="tb_venue" name="tb_venue" class="form-control" maxlength="100" value="<%: tb_venue %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_media">Are media being invited?</label><div class="col-sm-8">
            <input type="text" id="dd_media" name="dd_media" class="form-control" maxlength="100" value="<%: dd_media %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_conferenceprogramme">Please provide a programme for the full conference (or an indicative outline, with a full programme provided at a later stage), particularly indicating what is scheduled to take place before and after the Mayor's speech </label>
        <div class="col-sm-8">
            <input type="text" id="tb_conferenceprogramme" name="tb_conferenceprogramme" class="form-control" maxlength="100" value="<%: tb_conferenceprogramme %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_launchprogramme">If a launch/function, please provide an outline of the programme</label><div class="col-sm-8">
            <input type="text" id="tb_launchprogramme" name="tb_launchprogramme" class="form-control" maxlength="100" value="<%: tb_launchprogramme %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_presentationdetail">If the Mayor is being asked to make a presentation to someone (eg an award), please provide details of what the presentation is, what the Mayor is required to do, who the presentation is to etc</label><div class="col-sm-8">
            <input type="text" id="tb_presentationdetail" name="tb_presentationdetail" class="form-control" maxlength="100" value="<%: tb_presentationdetail %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dressstandard">Standard of dress – please advise if this is an event requiring dress other than normal business attire, and if so what (eg smart casual; formal/black tie)</label><div class="col-sm-8">
            <input type="text" id="tb_dressstandard" name="tb_dressstandard" class="form-control" maxlength="100" value="<%: tb_dressstandard %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_organisationeventpurpose">Please tell us about the purpose of your organisation/event. Please give as much detail as possible. For example: How long your organisation has been around? What is its purpose or strategy? What are some of its achievements? Why is this event so important? </label>
        <div class="col-sm-8">
            <input type="text" id="tb_organisationeventpurpose" name="tb_organisationeventpurpose" class="form-control" maxlength="100" value="<%: tb_organisationeventpurpose %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_website">organisation/event website.</label><div class="col-sm-8">
            <input type="text" id="tb_website" name="tb_website" class="form-control" maxlength="100" value="<%: tb_website %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="_">The Mayor normally speaks for a maximum of 10 minutes for a key speech; 5-10 minutes at a function</label><div class="col-sm-8">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_speechacknowledge">Please indicate any persons the Mayor should acknowledge at the start of his speech</label><div class="col-sm-8">
            <input type="text" id="tb_speechacknowledge" name="tb_speechacknowledge" class="form-control" maxlength="100" value="<%: tb_speechacknowledge %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_speechissues">Content of Mayor's speech – please indicate what issues you consider will be of interest to the audience.  Please be as detailed as possible</label><div class="col-sm-8">
            <input type="text" id="tb_speechissues" name="tb_speechissues" class="form-control" maxlength="100" value="<%: tb_speechissues %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_speechstyle">Speech style – please provide any contextual information which will assist with pitching the speech at the appropriate level (eg is the speech is taking place in a formal setting, is it taking place 'after dinner')</label><div class="col-sm-8">
            <input type="text" id="tb_speechstyle" name="tb_speechstyle" class="form-control" maxlength="100" value="<%: tb_speechstyle %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_questions">Is there to be a Question and Answer session following the speech?</label><div class="col-sm-8">
            <input type="text" id="tb_questions" name="tb_questions" class="form-control" maxlength="100" value="<%: tb_questions %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_questionperiod">If so, how long will this session be? </label>
        <div class="col-sm-8">
            <input type="text" id="tb_questionperiod" name="tb_questionperiod" class="form-control" maxlength="100" value="<%: tb_questionperiod %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_questionexamples">Please provide an indication of the questions the Mayor may be asked</label><div class="col-sm-8">
            <input type="text" id="tb_questionexamples" name="tb_questionexamples" class="form-control" maxlength="100" value="<%: tb_questionexamples %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_otherspeakers">Who else has been invited to speak (in particular, are other Councillors or MPs being invited to speak)?</label><div class="col-sm-8">
            <input type="text" id="tb_otherspeakers" name="tb_otherspeakers" class="form-control" maxlength="100" value="<%: tb_otherspeakers %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_introductionby">Who will be introducing/thanking the Mayor?</label><div class="col-sm-8">
            <input type="text" id="tb_introductionby" name="tb_introductionby" class="form-control" maxlength="100" value="<%: tb_introductionby %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="_">Attendees:</label><div class="col-sm-8">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_attendeedetails">Please provide a guest list if possible, or indicate the makeup of the audience</label><div class="col-sm-8">
            <input type="text" id="tb_attendeedetails" name="tb_attendeedetails" class="form-control" maxlength="100" value="<%: tb_attendeedetails %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="_">(note that this information also assists with ensuring the Mayor's speech is pitched correctly)</label><div class="col-sm-8">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_prominentgovernmentattendees">Are other Councillors, Ministers and/or MPs being invited to attend? If so, who?</label><div class="col-sm-8">
            <input type="text" id="tb_prominentgovernmentattendees" name="tb_prominentgovernmentattendees" class="form-control" maxlength="100" value="<%: tb_prominentgovernmentattendees %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_prominentotherattendees">Please indicate any other important guests the Mayor should be aware of</label><div class="col-sm-8">
            <input type="text" id="tb_prominentotherattendees" name="tb_prominentotherattendees" class="form-control" maxlength="100" value="<%: tb_prominentotherattendees %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_totalattendeesexpected">How many people in total are being invited or are expected to attend?</label><div class="col-sm-8">
            <input type="text" id="tb_totalattendeesexpected" name="tb_totalattendeesexpected" class="form-control" maxlength="100" value="<%: tb_totalattendeesexpected %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="_">Venue:</label><div class="col-sm-8">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_venuelayout">How will the venue be laid out? (eg lecture style with podium at front / meeting around a table / informal, people standing, with or without podium) note: if given a choice, the Mayor’s preference is a podium</label><div class="col-sm-8">
            <input type="text" id="tb_venuelayout" name="tb_venuelayout" class="form-control" maxlength="100" value="<%: tb_venuelayout %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="_">Contact details:</label><div class="col-sm-8">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_organisationalcontact">For organisational issues around the Mayor's attendance (name, telephone number, mobile number email address)</label><div class="col-sm-8">
            <input type="text" id="tb_organisationalcontact" name="tb_organisationalcontact" class="form-control" maxlength="100" value="<%: tb_organisationalcontact %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_daycontact">On the day, at the venue (mobile number, and land-line number if possible) </label>
        <div class="col-sm-8">
            <input type="text" id="tb_daycontact" name="tb_daycontact" class="form-control" maxlength="100" value="<%: tb_daycontact %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_mediacontact">Often photographs are taken during the Mayors visit.  If the organisation takes any photos, we would be grateful to receive copies.  Often a staff member accompanying the Mayor will take photos.  In order for us to use/publish any photos taken, we need to obtain consent from the people in the photos.  Please supply an appropriate contact (name, telephone number and email address) for the Mayor's office to contact, following the visit, to arrange consent</label><div class="col-sm-8">
            <input type="text" id="tb_mediacontact" name="tb_mediacontact" class="form-control" maxlength="100" value="<%: tb_mediacontact %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="_">Whakatau:</label><div class="col-sm-8">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_whakatau">Will there be a mihi whakatau/pōhiri?</label><div class="col-sm-8">
            <input type="text" id="tb_whakatau" name="tb_whakatau" class="form-control" maxlength="100" value="<%: tb_whakatau %>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="_">Note: Do not feel pressured to organise a mihi whakatau for the Mayor, we are well aware that the time available to you is limited</label><div class="col-sm-8">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="_">Other:</label><div class="col-sm-8">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_questionscomments">Do you have any questions you need answered in relation to the Mayor's attendance?</label><div class="col-sm-8">
            <input type="text" id="tb_questionscomments" name="tb_questionscomments" class="form-control" maxlength="100" value="<%: tb_questionscomments %>" required />
        </div>
    </div>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
