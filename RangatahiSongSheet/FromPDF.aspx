<%@ Page Title="" Language="C#" MasterPageFile="~/RangatahiSongSheet.Master" AutoEventWireup="true" CodeBehind="FromPDF.aspx.cs" Inherits="RangatahiSongSheet.FromPDF" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
<!--
span.cls_002{font-family:Arial,serif;font-size:18.1px;color:rgb(43,42,41);font-weight:bold;font-style:normal;text-decoration: none}
div.cls_002{font-family:Arial,serif;font-size:18.1px;color:rgb(43,42,41);font-weight:bold;font-style:normal;text-decoration: none}
span.cls_003{font-family:Arial,serif;font-size:10.1px;color:rgb(255,83,2);font-weight:bold;font-style:normal;text-decoration: none}
div.cls_003{font-family:Arial,serif;font-size:10.1px;color:rgb(255,83,2);font-weight:bold;font-style:normal;text-decoration: none}
span.cls_004{font-family:Arial,serif;font-size:10.1px;color:rgb(43,42,41);font-weight:bold;font-style:normal;text-decoration: none}
div.cls_004{font-family:Arial,serif;font-size:10.1px;color:rgb(43,42,41);font-weight:bold;font-style:normal;text-decoration: none}
span.cls_005{font-family:Arial,serif;font-size:10.1px;color:rgb(43,42,41);font-weight:normal;font-style:normal;text-decoration: none}
div.cls_005{font-family:Arial,serif;font-size:10.1px;color:rgb(43,42,41);font-weight:normal;font-style:normal;text-decoration: none}
span.cls_006{font-family:Arial,serif;font-size:12.1px;color:rgb(43,42,41);font-weight:bold;font-style:normal;text-decoration: none}
div.cls_006{font-family:Arial,serif;font-size:12.1px;color:rgb(43,42,41);font-weight:bold;font-style:normal;text-decoration: none}
span.cls_007{font-family:Arial,serif;font-size:30.1px;color:rgb(254,255,255);font-weight:bold;font-style:normal;text-decoration: none}
div.cls_007{font-family:Arial,serif;font-size:30.1px;color:rgb(254,255,255);font-weight:bold;font-style:normal;text-decoration: none}
span.cls_008{font-family:Arial,serif;font-size:10.1px;color:rgb(254,255,255);font-weight:normal;font-style:normal;text-decoration: none}
div.cls_008{font-family:Arial,serif;font-size:10.1px;color:rgb(254,255,255);font-weight:normal;font-style:normal;text-decoration: none}
span.cls_009{font-family:Arial,serif;font-size:9.1px;color:rgb(43,42,41);font-weight:normal;font-style:normal;text-decoration: none}
div.cls_009{font-family:Arial,serif;font-size:9.1px;color:rgb(43,42,41);font-weight:normal;font-style:normal;text-decoration: none}
span.cls_010{font-family:Arial,serif;font-size:11.1px;color:rgb(43,42,41);font-weight:bold;font-style:normal;text-decoration: none}
div.cls_010{font-family:Arial,serif;font-size:11.1px;color:rgb(43,42,41);font-weight:bold;font-style:normal;text-decoration: none}
span.cls_011{font-family:Arial,serif;font-size:10.1px;color:rgb(254,255,255);font-weight:bold;font-style:normal;text-decoration: none}
div.cls_011{font-family:Arial,serif;font-size:10.1px;color:rgb(254,255,255);font-weight:bold;font-style:normal;text-decoration: none}
span.cls_012{font-family:Arial,serif;font-size:10.1px;color:rgb(50,61,133);font-weight:bold;font-style:normal;text-decoration: none}
div.cls_012{font-family:Arial,serif;font-size:10.1px;color:rgb(50,61,133);font-weight:bold;font-style:normal;text-decoration: none}
span.cls_013{font-family:Arial,serif;font-size:10.1px;color:rgb(69,166,61);font-weight:bold;font-style:normal;text-decoration: none}
div.cls_013{font-family:Arial,serif;font-size:10.1px;color:rgb(69,166,61);font-weight:bold;font-style:normal;text-decoration: none}
span.cls_014{font-family:Arial,serif;font-size:10.1px;color:rgb(50,61,133);font-weight:normal;font-style:normal;text-decoration: none}
div.cls_014{font-family:Arial,serif;font-size:10.1px;color:rgb(50,61,133);font-weight:normal;font-style:normal;text-decoration: none}
span.cls_015{font-family:Arial,serif;font-size:10.1px;color:rgb(69,166,61);font-weight:normal;font-style:normal;text-decoration: none}
div.cls_015{font-family:Arial,serif;font-size:10.1px;color:rgb(69,166,61);font-weight:normal;font-style:normal;text-decoration: none}
span.cls_016{font-family:Arial,serif;font-size:14.1px;color:rgb(43,42,41);font-weight:bold;font-style:normal;text-decoration: none}
div.cls_016{font-family:Arial,serif;font-size:14.1px;color:rgb(43,42,41);font-weight:bold;font-style:normal;text-decoration: none}
-->
</style>
<script type="text/javascript" src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/wz_jsgraphics.js"></script>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="position:absolute;left:50%;margin-left:-297px;top:0px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background01.jpg" width=595 height=841></div>
<div style="position:absolute;left:168.72px;top:206.45px" class="cls_002"><span class="cls_002">Whanganui</span></div>
<div style="position:absolute;left:168.72px;top:228.45px" class="cls_002"><span class="cls_002">Rangatahi Maori</span></div>
<div style="position:absolute;left:168.72px;top:250.45px" class="cls_002"><span class="cls_002">Wellbeing</span></div>
<div style="position:absolute;left:168.72px;top:342.33px" class="cls_003"><span class="cls_003">Bringing all rangatahi Maori to a space of wellbeing.</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:851px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background02.jpg" width=595 height=841></div>
<div style="position:absolute;left:68.03px;top:79.45px" class="cls_004"><span class="cls_004">Notes of Hui</span></div>
<div style="position:absolute;left:68.03px;top:101.29px" class="cls_005"><span class="cls_005">This is the work of all those who took part in</span></div>
<div style="position:absolute;left:68.03px;top:116.29px" class="cls_005"><span class="cls_005">the process of identifying the strengths, the</span></div>
<div style="position:absolute;left:68.03px;top:131.29px" class="cls_005"><span class="cls_005">unhealthy bits, the aspirations of and for</span></div>
<div style="position:absolute;left:68.03px;top:146.29px" class="cls_005"><span class="cls_005">rangatahi Maori across Whanganui.</span></div>
<div style="position:absolute;left:68.03px;top:172.63px" class="cls_005"><span class="cls_005">The people included rangatahi, whanau</span></div>
<div style="position:absolute;left:68.03px;top:187.63px" class="cls_005"><span class="cls_005">members, schools, government agencies,</span></div>
<div style="position:absolute;left:68.03px;top:202.63px" class="cls_005"><span class="cls_005">community services, churches, sports groups,</span></div>
<div style="position:absolute;left:68.03px;top:217.63px" class="cls_005"><span class="cls_005">nurses, and people who don’t necessarily</span></div>
<div style="position:absolute;left:68.03px;top:232.63px" class="cls_005"><span class="cls_005">have a ‘tag’ but care about the wellbeing of</span></div>
<div style="position:absolute;left:68.03px;top:247.63px" class="cls_005"><span class="cls_005">rangatahi Maori.</span></div>
<div style="position:absolute;left:68.03px;top:273.97px" class="cls_005"><span class="cls_005">This is the record of notes taken at large hui</span></div>
<div style="position:absolute;left:68.03px;top:288.97px" class="cls_005"><span class="cls_005">and small group hui from September 2018 to</span></div>
<div style="position:absolute;left:68.03px;top:303.97px" class="cls_005"><span class="cls_005">March 2019.</span></div>
<div style="position:absolute;left:68.03px;top:330.31px" class="cls_005"><span class="cls_005">It is collated in this way so we don’t lose the</span></div>
<div style="position:absolute;left:68.03px;top:345.31px" class="cls_005"><span class="cls_005">rich ideas that came forth at each hui.</span></div>
<div style="position:absolute;left:68.03px;top:371.65px" class="cls_005"><span class="cls_005">It is a snapshot of those moments and we</span></div>
<div style="position:absolute;left:68.03px;top:386.65px" class="cls_005"><span class="cls_005">recognise the inestimable valuable of</span></div>
<div style="position:absolute;left:68.03px;top:401.65px" class="cls_005"><span class="cls_005">ongoing conversations that nurture a seed</span></div>
<div style="position:absolute;left:68.03px;top:416.65px" class="cls_005"><span class="cls_005">of an idea and grow it to something else.</span></div>
<div style="position:absolute;left:68.03px;top:431.65px" class="cls_005"><span class="cls_005">We may never know</span></div>
<div style="position:absolute;left:68.03px;top:457.98px" class="cls_005"><span class="cls_005">what ideas grew from the many conversations</span></div>
<div style="position:absolute;left:68.03px;top:472.98px" class="cls_005"><span class="cls_005">in the hui and outside the hui.</span></div>
<div style="position:absolute;left:68.03px;top:499.32px" class="cls_005"><span class="cls_005">If you have any questions, please contact</span></div>
<div style="position:absolute;left:68.03px;top:552.00px" class="cls_005"><span class="cls_005">Jay Rerekura</span></div>
<div style="position:absolute;left:160.70px;top:552.00px" class="cls_005"><span class="cls_005">Judy Kumeroa</span></div>
<div style="position:absolute;left:68.03px;top:567.00px" class="cls_005"><span class="cls_005">jay@ntota.co.nz   jkumeroa@teorahou.org.nz</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:1702px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background03.jpg" width=595 height=841></div>
<div style="position:absolute;left:68.03px;top:79.55px" class="cls_006"><span class="cls_006">Contents</span></div>
<div style="position:absolute;left:68.03px;top:103.39px" class="cls_005"><span class="cls_005">Our ‘Why’.</span></div>
<div style="position:absolute;left:68.03px;top:129.73px" class="cls_005"><span class="cls_005">Alcohol and other drugs</span></div>
<div style="position:absolute;left:68.03px;top:156.07px" class="cls_005"><span class="cls_005">Sexual Wellbeing</span></div>
<div style="position:absolute;left:68.03px;top:182.41px" class="cls_005"><span class="cls_005">Learning Environments</span></div>
<div style="position:absolute;left:68.03px;top:208.75px" class="cls_005"><span class="cls_005">Kaupapa Whanau</span></div>
<div style="position:absolute;left:68.03px;top:235.08px" class="cls_005"><span class="cls_005">Wairua</span></div>
<div style="position:absolute;left:68.03px;top:261.42px" class="cls_005"><span class="cls_005">Employment Career & Independence.</span></div>
<div style="position:absolute;left:68.03px;top:287.76px" class="cls_005"><span class="cls_005">Housing.</span></div>
<div style="position:absolute;left:68.03px;top:314.10px" class="cls_005"><span class="cls_005">Connected & Participating</span></div>
<div style="position:absolute;left:68.03px;top:340.44px" class="cls_005"><span class="cls_005">Hinengaro.</span></div>
<div style="position:absolute;left:68.03px;top:366.78px" class="cls_005"><span class="cls_005">Whakapapa Whanau</span></div>
<div style="position:absolute;left:68.03px;top:393.12px" class="cls_005"><span class="cls_005">Tinana</span></div>
<div style="position:absolute;left:68.03px;top:419.45px" class="cls_005"><span class="cls_005">Added Ideas</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:2553px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background04.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.37px" class="cls_002"><span class="cls_002">Our Why</span></div>
<div style="position:absolute;left:102.87px;top:77.59px" class="cls_007"><span class="cls_007">1.</span></div>
<div style="position:absolute;left:130.40px;top:123.58px" class="cls_008"><span class="cls_008">Hui 06/09/2018 @ Racecourse, 90+ people including parents, tertiary</span></div>
<div style="position:absolute;left:126.20px;top:135.58px" class="cls_008"><span class="cls_008">students, young adults, representatives of churches and agencies and</span></div>
<div style="position:absolute;left:216.93px;top:147.58px" class="cls_008"><span class="cls_008">community agencies and schools.</span></div>
<div style="position:absolute;left:87.06px;top:223.97px" class="cls_004"><span class="cls_004">Our WHY’s from beginning of our hui:</span></div>
<div style="position:absolute;left:84.58px;top:245.80px" class="cls_005"><span class="cls_005">• Parent voice</span></div>
<div style="position:absolute;left:234.97px;top:245.80px" class="cls_005"><span class="cls_005">• More support needed</span></div>
<div style="position:absolute;left:385.36px;top:245.80px" class="cls_005"><span class="cls_005">• Community</span></div>
<div style="position:absolute;left:84.58px;top:257.80px" class="cls_005"><span class="cls_005">• Empowerment</span></div>
<div style="position:absolute;left:234.97px;top:257.80px" class="cls_005"><span class="cls_005">• Networking</span></div>
<div style="position:absolute;left:385.36px;top:257.80px" class="cls_005"><span class="cls_005">• Passionate</span></div>
<div style="position:absolute;left:84.58px;top:269.80px" class="cls_005"><span class="cls_005">• Freedom</span></div>
<div style="position:absolute;left:234.97px;top:269.80px" class="cls_005"><span class="cls_005">• Connection</span></div>
<div style="position:absolute;left:385.36px;top:269.80px" class="cls_005"><span class="cls_005">• Because they matter</span></div>
<div style="position:absolute;left:84.58px;top:281.80px" class="cls_005"><span class="cls_005">• Guide</span></div>
<div style="position:absolute;left:234.97px;top:281.80px" class="cls_005"><span class="cls_005">• All rangatahi matter</span></div>
<div style="position:absolute;left:385.36px;top:281.80px" class="cls_005"><span class="cls_005">• Schools kill creativity</span></div>
<div style="position:absolute;left:84.58px;top:293.80px" class="cls_005"><span class="cls_005">• Learn to inform</span></div>
<div style="position:absolute;left:234.97px;top:293.80px" class="cls_005"><span class="cls_005">• Because I care</span></div>
<div style="position:absolute;left:385.36px;top:293.80px" class="cls_005"><span class="cls_005">• Influence positive</span></div>
<div style="position:absolute;left:84.58px;top:305.80px" class="cls_005"><span class="cls_005">• Building together</span></div>
<div style="position:absolute;left:234.97px;top:305.80px" class="cls_005"><span class="cls_005">• Belonging</span></div>
<div style="position:absolute;left:403.36px;top:305.80px" class="cls_005"><span class="cls_005">change</span></div>
<div style="position:absolute;left:84.58px;top:317.80px" class="cls_005"><span class="cls_005">• Depression</span></div>
<div style="position:absolute;left:234.97px;top:317.80px" class="cls_005"><span class="cls_005">• Explore</span></div>
<div style="position:absolute;left:385.36px;top:317.80px" class="cls_005"><span class="cls_005">• Innovate change</span></div>
<div style="position:absolute;left:84.58px;top:329.80px" class="cls_005"><span class="cls_005">• Addictions</span></div>
<div style="position:absolute;left:234.97px;top:329.80px" class="cls_005"><span class="cls_005">• Hunger</span></div>
<div style="position:absolute;left:385.36px;top:329.80px" class="cls_005"><span class="cls_005">• Empower rangatahi</span></div>
<div style="position:absolute;left:84.58px;top:341.80px" class="cls_005"><span class="cls_005">• Suicide</span></div>
<div style="position:absolute;left:234.97px;top:341.80px" class="cls_005"><span class="cls_005">• Tikanga</span></div>
<div style="position:absolute;left:403.36px;top:341.80px" class="cls_005"><span class="cls_005">vision</span></div>
<div style="position:absolute;left:84.58px;top:353.80px" class="cls_005"><span class="cls_005">• Harness</span></div>
<div style="position:absolute;left:234.97px;top:353.80px" class="cls_005"><span class="cls_005">• Youth can move the</span></div>
<div style="position:absolute;left:385.36px;top:353.80px" class="cls_005"><span class="cls_005">• Better facility’s to sustain</span></div>
<div style="position:absolute;left:84.58px;top:365.80px" class="cls_005"><span class="cls_005">• Potential</span></div>
<div style="position:absolute;left:252.97px;top:365.80px" class="cls_005"><span class="cls_005">world</span></div>
<div style="position:absolute;left:385.36px;top:365.80px" class="cls_005"><span class="cls_005">• Better supply’s</span></div>
<div style="position:absolute;left:84.58px;top:377.80px" class="cls_005"><span class="cls_005">• Contribution</span></div>
<div style="position:absolute;left:234.97px;top:377.80px" class="cls_005"><span class="cls_005">• Influences</span></div>
<div style="position:absolute;left:385.36px;top:377.80px" class="cls_005"><span class="cls_005">• Aroha</span></div>
<div style="position:absolute;left:84.58px;top:389.80px" class="cls_005"><span class="cls_005">• Results</span></div>
<div style="position:absolute;left:234.97px;top:389.80px" class="cls_005"><span class="cls_005">• Encourage</span></div>
<div style="position:absolute;left:385.36px;top:389.80px" class="cls_005"><span class="cls_005">• Sport</span></div>
<div style="position:absolute;left:84.58px;top:401.80px" class="cls_005"><span class="cls_005">• Purpose</span></div>
<div style="position:absolute;left:234.97px;top:401.80px" class="cls_005"><span class="cls_005">• Rangatahi have a voice</span></div>
<div style="position:absolute;left:385.36px;top:401.80px" class="cls_005"><span class="cls_005">• Parenting</span></div>
<div style="position:absolute;left:84.58px;top:413.80px" class="cls_005"><span class="cls_005">• Personal development</span></div>
<div style="position:absolute;left:234.97px;top:413.80px" class="cls_005"><span class="cls_005">• Future</span></div>
<div style="position:absolute;left:385.36px;top:413.80px" class="cls_005"><span class="cls_005">• Togetherness</span></div>
<div style="position:absolute;left:84.58px;top:425.80px" class="cls_005"><span class="cls_005">• Collaboration</span></div>
<div style="position:absolute;left:234.97px;top:425.80px" class="cls_005"><span class="cls_005">• Do it different</span></div>
<div style="position:absolute;left:385.36px;top:425.80px" class="cls_005"><span class="cls_005">• Revolution for change</span></div>
<div style="position:absolute;left:84.58px;top:437.80px" class="cls_005"><span class="cls_005">• Results</span></div>
<div style="position:absolute;left:234.97px;top:437.80px" class="cls_005"><span class="cls_005">• Hope</span></div>
<div style="position:absolute;left:385.36px;top:437.80px" class="cls_005"><span class="cls_005">• Individual well-being</span></div>
<div style="position:absolute;left:84.58px;top:449.80px" class="cls_005"><span class="cls_005">• Change</span></div>
<div style="position:absolute;left:234.97px;top:449.80px" class="cls_005"><span class="cls_005">• My responsibility</span></div>
<div style="position:absolute;left:296.02px;top:813.15px" class="cls_004"><span class="cls_004">1</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:3404px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background05.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.13px" class="cls_002"><span class="cls_002">Alcohol and Other Drugs</span></div>
<div style="position:absolute;left:102.87px;top:77.59px" class="cls_007"><span class="cls_007">2.</span></div>
<div style="position:absolute;left:95.85px;top:123.78px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.83px;top:135.78px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.44px;top:147.78px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:79.70px;top:178.35px" class="cls_004"><span class="cls_004">What are the strengths? (in these areas, in relation to rangatahi Maori)</span></div>
<div style="position:absolute;left:68.03px;top:200.14px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:200.14px" class="cls_009"><span class="cls_009">Advertise the most alternative options/</span></div>
<div style="position:absolute;left:304.25px;top:199.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:199.46px" class="cls_009"><span class="cls_009">Tag the skate park - services available to youth</span></div>
<div style="position:absolute;left:78.03px;top:211.14px" class="cls_009"><span class="cls_009">Advertise Youth Groups/ promotion of services</span></div>
<div style="position:absolute;left:314.25px;top:210.46px" class="cls_009"><span class="cls_009">people - Public loose door info</span></div>
<div style="position:absolute;left:78.03px;top:222.14px" class="cls_009"><span class="cls_009">available/Advertising services / Health network</span></div>
<div style="position:absolute;left:304.25px;top:225.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:225.72px" class="cls_009"><span class="cls_009">A+D services available via DHB</span></div>
<div style="position:absolute;left:78.03px;top:233.14px" class="cls_009"><span class="cls_009">advertised online -App free database - self</span></div>
<div style="position:absolute;left:304.25px;top:240.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:240.97px" class="cls_009"><span class="cls_009">Connecting the services networking</span></div>
<div style="position:absolute;left:78.03px;top:244.14px" class="cls_009"><span class="cls_009">refer  - Criteria listed - Clear</span></div>
<div style="position:absolute;left:304.25px;top:256.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:256.22px" class="cls_009"><span class="cls_009">Education in the schools - Ball, Stages of</span></div>
<div style="position:absolute;left:68.03px;top:259.39px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:259.39px" class="cls_009"><span class="cls_009">A new AOD support has been created in</span></div>
<div style="position:absolute;left:314.25px;top:267.22px" class="cls_009"><span class="cls_009">drunkenness</span></div>
<div style="position:absolute;left:78.03px;top:270.39px" class="cls_009"><span class="cls_009">Raetahi to support rural areas with isolation</span></div>
<div style="position:absolute;left:78.03px;top:281.39px" class="cls_009"><span class="cls_009">community center / AOD support Whanganui</span></div>
<div style="position:absolute;left:304.25px;top:282.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:282.47px" class="cls_009"><span class="cls_009">Early intervention</span></div>
<div style="position:absolute;left:78.03px;top:292.39px" class="cls_009"><span class="cls_009">DH Thurs 6pm - Weds 1pm</span></div>
<div style="position:absolute;left:304.25px;top:297.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:297.72px" class="cls_009"><span class="cls_009">Free services</span></div>
<div style="position:absolute;left:68.03px;top:307.64px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:307.64px" class="cls_009"><span class="cls_009">Parents responsible drinking / youth -</span></div>
<div style="position:absolute;left:304.25px;top:312.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:312.98px" class="cls_009"><span class="cls_009">Positive alternative activities/ YMCA /Club</span></div>
<div style="position:absolute;left:78.03px;top:318.64px" class="cls_009"><span class="cls_009">education drinking culture</span></div>
<div style="position:absolute;left:314.25px;top:323.98px" class="cls_009"><span class="cls_009">house/Youth Group/Te Ora Hou</span></div>
<div style="position:absolute;left:68.03px;top:333.90px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:333.90px" class="cls_009"><span class="cls_009">Better outlets for family interaction so that less</span></div>
<div style="position:absolute;left:304.25px;top:339.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:339.23px" class="cls_009"><span class="cls_009">Salvation army /Church/ Grace foundation</span></div>
<div style="position:absolute;left:78.03px;top:344.90px" class="cls_009"><span class="cls_009">focus on AOD growing up and the whanau</span></div>
<div style="position:absolute;left:304.25px;top:354.48px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:354.48px" class="cls_009"><span class="cls_009">Man-Up</span></div>
<div style="position:absolute;left:68.03px;top:360.15px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:360.15px" class="cls_009"><span class="cls_009">12 step programs AA /Na /Alcohol & emotions</span></div>
<div style="position:absolute;left:78.03px;top:371.15px" class="cls_009"><span class="cls_009">anonymous available Recovery church Friday</span></div>
<div style="position:absolute;left:304.25px;top:369.73px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:369.73px" class="cls_009"><span class="cls_009">Te Oranganui</span></div>
<div style="position:absolute;left:78.03px;top:382.15px" class="cls_009"><span class="cls_009">6pm</span></div>
<div style="position:absolute;left:304.25px;top:384.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:384.98px" class="cls_009"><span class="cls_009">Quit clinic</span></div>
<div style="position:absolute;left:68.03px;top:397.40px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:397.40px" class="cls_009"><span class="cls_009">Bring the problems in our community to</span></div>
<div style="position:absolute;left:304.25px;top:400.24px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:400.24px" class="cls_009"><span class="cls_009">Utilizing Te Whare tapa wha model</span></div>
<div style="position:absolute;left:78.03px;top:408.40px" class="cls_009"><span class="cls_009">light / can’t address what we won’t admit is</span></div>
<div style="position:absolute;left:304.25px;top:415.49px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:415.49px" class="cls_009"><span class="cls_009">Mental health & well-being support / family</span></div>
<div style="position:absolute;left:78.03px;top:419.40px" class="cls_009"><span class="cls_009">happening</span></div>
<div style="position:absolute;left:314.25px;top:426.49px" class="cls_009"><span class="cls_009">support</span></div>
<div style="position:absolute;left:68.03px;top:434.65px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:434.65px" class="cls_009"><span class="cls_009">Community hui to address all like Ngati Rangi</span></div>
<div style="position:absolute;left:304.25px;top:441.74px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:441.74px" class="cls_009"><span class="cls_009">Whanau support</span></div>
<div style="position:absolute;left:78.03px;top:445.65px" class="cls_009"><span class="cls_009">did/ this hui is good to bring people together</span></div>
<div style="position:absolute;left:78.03px;top:456.65px" class="cls_009"><span class="cls_009">with collective knowledge</span></div>
<div style="position:absolute;left:304.25px;top:456.99px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:456.99px" class="cls_009"><span class="cls_009">Legislation</span></div>
<div style="position:absolute;left:68.03px;top:471.90px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:471.90px" class="cls_009"><span class="cls_009">More in school groups running and in</span></div>
<div style="position:absolute;left:304.25px;top:472.24px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:472.24px" class="cls_009"><span class="cls_009">Social media</span></div>
<div style="position:absolute;left:78.03px;top:482.90px" class="cls_009"><span class="cls_009">community groups for those not in school</span></div>
<div style="position:absolute;left:304.25px;top:487.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:487.50px" class="cls_009"><span class="cls_009">Better connection</span></div>
<div style="position:absolute;left:78.03px;top:493.90px" class="cls_009"><span class="cls_009">such as smashed and stored as we have the</span></div>
<div style="position:absolute;left:78.03px;top:504.90px" class="cls_009"><span class="cls_009">facilitators in our community</span></div>
<div style="position:absolute;left:79.70px;top:525.74px" class="cls_004"><span class="cls_004">What are the Challenges?</span></div>
<div style="position:absolute;left:68.03px;top:547.53px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:547.53px" class="cls_009"><span class="cls_009">Prescription drugs / recreational drugs/ Drugs</span></div>
<div style="position:absolute;left:304.25px;top:547.53px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:547.53px" class="cls_009"><span class="cls_009">Privacy laws a challenge</span></div>
<div style="position:absolute;left:78.03px;top:558.53px" class="cls_009"><span class="cls_009">& Alcohol available/ Drinking culture binge/</span></div>
<div style="position:absolute;left:304.25px;top:562.78px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:562.78px" class="cls_009"><span class="cls_009">Show box not shares info</span></div>
<div style="position:absolute;left:78.03px;top:569.53px" class="cls_009"><span class="cls_009">Don’t legalize weed /Drinking culture /too</span></div>
<div style="position:absolute;left:78.03px;top:580.53px" class="cls_009"><span class="cls_009">many bottle stores/ Binge drinking known as “</span></div>
<div style="position:absolute;left:304.25px;top:578.04px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:578.04px" class="cls_009"><span class="cls_009">Trauma</span></div>
<div style="position:absolute;left:78.03px;top:591.53px" class="cls_009"><span class="cls_009">The Normal”/Drinking and driving / Soften drug</span></div>
<div style="position:absolute;left:304.25px;top:593.29px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:593.29px" class="cls_009"><span class="cls_009">Unaware of services / supports available</span></div>
<div style="position:absolute;left:78.03px;top:602.53px" class="cls_009"><span class="cls_009">charges / penalties /Easy access for youth /</span></div>
<div style="position:absolute;left:304.25px;top:608.54px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:608.54px" class="cls_009"><span class="cls_009">Peer pressure</span></div>
<div style="position:absolute;left:78.03px;top:613.53px" class="cls_009"><span class="cls_009">Synthetic / Huffing</span></div>
<div style="position:absolute;left:304.25px;top:623.79px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:623.79px" class="cls_009"><span class="cls_009">Can’t get work medical from ICAMS</span></div>
<div style="position:absolute;left:68.03px;top:628.78px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:628.78px" class="cls_009"><span class="cls_009">Sold for income / Money / Poor housing has a</span></div>
<div style="position:absolute;left:78.03px;top:639.78px" class="cls_009"><span class="cls_009">impact / Low income</span></div>
<div style="position:absolute;left:304.25px;top:639.04px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:639.04px" class="cls_009"><span class="cls_009">Social media / social networking facebook</span></div>
<div style="position:absolute;left:68.03px;top:655.04px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:655.04px" class="cls_009"><span class="cls_009">Communication break down between all -</span></div>
<div style="position:absolute;left:304.25px;top:654.29px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:654.29px" class="cls_009"><span class="cls_009">Peer (intergenerational) i.e. Gangs & Drugs</span></div>
<div style="position:absolute;left:78.03px;top:666.04px" class="cls_009"><span class="cls_009">Youth / family / organizational support</span></div>
<div style="position:absolute;left:304.25px;top:669.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:669.55px" class="cls_009"><span class="cls_009">Temptation / Music / Sugar</span></div>
<div style="position:absolute;left:68.03px;top:681.29px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:681.29px" class="cls_009"><span class="cls_009">Inter-generational use</span></div>
<div style="position:absolute;left:304.25px;top:684.80px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:684.80px" class="cls_009"><span class="cls_009">Poor role models</span></div>
<div style="position:absolute;left:68.03px;top:696.54px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:696.54px" class="cls_009"><span class="cls_009">Transition from youth to adult services /</span></div>
<div style="position:absolute;left:304.25px;top:700.05px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:700.05px" class="cls_009"><span class="cls_009">How to cope with challenges</span></div>
<div style="position:absolute;left:78.03px;top:707.54px" class="cls_009"><span class="cls_009">poor not there</span></div>
<div style="position:absolute;left:304.25px;top:715.30px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:715.30px" class="cls_009"><span class="cls_009">Focus is on cure rather than prevention</span></div>
<div style="position:absolute;left:114.71px;top:748.60px" class="cls_008"><span class="cls_008">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary</span></div>
<div style="position:absolute;left:95.88px;top:760.60px" class="cls_008"><span class="cls_008">students, young adults, representatives of churches and agencies and community</span></div>
<div style="position:absolute;left:96.21px;top:772.60px" class="cls_008"><span class="cls_008">agencies and schools. Invitations send via email and open invitation via facebook.</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">2</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:4255px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background06.jpg" width=595 height=841></div>
<div style="position:absolute;left:80.03px;top:79.68px" class="cls_004"><span class="cls_004">Recurring Points - Themes:</span></div>
<div style="position:absolute;left:314.25px;top:79.68px" class="cls_004"><span class="cls_004">So What:</span></div>
<div style="position:absolute;left:68.03px;top:94.52px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:94.52px" class="cls_009"><span class="cls_009">Copycat</span></div>
<div style="position:absolute;left:304.25px;top:94.52px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:94.52px" class="cls_009"><span class="cls_009">No funding</span></div>
<div style="position:absolute;left:68.03px;top:109.77px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:109.77px" class="cls_009"><span class="cls_009">No drop in centre for ‘P’ addicts available in</span></div>
<div style="position:absolute;left:304.25px;top:109.77px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:109.77px" class="cls_009"><span class="cls_009">Bad effects</span></div>
<div style="position:absolute;left:78.03px;top:120.77px" class="cls_009"><span class="cls_009">Whanganui</span></div>
<div style="position:absolute;left:304.25px;top:125.02px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:125.02px" class="cls_009"><span class="cls_009">A lot of support? Are Rangatahi accessing it?</span></div>
<div style="position:absolute;left:68.03px;top:136.02px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:136.02px" class="cls_009"><span class="cls_009">Dodgy drugs around</span></div>
<div style="position:absolute;left:314.25px;top:136.02px" class="cls_009"><span class="cls_009">If not, Why?</span></div>
<div style="position:absolute;left:68.03px;top:151.27px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:151.27px" class="cls_009"><span class="cls_009">Cook houses readily happening</span></div>
<div style="position:absolute;left:315.25px;top:160.28px" class="cls_004"><span class="cls_004">What else stands out?</span></div>
<div style="position:absolute;left:68.03px;top:166.53px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:166.53px" class="cls_009"><span class="cls_009">Masking trauma</span></div>
<div style="position:absolute;left:304.25px;top:175.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:175.11px" class="cls_009"><span class="cls_009">Happens in larger cities</span></div>
<div style="position:absolute;left:68.03px;top:181.78px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:181.78px" class="cls_009"><span class="cls_009">•Identity loss</span></div>
<div style="position:absolute;left:304.25px;top:190.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:190.36px" class="cls_009"><span class="cls_009">No easy access to help/services</span></div>
<div style="position:absolute;left:68.03px;top:197.03px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:197.03px" class="cls_009"><span class="cls_009">Intergenerational poverty</span></div>
<div style="position:absolute;left:304.25px;top:205.61px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:205.61px" class="cls_009"><span class="cls_009">Not enough accountability</span></div>
<div style="position:absolute;left:68.03px;top:212.28px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:212.28px" class="cls_009"><span class="cls_009">Inequality</span></div>
<div style="position:absolute;left:304.25px;top:220.87px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:220.87px" class="cls_009"><span class="cls_009">Tag the skate park with</span></div>
<div style="position:absolute;left:314.25px;top:231.87px" class="cls_009"><span class="cls_009">services available</span></div>
<div style="position:absolute;left:79.92px;top:233.12px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:79.92px;top:248.12px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:311.27px;top:252.71px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:311.27px;top:267.71px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:68.03px;top:271.20px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:271.20px" class="cls_009"><span class="cls_009">A lot of support in our community</span></div>
<div style="position:absolute;left:68.03px;top:286.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:286.45px" class="cls_009"><span class="cls_009">Bus, Mobile service</span></div>
<div style="position:absolute;left:304.25px;top:289.49px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:289.49px" class="cls_009"><span class="cls_009">More use of lived experiences from alcoholics &</span></div>
<div style="position:absolute;left:68.03px;top:301.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:301.71px" class="cls_009"><span class="cls_009">More early interventions, Working with schools,</span></div>
<div style="position:absolute;left:314.25px;top:300.49px" class="cls_009"><span class="cls_009">addicts, Key note speakers ECT.</span></div>
<div style="position:absolute;left:68.03px;top:316.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:316.96px" class="cls_009"><span class="cls_009">More staff</span></div>
<div style="position:absolute;left:304.25px;top:315.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:315.75px" class="cls_009"><span class="cls_009">Grass roots orgs, Drop in centres</span></div>
<div style="position:absolute;left:68.03px;top:332.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:332.21px" class="cls_009"><span class="cls_009">Big rec centre</span></div>
<div style="position:absolute;left:304.25px;top:331.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:331.00px" class="cls_009"><span class="cls_009">Meetings/groups for young people with</span></div>
<div style="position:absolute;left:314.25px;top:342.00px" class="cls_009"><span class="cls_009">different agencies/services</span></div>
<div style="position:absolute;left:68.03px;top:347.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:347.46px" class="cls_009"><span class="cls_009">Toilets in schools tagged with help that is</span></div>
<div style="position:absolute;left:78.03px;top:358.46px" class="cls_009"><span class="cls_009">available and skate park</span></div>
<div style="position:absolute;left:304.25px;top:357.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:357.25px" class="cls_009"><span class="cls_009">Support young people with their current needs</span></div>
<div style="position:absolute;left:68.03px;top:373.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:373.71px" class="cls_009"><span class="cls_009">More support in schools by services and</span></div>
<div style="position:absolute;left:304.25px;top:372.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:372.50px" class="cls_009"><span class="cls_009">Social workers to attend DHB alcohol & Drug</span></div>
<div style="position:absolute;left:78.03px;top:384.71px" class="cls_009"><span class="cls_009">advertised to students</span></div>
<div style="position:absolute;left:314.25px;top:383.50px" class="cls_009"><span class="cls_009">programs to learn how AOD clients think and</span></div>
<div style="position:absolute;left:314.25px;top:394.50px" class="cls_009"><span class="cls_009">Why</span></div>
<div style="position:absolute;left:68.03px;top:399.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:399.97px" class="cls_009"><span class="cls_009">Local rehab & easily accusable services</span></div>
<div style="position:absolute;left:304.25px;top:409.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:409.75px" class="cls_009"><span class="cls_009">Whanau ora to approach to break down</span></div>
<div style="position:absolute;left:68.03px;top:415.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:415.22px" class="cls_009"><span class="cls_009">Support groups aimed at young people</span></div>
<div style="position:absolute;left:314.25px;top:420.75px" class="cls_009"><span class="cls_009">cycles/intergenerational stuff</span></div>
<div style="position:absolute;left:78.03px;top:426.22px" class="cls_009"><span class="cls_009">i.e. NA, AA</span></div>
<div style="position:absolute;left:304.25px;top:436.01px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:436.01px" class="cls_009"><span class="cls_009">Ability to access services without getting a</span></div>
<div style="position:absolute;left:68.03px;top:441.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:441.47px" class="cls_009"><span class="cls_009">More awareness, Facts & effects</span></div>
<div style="position:absolute;left:314.25px;top:447.01px" class="cls_009"><span class="cls_009">mental health record</span></div>
<div style="position:absolute;left:125.12px;top:470.09px" class="cls_008"><span class="cls_008">Oct 18 - Feb 2019: Theme Focus Hui including anyone who opted into this</span></div>
<div style="position:absolute;left:236.46px;top:482.09px" class="cls_008"><span class="cls_008">particular discussion group.</span></div>
<div style="position:absolute;left:148.80px;top:505.09px" class="cls_010"><span class="cls_010">“Rangatahi Māori and their whānau are high on life.”</span></div>
<div style="position:absolute;left:271.12px;top:523.55px" class="cls_010"><span class="cls_010">ACTIONS:</span></div>
<div style="position:absolute;left:126.84px;top:541.68px" class="cls_009"><span class="cls_009">1.</span></div>
<div style="position:absolute;left:144.84px;top:541.68px" class="cls_009"><span class="cls_009">Reconvene the AOD Reference</span></div>
<div style="position:absolute;left:296.92px;top:541.68px" class="cls_009"><span class="cls_009">2.</span></div>
<div style="position:absolute;left:314.92px;top:541.68px" class="cls_009"><span class="cls_009">Collaborate on consistent</span></div>
<div style="position:absolute;left:144.84px;top:552.68px" class="cls_009"><span class="cls_009">Group & the AOD Network</span></div>
<div style="position:absolute;left:314.92px;top:552.68px" class="cls_009"><span class="cls_009">messaging for AOD in Whanganui</span></div>
<div style="position:absolute;left:122.82px;top:579.37px" class="cls_008"><span class="cls_008">March - April 2019: Big Picture Statements from the Small Groups collated</span></div>
<div style="position:absolute;left:141.47px;top:606.59px" class="cls_010"><span class="cls_010">“Rangatahi Māori and their whānau are high on life.”</span></div>
<div style="position:absolute;left:263.79px;top:625.05px" class="cls_010"><span class="cls_010">ACTIONS:</span></div>
<div style="position:absolute;left:126.84px;top:643.16px" class="cls_009"><span class="cls_009">3.</span></div>
<div style="position:absolute;left:144.84px;top:643.16px" class="cls_009"><span class="cls_009">Reconvene the AOD Reference</span></div>
<div style="position:absolute;left:296.92px;top:643.16px" class="cls_009"><span class="cls_009">4.   Collaborate on consistent</span></div>
<div style="position:absolute;left:144.84px;top:654.16px" class="cls_009"><span class="cls_009">Group & the AOD Network</span></div>
<div style="position:absolute;left:314.92px;top:654.16px" class="cls_009"><span class="cls_009">messaging for AOD in Whanganui</span></div>
<div style="position:absolute;left:97.59px;top:683.97px" class="cls_008"><span class="cls_008">11/04/19: Large Hui @ Racecourse, 50+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:97.45px;top:695.97px" class="cls_008"><span class="cls_008">young adults, representatives of community agencies, government agencies and</span></div>
<div style="position:absolute;left:132.31px;top:707.97px" class="cls_008"><span class="cls_008">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:68.03px;top:738.31px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:738.31px" class="cls_009"><span class="cls_009">Connecting AOD support services and</span></div>
<div style="position:absolute;left:304.25px;top:738.31px" class="cls_009"><span class="cls_009">• Domestic Violence</span></div>
<div style="position:absolute;left:78.03px;top:749.31px" class="cls_009"><span class="cls_009">programs to positive activities such as waka</span></div>
<div style="position:absolute;left:304.25px;top:753.56px" class="cls_009"><span class="cls_009">• Peer support supervisors/mentors</span></div>
<div style="position:absolute;left:78.03px;top:760.31px" class="cls_009"><span class="cls_009">ama</span></div>
<div style="position:absolute;left:304.25px;top:768.81px" class="cls_009"><span class="cls_009">• What is the purpose of reconvening AOD</span></div>
<div style="position:absolute;left:68.03px;top:775.56px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:775.56px" class="cls_009"><span class="cls_009">Kai</span></div>
<div style="position:absolute;left:314.25px;top:779.81px" class="cls_009"><span class="cls_009">reference group</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">3</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:5106px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background07.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.13px" class="cls_002"><span class="cls_002">Sexual Wellbeing</span></div>
<div style="position:absolute;left:104.87px;top:77.59px" class="cls_007"><span class="cls_007">3.</span></div>
<div style="position:absolute;left:95.85px;top:123.78px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.83px;top:135.78px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.44px;top:147.78px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:79.30px;top:176.52px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:68.03px;top:198.31px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:198.31px" class="cls_009"><span class="cls_009">Free contraception</span></div>
<div style="position:absolute;left:303.83px;top:198.31px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:198.31px" class="cls_009"><span class="cls_009">YST</span></div>
<div style="position:absolute;left:68.03px;top:213.56px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:213.56px" class="cls_009"><span class="cls_009">Increased awareness &acceptance /</span></div>
<div style="position:absolute;left:303.83px;top:213.56px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:213.56px" class="cls_009"><span class="cls_009">Public health nurses</span></div>
<div style="position:absolute;left:78.03px;top:224.56px" class="cls_009"><span class="cls_009">understanding</span></div>
<div style="position:absolute;left:303.83px;top:228.81px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:228.81px" class="cls_009"><span class="cls_009">GPs</span></div>
<div style="position:absolute;left:68.03px;top:239.81px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:239.81px" class="cls_009"><span class="cls_009">Change in culture - international as well</span></div>
<div style="position:absolute;left:303.83px;top:244.07px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:244.07px" class="cls_009"><span class="cls_009">subsidized / FREE GP -Te Oranganui</span></div>
<div style="position:absolute;left:68.03px;top:255.07px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:255.07px" class="cls_009"><span class="cls_009">Clearer boundaries</span></div>
<div style="position:absolute;left:303.83px;top:259.32px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:259.32px" class="cls_009"><span class="cls_009">Great examples of respectful partnership</span></div>
<div style="position:absolute;left:68.03px;top:270.32px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:270.32px" class="cls_009"><span class="cls_009">LGBT QI & legislation</span></div>
<div style="position:absolute;left:303.83px;top:274.57px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:274.57px" class="cls_009"><span class="cls_009">Loves me not</span></div>
<div style="position:absolute;left:68.03px;top:285.57px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:285.57px" class="cls_009"><span class="cls_009">increased opportunities</span></div>
<div style="position:absolute;left:303.83px;top:289.82px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:289.82px" class="cls_009"><span class="cls_009">Whanau Support</span></div>
<div style="position:absolute;left:68.03px;top:300.82px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:300.82px" class="cls_009"><span class="cls_009">Sexual Health clinics</span></div>
<div style="position:absolute;left:303.83px;top:305.07px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:305.07px" class="cls_009"><span class="cls_009">Light youth</span></div>
<div style="position:absolute;left:68.03px;top:316.07px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:316.07px" class="cls_009"><span class="cls_009">Info available easier</span></div>
<div style="position:absolute;left:303.83px;top:320.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:320.33px" class="cls_009"><span class="cls_009">Health & sexuality education</span></div>
<div style="position:absolute;left:68.03px;top:331.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:331.33px" class="cls_009"><span class="cls_009">Family planning</span></div>
<div style="position:absolute;left:303.83px;top:335.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:335.58px" class="cls_009"><span class="cls_009">Whanau inside out / Trusting people</span></div>
<div style="position:absolute;left:78.53px;top:356.42px" class="cls_004"><span class="cls_004">What are the challenges</span></div>
<div style="position:absolute;left:68.03px;top:378.20px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:378.20px" class="cls_009"><span class="cls_009">Youth not using contraception</span></div>
<div style="position:absolute;left:303.83px;top:378.20px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:378.20px" class="cls_009"><span class="cls_009">Lack of support from whanau</span></div>
<div style="position:absolute;left:68.03px;top:393.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:393.46px" class="cls_009"><span class="cls_009">Social media pressure</span></div>
<div style="position:absolute;left:303.83px;top:393.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:393.46px" class="cls_009"><span class="cls_009">No endocrinologist or sexual health counsellor</span></div>
<div style="position:absolute;left:68.03px;top:408.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:408.71px" class="cls_009"><span class="cls_009">Sex is used everywhere</span></div>
<div style="position:absolute;left:303.83px;top:408.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:408.71px" class="cls_009"><span class="cls_009">High cost / Travel / Contraception</span></div>
<div style="position:absolute;left:68.03px;top:423.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:423.96px" class="cls_009"><span class="cls_009">Hyper sexuality - Tv / Music etc.</span></div>
<div style="position:absolute;left:303.83px;top:423.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:423.96px" class="cls_009"><span class="cls_009">Relying on parents</span></div>
<div style="position:absolute;left:68.03px;top:439.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:439.21px" class="cls_009"><span class="cls_009">Stigma</span></div>
<div style="position:absolute;left:303.83px;top:439.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:439.21px" class="cls_009"><span class="cls_009">Age restrictions</span></div>
<div style="position:absolute;left:68.03px;top:454.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:454.46px" class="cls_009"><span class="cls_009">What is normal / where do I fit</span></div>
<div style="position:absolute;left:303.83px;top:454.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:454.46px" class="cls_009"><span class="cls_009">misunderstanding & stigma</span></div>
<div style="position:absolute;left:68.03px;top:469.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:469.72px" class="cls_009"><span class="cls_009">Labelling</span></div>
<div style="position:absolute;left:303.83px;top:469.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:469.72px" class="cls_009"><span class="cls_009">Tikanga / Kawa conflict</span></div>
<div style="position:absolute;left:68.03px;top:484.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:484.97px" class="cls_009"><span class="cls_009">Accessibility to services / specialist support</span></div>
<div style="position:absolute;left:303.83px;top:484.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:484.97px" class="cls_009"><span class="cls_009">Kapa Haka</span></div>
<div style="position:absolute;left:68.03px;top:500.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:500.22px" class="cls_009"><span class="cls_009">Rangatahi beginning intimate relationships</span></div>
<div style="position:absolute;left:303.83px;top:500.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:500.22px" class="cls_009"><span class="cls_009">Gender roles</span></div>
<div style="position:absolute;left:78.03px;top:511.22px" class="cls_009"><span class="cls_009">earlier</span></div>
<div style="position:absolute;left:303.83px;top:515.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:515.47px" class="cls_009"><span class="cls_009">Language that organization’s use /</span></div>
<div style="position:absolute;left:68.03px;top:526.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:526.47px" class="cls_009"><span class="cls_009">Whanau over protective</span></div>
<div style="position:absolute;left:313.83px;top:526.47px" class="cls_009"><span class="cls_009">descriptions</span></div>
<div style="position:absolute;left:68.03px;top:541.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:541.72px" class="cls_009"><span class="cls_009">Pornography everywhere</span></div>
<div style="position:absolute;left:303.83px;top:541.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:541.72px" class="cls_009"><span class="cls_009">Lack of education / understanding</span></div>
<div style="position:absolute;left:68.03px;top:556.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:556.98px" class="cls_009"><span class="cls_009">Anonymity online</span></div>
<div style="position:absolute;left:303.83px;top:556.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:556.98px" class="cls_009"><span class="cls_009">Adult and high achy controllers</span></div>
<div style="position:absolute;left:68.03px;top:572.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:572.23px" class="cls_009"><span class="cls_009">Power imbalances in relationships</span></div>
<div style="position:absolute;left:303.83px;top:572.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:572.23px" class="cls_009"><span class="cls_009">Education at grass roots</span></div>
<div style="position:absolute;left:68.03px;top:587.48px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:587.48px" class="cls_009"><span class="cls_009">Judgements can impact mental health / stops</span></div>
<div style="position:absolute;left:303.83px;top:587.48px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:587.48px" class="cls_009"><span class="cls_009">STI rates increasing</span></div>
<div style="position:absolute;left:78.03px;top:598.48px" class="cls_009"><span class="cls_009">people accessing the care they need</span></div>
<div style="position:absolute;left:303.83px;top:602.73px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:602.73px" class="cls_009"><span class="cls_009">Termination rates rising</span></div>
<div style="position:absolute;left:68.03px;top:613.73px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:613.73px" class="cls_009"><span class="cls_009">Really young parents</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">4</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:5957px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background08.jpg" width=595 height=841></div>
<div style="position:absolute;left:79.92px;top:79.40px" class="cls_004"><span class="cls_004">What are our opportunities?</span></div>
<div style="position:absolute;left:68.03px;top:101.19px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:101.19px" class="cls_009"><span class="cls_009">Resources for parents</span></div>
<div style="position:absolute;left:304.25px;top:101.19px" class="cls_009"><span class="cls_009">• Open home foundation</span></div>
<div style="position:absolute;left:68.03px;top:116.44px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:116.44px" class="cls_009"><span class="cls_009">Teaching respect for your body</span></div>
<div style="position:absolute;left:304.25px;top:116.44px" class="cls_009"><span class="cls_009">•  Leadership / opportunity’s to give back and</span></div>
<div style="position:absolute;left:314.25px;top:127.44px" class="cls_009"><span class="cls_009">share their journey</span></div>
<div style="position:absolute;left:68.03px;top:131.69px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:131.69px" class="cls_009"><span class="cls_009">Rangatahi to have a voice about their</span></div>
<div style="position:absolute;left:78.03px;top:142.69px" class="cls_009"><span class="cls_009">experience’s</span></div>
<div style="position:absolute;left:304.25px;top:142.69px" class="cls_009"><span class="cls_009">• Support for whanau, siblings etc.</span></div>
<div style="position:absolute;left:68.03px;top:157.94px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:157.94px" class="cls_009"><span class="cls_009">Self -Love & acceptance</span></div>
<div style="position:absolute;left:304.25px;top:157.94px" class="cls_009"><span class="cls_009">• Whanau Ora approach</span></div>
<div style="position:absolute;left:68.03px;top:173.19px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:173.19px" class="cls_009"><span class="cls_009">Body positive programs</span></div>
<div style="position:absolute;left:304.25px;top:173.19px" class="cls_009"><span class="cls_009">• More training /education at Grass Roots</span></div>
<div style="position:absolute;left:68.03px;top:188.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:188.45px" class="cls_009"><span class="cls_009">Streamline connections with specialist</span></div>
<div style="position:absolute;left:304.25px;top:188.45px" class="cls_009"><span class="cls_009">•  More resources and supports</span></div>
<div style="position:absolute;left:78.03px;top:199.45px" class="cls_009"><span class="cls_009">services</span></div>
<div style="position:absolute;left:304.25px;top:203.70px" class="cls_009"><span class="cls_009">•  Breaking stigma with older generations</span></div>
<div style="position:absolute;left:68.03px;top:214.70px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:214.70px" class="cls_009"><span class="cls_009">education / raising awareness</span></div>
<div style="position:absolute;left:314.25px;top:214.70px" class="cls_009"><span class="cls_009">re: CGBTGI</span></div>
<div style="position:absolute;left:68.03px;top:229.95px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:229.95px" class="cls_009"><span class="cls_009">Normalizing diversity</span></div>
<div style="position:absolute;left:304.25px;top:229.95px" class="cls_009"><span class="cls_009">• More funding and better aligned need.</span></div>
<div style="position:absolute;left:68.03px;top:245.20px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:245.20px" class="cls_009"><span class="cls_009">Parenting groups</span></div>
<div style="position:absolute;left:304.25px;top:245.20px" class="cls_009"><span class="cls_009">• Promotion and communication</span></div>
<div style="position:absolute;left:68.03px;top:260.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:260.45px" class="cls_009"><span class="cls_009">Individual mentoring</span></div>
<div style="position:absolute;left:108.52px;top:287.40px" class="cls_008"><span class="cls_008">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary</span></div>
<div style="position:absolute;left:89.69px;top:299.40px" class="cls_008"><span class="cls_008">students, young adults, representatives of churches and agencies and community</span></div>
<div style="position:absolute;left:91.22px;top:311.40px" class="cls_008"><span class="cls_008">agencies and schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:79.92px;top:341.35px" class="cls_004"><span class="cls_004">Strengths - Themes</span></div>
<div style="position:absolute;left:315.52px;top:341.35px" class="cls_004"><span class="cls_004">Challenge</span></div>
<div style="position:absolute;left:68.03px;top:363.14px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:363.14px" class="cls_009"><span class="cls_009">Access to contraception & education</span></div>
<div style="position:absolute;left:304.25px;top:363.14px" class="cls_009"><span class="cls_009">• Porn influencing the way Rangatahi see sex</span></div>
<div style="position:absolute;left:68.03px;top:378.39px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:378.39px" class="cls_009"><span class="cls_009">A lot more accepting & inclusive</span></div>
<div style="position:absolute;left:304.25px;top:378.39px" class="cls_009"><span class="cls_009">• Not enough education, Only family planning</span></div>
<div style="position:absolute;left:68.03px;top:393.65px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:393.65px" class="cls_009"><span class="cls_009">Increased opportunities</span></div>
<div style="position:absolute;left:304.25px;top:393.65px" class="cls_009"><span class="cls_009">• Parents different point of views on education</span></div>
<div style="position:absolute;left:68.03px;top:408.90px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:408.90px" class="cls_009"><span class="cls_009">Programs, Love me not</span></div>
<div style="position:absolute;left:304.25px;top:408.90px" class="cls_009"><span class="cls_009">• No specialised support</span></div>
<div style="position:absolute;left:68.03px;top:424.15px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:424.15px" class="cls_009"><span class="cls_009">Rates are down in all areas</span></div>
<div style="position:absolute;left:304.25px;top:424.15px" class="cls_009"><span class="cls_009">• Lack of knowledge among peers</span></div>
<div style="position:absolute;left:68.03px;top:439.40px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:439.40px" class="cls_009"><span class="cls_009">Support groups</span></div>
<div style="position:absolute;left:304.25px;top:439.40px" class="cls_009"><span class="cls_009">• A community mindset</span></div>
<div style="position:absolute;left:304.25px;top:454.65px" class="cls_009"><span class="cls_009">• Tikanaga/Kawa tensions</span></div>
<div style="position:absolute;left:79.92px;top:460.24px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:79.92px;top:473.24px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:315.52px;top:475.49px" class="cls_004"><span class="cls_004">New Mahi:</span></div>
<div style="position:absolute;left:68.03px;top:495.03px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:495.03px" class="cls_009"><span class="cls_009">Friends looking out for each other</span></div>
<div style="position:absolute;left:304.25px;top:497.28px" class="cls_009"><span class="cls_009">• Streamline connections to specialist support</span></div>
<div style="position:absolute;left:68.03px;top:510.28px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:510.28px" class="cls_009"><span class="cls_009">Education, sex & relationships</span></div>
<div style="position:absolute;left:304.25px;top:512.53px" class="cls_009"><span class="cls_009">• Support with Rangatahi that are diverse</span></div>
<div style="position:absolute;left:68.03px;top:525.53px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:525.53px" class="cls_009"><span class="cls_009">Collaboration among ministries & services</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">5</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:6808px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background09.jpg" width=595 height=841></div>
<div style="position:absolute;left:175.38px;top:80.42px" class="cls_008"><span class="cls_008">Oct 18 - Feb 2019: Theme Focus Hui including anyone</span></div>
<div style="position:absolute;left:187.74px;top:91.42px" class="cls_008"><span class="cls_008">who opted into this particular discussion group.</span></div>
<div style="position:absolute;left:116.25px;top:118.10px" class="cls_004"><span class="cls_004">“Rangatahi Māori are supported to experience their sexuality and have</span></div>
<div style="position:absolute;left:162.51px;top:133.10px" class="cls_004"><span class="cls_004">healthy relationships in a positive and safe manner.”</span></div>
<div style="position:absolute;left:68.03px;top:154.89px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:154.89px" class="cls_009"><span class="cls_009">Opportunities in the sexual health theme</span></div>
<div style="position:absolute;left:304.25px;top:154.89px" class="cls_009"><span class="cls_009">•  Opportunities in the diversity theme</span></div>
<div style="position:absolute;left:90.03px;top:170.14px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:104.03px;top:170.14px" class="cls_009"><span class="cls_009">To increase and support programmes</span></div>
<div style="position:absolute;left:326.25px;top:170.14px" class="cls_009"><span class="cls_009">•   Whanau, having more support available</span></div>
<div style="position:absolute;left:104.03px;top:181.14px" class="cls_009"><span class="cls_009">and education to be delivered to our</span></div>
<div style="position:absolute;left:326.25px;top:181.14px" class="cls_009"><span class="cls_009">`</span></div>
<div style="position:absolute;left:340.25px;top:181.14px" class="cls_009"><span class="cls_009">for whanau to support their diverse</span></div>
<div style="position:absolute;left:104.03px;top:192.14px" class="cls_009"><span class="cls_009">youth in and out of school</span></div>
<div style="position:absolute;left:340.25px;top:192.14px" class="cls_009"><span class="cls_009">rangatahi. Awareness raising so that</span></div>
<div style="position:absolute;left:340.25px;top:203.14px" class="cls_009"><span class="cls_009">whanau understand more about how</span></div>
<div style="position:absolute;left:90.03px;top:207.39px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:104.03px;top:207.39px" class="cls_009"><span class="cls_009">To upskill parents to feel confident to talk</span></div>
<div style="position:absolute;left:340.25px;top:214.14px" class="cls_009"><span class="cls_009">best to support their rangatahi.</span></div>
<div style="position:absolute;left:104.03px;top:218.39px" class="cls_009"><span class="cls_009">about sexual wellness with their youth</span></div>
<div style="position:absolute;left:104.03px;top:229.39px" class="cls_009"><span class="cls_009">(Family Start)</span></div>
<div style="position:absolute;left:326.25px;top:229.39px" class="cls_009"><span class="cls_009">•   Promoting around where to access local</span></div>
<div style="position:absolute;left:340.25px;top:240.39px" class="cls_009"><span class="cls_009">and national support</span></div>
<div style="position:absolute;left:90.03px;top:244.64px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:104.03px;top:244.64px" class="cls_009"><span class="cls_009">To increase rangatahi knowledge and</span></div>
<div style="position:absolute;left:104.03px;top:255.64px" class="cls_009"><span class="cls_009">skills around consent and preventing</span></div>
<div style="position:absolute;left:326.25px;top:255.64px" class="cls_009"><span class="cls_009">•   Having local role models</span></div>
<div style="position:absolute;left:104.03px;top:266.64px" class="cls_009"><span class="cls_009">sexual violence</span></div>
<div style="position:absolute;left:326.25px;top:270.89px" class="cls_009"><span class="cls_009">•   Workforce development: investing in</span></div>
<div style="position:absolute;left:90.03px;top:281.89px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:104.03px;top:281.89px" class="cls_009"><span class="cls_009">Workforce development: investing in</span></div>
<div style="position:absolute;left:340.25px;top:281.89px" class="cls_009"><span class="cls_009">upskilling front of house staff i.e.</span></div>
<div style="position:absolute;left:104.03px;top:292.89px" class="cls_009"><span class="cls_009">upskilling front of house staff i.e.</span></div>
<div style="position:absolute;left:340.25px;top:292.89px" class="cls_009"><span class="cls_009">receptionists as they are the first person</span></div>
<div style="position:absolute;left:104.03px;top:303.89px" class="cls_009"><span class="cls_009">receptionists as they are the first person</span></div>
<div style="position:absolute;left:340.25px;top:303.89px" class="cls_009"><span class="cls_009">rangatahi interact with when attempting</span></div>
<div style="position:absolute;left:104.03px;top:314.89px" class="cls_009"><span class="cls_009">rangatahi interact with when</span></div>
<div style="position:absolute;left:340.25px;top:314.89px" class="cls_009"><span class="cls_009">to access services.</span></div>
<div style="position:absolute;left:104.03px;top:325.89px" class="cls_009"><span class="cls_009">attempting to access services.</span></div>
<div style="position:absolute;left:326.25px;top:330.15px" class="cls_009"><span class="cls_009">•  Holding a hui to hear youth voice on</span></div>
<div style="position:absolute;left:90.03px;top:341.15px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:104.03px;top:341.15px" class="cls_009"><span class="cls_009">Holding a youth hui to hear youth voice</span></div>
<div style="position:absolute;left:340.25px;top:341.15px" class="cls_009"><span class="cls_009">this topic.</span></div>
<div style="position:absolute;left:104.03px;top:352.15px" class="cls_009"><span class="cls_009">on this topic</span></div>
<div style="position:absolute;left:118.28px;top:376.80px" class="cls_008"><span class="cls_008">March - April 2019: Big Picture Statements from the Small Groups collated</span></div>
<div style="position:absolute;left:118.28px;top:404.77px" class="cls_009"><span class="cls_009">At the time of the hui we didn’t have the above notes from the small group, so we</span></div>
<div style="position:absolute;left:118.28px;top:415.77px" class="cls_009"><span class="cls_009">wrote a statement that we hoped would suffice: Rangatahi Maori are safe in their</span></div>
<div style="position:absolute;left:118.28px;top:426.77px" class="cls_009"><span class="cls_009">sexuality, have healthy relationships and understand safe sex.</span></div>
<div style="position:absolute;left:118.28px;top:442.03px" class="cls_009"><span class="cls_009">However, now we have the small groups notes, this is irrelevant.</span></div>
<div style="position:absolute;left:122.04px;top:466.71px" class="cls_008"><span class="cls_008">11/04/19: Large Hui @ Racecourse, 50+ people including parents, tertiary</span></div>
<div style="position:absolute;left:141.20px;top:478.71px" class="cls_008"><span class="cls_008">students, young adults, representatives of community agencies,</span></div>
<div style="position:absolute;left:122.90px;top:490.71px" class="cls_008"><span class="cls_008">government agencies and schools. Invitations send via email and open</span></div>
<div style="position:absolute;left:245.42px;top:502.71px" class="cls_008"><span class="cls_008">invitation via facebook</span></div>
<div style="position:absolute;left:118.28px;top:529.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:136.28px;top:529.58px" class="cls_009"><span class="cls_009">Check our Family Start - Family Planning korero (ref Nicole for more detail)</span></div>
<div style="position:absolute;left:118.28px;top:544.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:136.28px;top:544.83px" class="cls_009"><span class="cls_009">Contraception</span></div>
<div style="position:absolute;left:118.28px;top:560.09px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:136.28px;top:560.09px" class="cls_009"><span class="cls_009">Choice pregnancy</span></div>
<div style="position:absolute;left:118.28px;top:575.34px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:136.28px;top:575.34px" class="cls_009"><span class="cls_009">Love</span></div>
<div style="position:absolute;left:118.28px;top:590.59px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:136.28px;top:590.59px" class="cls_009"><span class="cls_009">Understanding what is consent</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">6</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:7659px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background10.jpg" width=595 height=841></div>
<div style="position:absolute;left:102.87px;top:77.59px" class="cls_007"><span class="cls_007">4. </span><span class="cls_002">   Learning Environments</span></div>
<div style="position:absolute;left:95.85px;top:123.78px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.83px;top:135.78px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.44px;top:147.78px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:78.73px;top:172.76px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:68.03px;top:194.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:194.55px" class="cls_009"><span class="cls_009">Collab amongst orgs / tight knit /</span></div>
<div style="position:absolute;left:303.83px;top:194.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:194.55px" class="cls_009"><span class="cls_009">Programs for parents / info marketing</span></div>
<div style="position:absolute;left:78.03px;top:205.55px" class="cls_009"><span class="cls_009">connections</span></div>
<div style="position:absolute;left:303.83px;top:209.80px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:209.80px" class="cls_009"><span class="cls_009">Variety</span></div>
<div style="position:absolute;left:68.03px;top:220.80px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:80.43px;top:220.80px" class="cls_009"><span class="cls_009">Kura / kohanga / wananga</span></div>
<div style="position:absolute;left:303.83px;top:225.05px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:225.05px" class="cls_009"><span class="cls_009">Compassion and Passionate community</span></div>
<div style="position:absolute;left:68.03px;top:236.05px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:236.05px" class="cls_009"><span class="cls_009">Whenua / Awa / Natural environment</span></div>
<div style="position:absolute;left:303.83px;top:240.30px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:240.30px" class="cls_009"><span class="cls_009">Youth groups / YMCA / smile city</span></div>
<div style="position:absolute;left:68.03px;top:251.30px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:251.30px" class="cls_009"><span class="cls_009">Intergenerational</span></div>
<div style="position:absolute;left:303.83px;top:255.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:255.55px" class="cls_009"><span class="cls_009">Different learning spaces</span></div>
<div style="position:absolute;left:78.73px;top:276.39px" class="cls_004"><span class="cls_004">What are the challenges</span></div>
<div style="position:absolute;left:68.03px;top:298.18px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:298.18px" class="cls_009"><span class="cls_009">Parents and Adult involvement</span></div>
<div style="position:absolute;left:303.83px;top:298.18px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:298.18px" class="cls_009"><span class="cls_009">Mentors and money</span></div>
<div style="position:absolute;left:68.03px;top:313.43px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:313.43px" class="cls_009"><span class="cls_009">Exam and stress</span></div>
<div style="position:absolute;left:303.83px;top:313.43px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:313.43px" class="cls_009"><span class="cls_009">Transport to places</span></div>
<div style="position:absolute;left:68.03px;top:328.68px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:328.68px" class="cls_009"><span class="cls_009">Fixed learning system</span></div>
<div style="position:absolute;left:303.83px;top:328.68px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:328.68px" class="cls_009"><span class="cls_009">Access problem</span></div>
<div style="position:absolute;left:68.03px;top:343.94px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:343.94px" class="cls_009"><span class="cls_009">More exemptions</span></div>
<div style="position:absolute;left:303.83px;top:343.94px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:343.94px" class="cls_009"><span class="cls_009">Parents influence and attitude</span></div>
<div style="position:absolute;left:68.03px;top:359.19px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:359.19px" class="cls_009"><span class="cls_009">Priorities</span></div>
<div style="position:absolute;left:303.83px;top:359.19px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:359.19px" class="cls_009"><span class="cls_009">Spaces available</span></div>
<div style="position:absolute;left:68.03px;top:374.44px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:374.44px" class="cls_009"><span class="cls_009">Equipment / no food / Resources</span></div>
<div style="position:absolute;left:303.83px;top:374.44px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:374.44px" class="cls_009"><span class="cls_009">Bringing gang involved whanau</span></div>
<div style="position:absolute;left:313.83px;top:385.44px" class="cls_009"><span class="cls_009">to the table</span></div>
<div style="position:absolute;left:68.03px;top:389.69px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:389.69px" class="cls_009"><span class="cls_009">Attitude at home</span></div>
<div style="position:absolute;left:303.83px;top:400.69px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:400.69px" class="cls_009"><span class="cls_009">Sexual help</span></div>
<div style="position:absolute;left:68.03px;top:404.94px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:404.94px" class="cls_009"><span class="cls_009">Change mind sets</span></div>
<div style="position:absolute;left:303.83px;top:415.94px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:415.94px" class="cls_009"><span class="cls_009">Lack of info</span></div>
<div style="position:absolute;left:68.03px;top:420.20px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:420.20px" class="cls_009"><span class="cls_009">Attendance at kura / Pakeha number</span></div>
<div style="position:absolute;left:78.03px;top:431.20px" class="cls_009"><span class="cls_009">dropping in kura Maori</span></div>
<div style="position:absolute;left:303.83px;top:431.20px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:431.20px" class="cls_009"><span class="cls_009">No consistency with programs long term</span></div>
<div style="position:absolute;left:68.03px;top:446.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:446.45px" class="cls_009"><span class="cls_009">Different up bringing</span></div>
<div style="position:absolute;left:303.83px;top:446.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:446.45px" class="cls_009"><span class="cls_009">Educators unaware of how to handle</span></div>
<div style="position:absolute;left:313.83px;top:457.45px" class="cls_009"><span class="cls_009">difficult behavior’s / need more training</span></div>
<div style="position:absolute;left:68.03px;top:461.70px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:461.70px" class="cls_009"><span class="cls_009">Curriculum Localized / Relevant</span></div>
<div style="position:absolute;left:78.73px;top:482.54px" class="cls_004"><span class="cls_004">What are the opportunites</span></div>
<div style="position:absolute;left:68.03px;top:504.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:504.33px" class="cls_009"><span class="cls_009">School bus</span></div>
<div style="position:absolute;left:303.83px;top:504.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:504.33px" class="cls_009"><span class="cls_009">Share resources</span></div>
<div style="position:absolute;left:68.03px;top:519.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:519.58px" class="cls_009"><span class="cls_009">Group funding</span></div>
<div style="position:absolute;left:303.83px;top:519.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:519.58px" class="cls_009"><span class="cls_009">Rangatahi led mentors</span></div>
<div style="position:absolute;left:68.03px;top:534.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:534.83px" class="cls_009"><span class="cls_009">Alternative educations</span></div>
<div style="position:absolute;left:303.83px;top:534.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:534.83px" class="cls_009"><span class="cls_009">Connections</span></div>
<div style="position:absolute;left:68.03px;top:550.08px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:550.08px" class="cls_009"><span class="cls_009">Maori youth mentor</span></div>
<div style="position:absolute;left:303.83px;top:550.08px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:550.08px" class="cls_009"><span class="cls_009">Matipo St / space available</span></div>
<div style="position:absolute;left:68.03px;top:565.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:565.33px" class="cls_009"><span class="cls_009">Teaching Learning styles and</span></div>
<div style="position:absolute;left:303.83px;top:565.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:565.33px" class="cls_009"><span class="cls_009">“talking matters” program</span></div>
<div style="position:absolute;left:78.03px;top:576.33px" class="cls_009"><span class="cls_009">personalities</span></div>
<div style="position:absolute;left:303.83px;top:580.59px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:580.59px" class="cls_009"><span class="cls_009">Brain waves trust</span></div>
<div style="position:absolute;left:68.03px;top:591.59px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:591.59px" class="cls_009"><span class="cls_009">Careers</span></div>
<div style="position:absolute;left:303.83px;top:595.84px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:595.84px" class="cls_009"><span class="cls_009">Liggens institute / Uni AKLD</span></div>
<div style="position:absolute;left:68.03px;top:606.84px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:606.84px" class="cls_009"><span class="cls_009">Look at style of development</span></div>
<div style="position:absolute;left:303.83px;top:611.09px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:611.09px" class="cls_009"><span class="cls_009">Mindset of parent’s caregivers become</span></div>
<div style="position:absolute;left:68.03px;top:622.09px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:622.09px" class="cls_009"><span class="cls_009">GAP programs for GAP kids</span></div>
<div style="position:absolute;left:313.83px;top:622.09px" class="cls_009"><span class="cls_009">aware of family harm effect does to</span></div>
<div style="position:absolute;left:313.83px;top:633.09px" class="cls_009"><span class="cls_009">children’s brains</span></div>
<div style="position:absolute;left:68.03px;top:637.34px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:637.34px" class="cls_009"><span class="cls_009">Whanau community</span></div>
<div style="position:absolute;left:303.83px;top:648.34px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:648.34px" class="cls_009"><span class="cls_009">Maori and Pasifika Trade training</span></div>
<div style="position:absolute;left:68.03px;top:652.59px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:652.59px" class="cls_009"><span class="cls_009">inspirational talks / youth focused</span></div>
<div style="position:absolute;left:303.83px;top:663.59px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:663.59px" class="cls_009"><span class="cls_009">Youth workers in colleges compulsory</span></div>
<div style="position:absolute;left:68.03px;top:667.85px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:667.85px" class="cls_009"><span class="cls_009">WLC</span></div>
<div style="position:absolute;left:303.83px;top:678.85px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:678.85px" class="cls_009"><span class="cls_009">More marae based opportunity’s</span></div>
<div style="position:absolute;left:68.03px;top:683.10px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:683.10px" class="cls_009"><span class="cls_009">Look at individual Vs Group program</span></div>
<div style="position:absolute;left:303.83px;top:694.10px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:694.10px" class="cls_009"><span class="cls_009">Mentor programs re Youth Justice</span></div>
<div style="position:absolute;left:68.03px;top:698.35px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:698.35px" class="cls_009"><span class="cls_009">Rangatahi Led programs = Leaders</span></div>
<div style="position:absolute;left:303.83px;top:709.35px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:709.35px" class="cls_009"><span class="cls_009">Connecting youth work or Alt options</span></div>
<div style="position:absolute;left:68.03px;top:713.60px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:713.60px" class="cls_009"><span class="cls_009">Iwi provide / marae based / growth</span></div>
<div style="position:absolute;left:303.83px;top:724.60px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:724.60px" class="cls_009"><span class="cls_009">Teenage programs to become leaders</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">7</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:8510px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background11.jpg" width=595 height=841></div>
<div style="position:absolute;left:83.53px;top:84.96px" class="cls_008"><span class="cls_008">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:88.99px;top:96.96px" class="cls_008"><span class="cls_008">young adults, representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:115.04px;top:108.96px" class="cls_008"><span class="cls_008">and schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:77.35px;top:134.85px" class="cls_004"><span class="cls_004">Strengths - Themes</span></div>
<div style="position:absolute;left:314.52px;top:134.85px" class="cls_004"><span class="cls_004">Challenge</span></div>
<div style="position:absolute;left:68.03px;top:157.61px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:157.61px" class="cls_009"><span class="cls_009">Maori education</span></div>
<div style="position:absolute;left:304.25px;top:156.64px" class="cls_009"><span class="cls_009">• Fixed learning styles</span></div>
<div style="position:absolute;left:68.03px;top:172.86px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:172.86px" class="cls_009"><span class="cls_009">Variety, Options, Trainings, Different areas/</span></div>
<div style="position:absolute;left:304.25px;top:171.89px" class="cls_009"><span class="cls_009">• Poverty</span></div>
<div style="position:absolute;left:78.03px;top:183.86px" class="cls_009"><span class="cls_009">Levels</span></div>
<div style="position:absolute;left:304.25px;top:187.14px" class="cls_009"><span class="cls_009">• Inaccessibility</span></div>
<div style="position:absolute;left:68.03px;top:199.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:199.11px" class="cls_009"><span class="cls_009">Passionate community</span></div>
<div style="position:absolute;left:304.25px;top:202.40px" class="cls_009"><span class="cls_009">• Attitudes, Changing mind sets</span></div>
<div style="position:absolute;left:68.03px;top:214.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:214.36px" class="cls_009"><span class="cls_009">Whenua, Awa, Maunga, Climate</span></div>
<div style="position:absolute;left:304.25px;top:217.65px" class="cls_009"><span class="cls_009">• Engagement</span></div>
<div style="position:absolute;left:68.03px;top:229.62px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:229.62px" class="cls_009"><span class="cls_009">Easily accessible</span></div>
<div style="position:absolute;left:304.25px;top:232.90px" class="cls_009"><span class="cls_009">• Needs not being meet, Restriction in law</span></div>
<div style="position:absolute;left:304.25px;top:248.15px" class="cls_009"><span class="cls_009">• Individual tailored education plan, Streamline it</span></div>
<div style="position:absolute;left:77.35px;top:250.45px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:304.25px;top:263.40px" class="cls_009"><span class="cls_009">• Govt expectations, NCEA</span></div>
<div style="position:absolute;left:77.35px;top:265.45px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:304.25px;top:278.66px" class="cls_009"><span class="cls_009">• Lack of influences, Role models</span></div>
<div style="position:absolute;left:68.03px;top:288.74px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:288.74px" class="cls_009"><span class="cls_009">Tailored individual leaning</span></div>
<div style="position:absolute;left:68.03px;top:303.99px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:303.99px" class="cls_009"><span class="cls_009">Pathways, Disabilities</span></div>
<div style="position:absolute;left:68.03px;top:319.24px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:319.24px" class="cls_009"><span class="cls_009">Rangatira, Maori</span></div>
<div style="position:absolute;left:68.03px;top:334.49px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:334.49px" class="cls_009"><span class="cls_009">Redefine learning</span></div>
<div style="position:absolute;left:68.03px;top:349.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:349.75px" class="cls_009"><span class="cls_009">Youth role modelling in schools</span></div>
<div style="position:absolute;left:68.03px;top:365.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:365.00px" class="cls_009"><span class="cls_009">Kawarau Models</span></div>
<div style="position:absolute;left:68.03px;top:380.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:380.25px" class="cls_009"><span class="cls_009">Mobil educators</span></div>
<div style="position:absolute;left:68.03px;top:395.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:395.50px" class="cls_009"><span class="cls_009">Training orgs for rural youth</span></div>
<div style="position:absolute;left:115.21px;top:416.31px" class="cls_008"><span class="cls_008">Oct 18 - Feb 2019: Theme Focus Hui including anyone who opted into this</span></div>
<div style="position:absolute;left:226.56px;top:428.31px" class="cls_008"><span class="cls_008">particular discussion group.</span></div>
<div style="position:absolute;left:125.15px;top:454.62px" class="cls_009"><span class="cls_009">No hui were held for this topic. We looked at the MoE WIN1000 notes, but that</span></div>
<div style="position:absolute;left:225.33px;top:465.62px" class="cls_009"><span class="cls_009">strategy targets a specific age.</span></div>
<div style="position:absolute;left:112.34px;top:492.91px" class="cls_008"><span class="cls_008">March - April 2019: Big Picture Statements from the Small Groups collated</span></div>
<div style="position:absolute;left:123.47px;top:524.75px" class="cls_009"><span class="cls_009">We wrote this statement, hoping someone/s with interest in this would pick it</span></div>
<div style="position:absolute;left:247.08px;top:535.75px" class="cls_009"><span class="cls_009">up and make it more.</span></div>
<div style="position:absolute;left:79.87px;top:563.18px" class="cls_010"><span class="cls_010">“Rangatahi Māori are supported within their learning environments to explore</span></div>
<div style="position:absolute;left:247.18px;top:576.18px" class="cls_010"><span class="cls_010">their Māoritanga”</span></div>
<div style="position:absolute;left:92.32px;top:606.23px" class="cls_008"><span class="cls_008">11/04/19: Large Hui @ Racecourse, 50+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:92.17px;top:618.23px" class="cls_008"><span class="cls_008">young adults, representatives of community agencies, government agencies and</span></div>
<div style="position:absolute;left:127.03px;top:630.23px" class="cls_008"><span class="cls_008">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:133.36px;top:657.16px" class="cls_009"><span class="cls_009">• Thinking of new spaces that teaches our rangatahi away from schools</span></div>
<div style="position:absolute;left:169.36px;top:672.41px" class="cls_009"><span class="cls_009">-  Hands on, practical, engaging, life skills</span></div>
<div style="position:absolute;left:133.36px;top:687.67px" class="cls_009"><span class="cls_009">• Whanau education plans</span></div>
<div style="position:absolute;left:133.36px;top:702.92px" class="cls_009"><span class="cls_009">• Whanau ora - whanau development</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">8</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:9361px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background12.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.13px" class="cls_002"><span class="cls_002">Kaupapa Whanau</span></div>
<div style="position:absolute;left:102.87px;top:77.59px" class="cls_007"><span class="cls_007">5.</span></div>
<div style="position:absolute;left:95.64px;top:124.97px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.62px;top:136.97px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.23px;top:148.97px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:79.23px;top:174.67px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:68.03px;top:196.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:196.45px" class="cls_009"><span class="cls_009">Social services agency’s</span></div>
<div style="position:absolute;left:303.83px;top:196.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:196.45px" class="cls_009"><span class="cls_009">Ownership</span></div>
<div style="position:absolute;left:68.03px;top:211.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:211.71px" class="cls_009"><span class="cls_009">Te Ora Hou / Programs / volunteers /</span></div>
<div style="position:absolute;left:303.83px;top:211.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:211.71px" class="cls_009"><span class="cls_009">Natural environment / Awa / Culture</span></div>
<div style="position:absolute;left:78.03px;top:222.71px" class="cls_009"><span class="cls_009">community soup /youth groups</span></div>
<div style="position:absolute;left:303.83px;top:226.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:316.23px;top:226.96px" class="cls_009"><span class="cls_009">Intergenerational wisdom</span></div>
<div style="position:absolute;left:68.03px;top:237.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:237.96px" class="cls_009"><span class="cls_009">Te Oranganui / Whanau Ora / education</span></div>
<div style="position:absolute;left:303.83px;top:242.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:242.21px" class="cls_009"><span class="cls_009">knowledge</span></div>
<div style="position:absolute;left:78.03px;top:248.96px" class="cls_009"><span class="cls_009">navigators / Doctors / family start / AOD</span></div>
<div style="position:absolute;left:78.03px;top:259.96px" class="cls_009"><span class="cls_009">support / Mental</span></div>
<div style="position:absolute;left:303.83px;top:257.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:257.46px" class="cls_009"><span class="cls_009">Te Ora Hou sports teams / BBall/ waka Ama /</span></div>
<div style="position:absolute;left:313.83px;top:268.46px" class="cls_009"><span class="cls_009">Church groups / Stone Soup Peer groups</span></div>
<div style="position:absolute;left:68.03px;top:275.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:275.21px" class="cls_009"><span class="cls_009">health / mentoring</span></div>
<div style="position:absolute;left:303.83px;top:283.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:283.71px" class="cls_009"><span class="cls_009">Whanau / Marae</span></div>
<div style="position:absolute;left:68.03px;top:290.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:290.46px" class="cls_009"><span class="cls_009">Raukotahi summit</span></div>
<div style="position:absolute;left:303.83px;top:298.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:298.97px" class="cls_009"><span class="cls_009">MusicPrograms for parents / info marketing</span></div>
<div style="position:absolute;left:68.03px;top:305.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:305.71px" class="cls_009"><span class="cls_009">Youth services / Support mentoring / goal</span></div>
<div style="position:absolute;left:78.03px;top:316.71px" class="cls_009"><span class="cls_009">setting / financial assistance / budgeting /</span></div>
<div style="position:absolute;left:303.83px;top:314.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:314.22px" class="cls_009"><span class="cls_009">Variety</span></div>
<div style="position:absolute;left:78.03px;top:327.71px" class="cls_009"><span class="cls_009">parenting</span></div>
<div style="position:absolute;left:303.83px;top:329.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:329.47px" class="cls_009"><span class="cls_009">Compassion and Passionate community</span></div>
<div style="position:absolute;left:68.03px;top:342.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:342.97px" class="cls_009"><span class="cls_009">advice/ connecting youth in education and</span></div>
<div style="position:absolute;left:303.83px;top:344.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:344.72px" class="cls_009"><span class="cls_009">Youth groups / YMCA / smile city</span></div>
<div style="position:absolute;left:78.03px;top:353.97px" class="cls_009"><span class="cls_009">training /community organization’s</span></div>
<div style="position:absolute;left:303.83px;top:359.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:359.97px" class="cls_009"><span class="cls_009">Different learning spaces</span></div>
<div style="position:absolute;left:68.03px;top:369.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:369.22px" class="cls_009"><span class="cls_009">Nga Tai O Te Awa</span></div>
<div style="position:absolute;left:79.23px;top:390.06px" class="cls_004"><span class="cls_004">What are the challenges</span></div>
<div style="position:absolute;left:68.03px;top:411.85px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:411.85px" class="cls_009"><span class="cls_009">Ability to connect with Rangatahi / accessibility</span></div>
<div style="position:absolute;left:303.83px;top:411.85px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:411.85px" class="cls_009"><span class="cls_009">Engaging youth into school / transport / school</span></div>
<div style="position:absolute;left:313.83px;top:422.85px" class="cls_009"><span class="cls_009">uniforms / kai</span></div>
<div style="position:absolute;left:68.03px;top:427.10px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:427.10px" class="cls_009"><span class="cls_009">Don’t know how to fit in</span></div>
<div style="position:absolute;left:303.83px;top:438.10px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:438.10px" class="cls_009"><span class="cls_009">Engagement with sports</span></div>
<div style="position:absolute;left:68.03px;top:442.35px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:442.35px" class="cls_009"><span class="cls_009">AOD</span></div>
<div style="position:absolute;left:303.83px;top:453.35px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:316.23px;top:453.35px" class="cls_009"><span class="cls_009">Lack of knowledge</span></div>
<div style="position:absolute;left:68.03px;top:457.60px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:457.60px" class="cls_009"><span class="cls_009">Lack of connection</span></div>
<div style="position:absolute;left:303.83px;top:468.60px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:468.60px" class="cls_009"><span class="cls_009">Whakama - Disconnected</span></div>
<div style="position:absolute;left:68.03px;top:472.85px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:472.85px" class="cls_009"><span class="cls_009">Transport</span></div>
<div style="position:absolute;left:303.83px;top:483.85px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:483.85px" class="cls_009"><span class="cls_009">Lack of self-esteem / confidence</span></div>
<div style="position:absolute;left:68.03px;top:488.10px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:488.10px" class="cls_009"><span class="cls_009">Courage to go</span></div>
<div style="position:absolute;left:303.83px;top:499.10px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:499.10px" class="cls_009"><span class="cls_009">Unhealthy peer groups</span></div>
<div style="position:absolute;left:68.03px;top:503.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:503.36px" class="cls_009"><span class="cls_009">finding support / not knowing</span></div>
<div style="position:absolute;left:303.83px;top:514.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:514.36px" class="cls_009"><span class="cls_009">Respect for elders / Tikanga break downs</span></div>
<div style="position:absolute;left:68.03px;top:518.61px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:518.61px" class="cls_009"><span class="cls_009">Acceptance</span></div>
<div style="position:absolute;left:303.83px;top:529.61px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:316.23px;top:529.61px" class="cls_009"><span class="cls_009">Funding</span></div>
<div style="position:absolute;left:68.03px;top:533.86px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:533.86px" class="cls_009"><span class="cls_009">under peer pressure to go</span></div>
<div style="position:absolute;left:303.83px;top:544.86px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:544.86px" class="cls_009"><span class="cls_009">Unhealthy / Diet</span></div>
<div style="position:absolute;left:68.03px;top:549.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:549.11px" class="cls_009"><span class="cls_009">worried about cost</span></div>
<div style="position:absolute;left:303.83px;top:560.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:560.11px" class="cls_009"><span class="cls_009">Bullying</span></div>
<div style="position:absolute;left:68.03px;top:564.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:564.36px" class="cls_009"><span class="cls_009">stigma / gang</span></div>
<div style="position:absolute;left:303.83px;top:575.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:575.36px" class="cls_009"><span class="cls_009">Segregation</span></div>
<div style="position:absolute;left:68.03px;top:579.62px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:579.62px" class="cls_009"><span class="cls_009">“Just another agency”</span></div>
<div style="position:absolute;left:303.83px;top:590.62px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:590.62px" class="cls_009"><span class="cls_009">Lack of connection to Marae</span></div>
<div style="position:absolute;left:68.03px;top:594.87px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:594.87px" class="cls_009"><span class="cls_009">No faith</span></div>
<div style="position:absolute;left:79.23px;top:615.71px" class="cls_004"><span class="cls_004">What are the opportunities</span></div>
<div style="position:absolute;left:68.03px;top:637.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:637.50px" class="cls_009"><span class="cls_009">Key people to connect with</span></div>
<div style="position:absolute;left:303.83px;top:637.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:637.50px" class="cls_009"><span class="cls_009">Tika Pono / Aroha</span></div>
<div style="position:absolute;left:68.03px;top:652.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:652.75px" class="cls_009"><span class="cls_009">Kawa /Tikanga influences</span></div>
<div style="position:absolute;left:303.83px;top:652.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:652.75px" class="cls_009"><span class="cls_009">Goal setting / opportunity’s</span></div>
<div style="position:absolute;left:68.03px;top:668.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:668.00px" class="cls_009"><span class="cls_009">growing our young people’s identity</span></div>
<div style="position:absolute;left:303.83px;top:668.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:668.00px" class="cls_009"><span class="cls_009">Giving them a voice</span></div>
<div style="position:absolute;left:68.03px;top:683.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:683.25px" class="cls_009"><span class="cls_009">Open availability to young people not Mon-Fri</span></div>
<div style="position:absolute;left:303.83px;top:683.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:683.25px" class="cls_009"><span class="cls_009">Developed opportunities / youth hub, all</span></div>
<div style="position:absolute;left:313.83px;top:694.25px" class="cls_009"><span class="cls_009">suburbs</span></div>
<div style="position:absolute;left:68.03px;top:698.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:698.50px" class="cls_009"><span class="cls_009">Building including parents / whanau</span></div>
<div style="position:absolute;left:303.83px;top:709.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:709.50px" class="cls_009"><span class="cls_009">Tournaments</span></div>
<div style="position:absolute;left:68.03px;top:713.76px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:713.76px" class="cls_009"><span class="cls_009">Change our lens of how we see young people</span></div>
<div style="position:absolute;left:303.83px;top:724.76px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:724.76px" class="cls_009"><span class="cls_009">inclusion for all</span></div>
<div style="position:absolute;left:68.03px;top:729.01px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:729.01px" class="cls_009"><span class="cls_009">Connection relationships services</span></div>
<div style="position:absolute;left:303.83px;top:740.01px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:740.01px" class="cls_009"><span class="cls_009">Changing the culture</span></div>
<div style="position:absolute;left:68.03px;top:744.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:744.26px" class="cls_009"><span class="cls_009">Persistence</span></div>
<div style="position:absolute;left:303.83px;top:755.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.83px;top:755.26px" class="cls_009"><span class="cls_009">Whanau connecting with youth’s activities /</span></div>
<div style="position:absolute;left:68.03px;top:759.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:80.43px;top:759.51px" class="cls_009"><span class="cls_009">Walking beside them</span></div>
<div style="position:absolute;left:313.83px;top:766.26px" class="cls_009"><span class="cls_009">invest time</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">9</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:10212px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background13.jpg" width=595 height=841></div>
<div style="position:absolute;left:89.80px;top:85.68px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:89.66px;top:97.68px" class="cls_008"><span class="cls_008">young adults, representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:118.39px;top:109.68px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:77.35px;top:132.79px" class="cls_004"><span class="cls_004">Strengths - Themes</span></div>
<div style="position:absolute;left:314.52px;top:132.79px" class="cls_004"><span class="cls_004">Challenges</span></div>
<div style="position:absolute;left:304.56px;top:150.43px" class="cls_009"><span class="cls_009">• Intergenerational trauma , Stigma</span></div>
<div style="position:absolute;left:68.03px;top:154.57px" class="cls_009"><span class="cls_009">• Services, Ngo’s & Govt agencies</span></div>
<div style="position:absolute;left:304.56px;top:165.68px" class="cls_009"><span class="cls_009">• Connectedness, Engagement</span></div>
<div style="position:absolute;left:68.03px;top:169.83px" class="cls_009"><span class="cls_009">• Sports & recreation</span></div>
<div style="position:absolute;left:68.03px;top:185.08px" class="cls_009"><span class="cls_009">• Kapa haka</span></div>
<div style="position:absolute;left:68.03px;top:200.33px" class="cls_009"><span class="cls_009">•  Cultural</span></div>
<div style="position:absolute;left:68.03px;top:215.58px" class="cls_009"><span class="cls_009">• Intergenerational wisdom,</span></div>
<div style="position:absolute;left:78.03px;top:226.58px" class="cls_009"><span class="cls_009">Cultural connectivity</span></div>
<div style="position:absolute;left:68.03px;top:247.42px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:68.03px;top:260.42px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:68.03px;top:282.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:282.21px" class="cls_009"><span class="cls_009">Fun, Positive intentions</span></div>
<div style="position:absolute;left:304.56px;top:282.21px" class="cls_009"><span class="cls_009">• Whanau mentoring programs</span></div>
<div style="position:absolute;left:68.03px;top:297.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:297.46px" class="cls_009"><span class="cls_009">Experiences</span></div>
<div style="position:absolute;left:304.56px;top:297.46px" class="cls_009"><span class="cls_009">• After school programs, For Adults</span></div>
<div style="position:absolute;left:68.03px;top:312.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:312.71px" class="cls_009"><span class="cls_009">More acceptance in schools, Morals, Values,</span></div>
<div style="position:absolute;left:304.56px;top:312.71px" class="cls_009"><span class="cls_009">• Investing in mentors</span></div>
<div style="position:absolute;left:78.03px;top:323.71px" class="cls_009"><span class="cls_009">Programs</span></div>
<div style="position:absolute;left:304.56px;top:327.96px" class="cls_009"><span class="cls_009">• Volunteer capacity for our kids</span></div>
<div style="position:absolute;left:68.03px;top:338.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:338.96px" class="cls_009"><span class="cls_009">Child lead accessibility</span></div>
<div style="position:absolute;left:304.56px;top:343.22px" class="cls_009"><span class="cls_009">• Wairua programs for parents</span></div>
<div style="position:absolute;left:68.03px;top:354.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:354.22px" class="cls_009"><span class="cls_009">Everyone has resilience</span></div>
<div style="position:absolute;left:304.56px;top:358.47px" class="cls_009"><span class="cls_009">• No cost</span></div>
<div style="position:absolute;left:68.03px;top:369.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:369.47px" class="cls_009"><span class="cls_009">Mana Enhancing</span></div>
<div style="position:absolute;left:115.88px;top:393.18px" class="cls_008"><span class="cls_008">Oct 18 - Feb 2019: Theme Focus Hui including anyone who opted into this</span></div>
<div style="position:absolute;left:227.22px;top:405.18px" class="cls_008"><span class="cls_008">particular discussion group.</span></div>
<div style="position:absolute;left:123.79px;top:428.69px" class="cls_010"><span class="cls_010">“Rangatahi Maori are connected to healthy adults in order to</span></div>
<div style="position:absolute;left:169.54px;top:439.69px" class="cls_010"><span class="cls_010">understand and build quality relationships.”</span></div>
<div style="position:absolute;left:271.62px;top:457.89px" class="cls_010"><span class="cls_010">ACTIONS:</span></div>
<div style="position:absolute;left:107.93px;top:477.81px" class="cls_009"><span class="cls_009">1.</span></div>
<div style="position:absolute;left:125.93px;top:477.81px" class="cls_009"><span class="cls_009">Purakau - flooding our</span></div>
<div style="position:absolute;left:304.21px;top:477.81px" class="cls_009"><span class="cls_009">2.</span></div>
<div style="position:absolute;left:322.21px;top:477.81px" class="cls_009"><span class="cls_009">For Our Kids - review and</span></div>
<div style="position:absolute;left:125.93px;top:488.81px" class="cls_009"><span class="cls_009">community with purakau</span></div>
<div style="position:absolute;left:322.21px;top:488.81px" class="cls_009"><span class="cls_009">resurrect the concept</span></div>
<div style="position:absolute;left:125.93px;top:499.81px" class="cls_009"><span class="cls_009">that celebrate being Maori,</span></div>
<div style="position:absolute;left:125.93px;top:510.81px" class="cls_009"><span class="cls_009">drawing on old  (pre-European)</span></div>
<div style="position:absolute;left:304.21px;top:508.31px" class="cls_009"><span class="cls_009">3.</span></div>
<div style="position:absolute;left:322.21px;top:508.31px" class="cls_009"><span class="cls_009">Mana Ririki - Maori parenting</span></div>
<div style="position:absolute;left:125.93px;top:521.81px" class="cls_009"><span class="cls_009">and new stories to break down the</span></div>
<div style="position:absolute;left:322.21px;top:519.31px" class="cls_009"><span class="cls_009">resource</span></div>
<div style="position:absolute;left:125.93px;top:532.81px" class="cls_009"><span class="cls_009">negative stereotypes.</span></div>
<div style="position:absolute;left:113.01px;top:560.75px" class="cls_008"><span class="cls_008">March - April 2019: Big Picture Statements from the Small Groups collated</span></div>
<div style="position:absolute;left:123.79px;top:593.03px" class="cls_010"><span class="cls_010">“Rangatahi Maori are connected to healthy adults in order to</span></div>
<div style="position:absolute;left:169.54px;top:604.03px" class="cls_010"><span class="cls_010">understand and build quality relationships.”</span></div>
<div style="position:absolute;left:271.62px;top:622.23px" class="cls_010"><span class="cls_010">ACTIONS:</span></div>
<div style="position:absolute;left:107.93px;top:642.16px" class="cls_009"><span class="cls_009">1.</span></div>
<div style="position:absolute;left:125.93px;top:642.16px" class="cls_009"><span class="cls_009">Purakau - flooding our</span></div>
<div style="position:absolute;left:304.21px;top:642.16px" class="cls_009"><span class="cls_009">2.</span></div>
<div style="position:absolute;left:322.21px;top:642.16px" class="cls_009"><span class="cls_009">For Our Kids - review and</span></div>
<div style="position:absolute;left:125.93px;top:653.16px" class="cls_009"><span class="cls_009">community with purakau</span></div>
<div style="position:absolute;left:322.21px;top:653.16px" class="cls_009"><span class="cls_009">resurrect the concept</span></div>
<div style="position:absolute;left:125.93px;top:664.16px" class="cls_009"><span class="cls_009">that celebrate being Maori,</span></div>
<div style="position:absolute;left:304.21px;top:672.66px" class="cls_009"><span class="cls_009">3.</span></div>
<div style="position:absolute;left:322.21px;top:672.66px" class="cls_009"><span class="cls_009">Mana Ririki - Maori parenting</span></div>
<div style="position:absolute;left:125.93px;top:675.16px" class="cls_009"><span class="cls_009">drawing on old  (pre-European)</span></div>
<div style="position:absolute;left:322.21px;top:683.66px" class="cls_009"><span class="cls_009">resource</span></div>
<div style="position:absolute;left:125.93px;top:686.16px" class="cls_009"><span class="cls_009">and new stories to break down the</span></div>
<div style="position:absolute;left:125.93px;top:697.16px" class="cls_009"><span class="cls_009">negative stereotypes.</span></div>
<div style="position:absolute;left:92.32px;top:720.33px" class="cls_008"><span class="cls_008">11/04/19: Large Hui @ Racecourse, 50+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:92.17px;top:732.33px" class="cls_008"><span class="cls_008">young adults, representatives of community agencies, government agencies and</span></div>
<div style="position:absolute;left:127.03px;top:744.33px" class="cls_008"><span class="cls_008">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:121.97px;top:768.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:139.97px;top:768.45px" class="cls_009"><span class="cls_009">Being Maori is not stink. How to make rangatahi proud to be who they are?</span></div>
<div style="position:absolute;left:121.97px;top:783.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:139.97px;top:783.71px" class="cls_009"><span class="cls_009">Have own individual identity, not scared to stand all, no ‘sheep’ mentality</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">10</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:11063px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background14.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.13px" class="cls_002"><span class="cls_002">Wairua - Spirituality</span></div>
<div style="position:absolute;left:102.87px;top:77.59px" class="cls_007"><span class="cls_007">6.</span></div>
<div style="position:absolute;left:95.85px;top:123.78px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.83px;top:135.78px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.44px;top:147.78px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:77.95px;top:180.70px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:68.03px;top:203.69px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:203.69px" class="cls_009"><span class="cls_009">Hope / Things can be done to get past barriers</span></div>
<div style="position:absolute;left:304.25px;top:203.69px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:203.69px" class="cls_009"><span class="cls_009">What are our challenges:</span></div>
<div style="position:absolute;left:78.03px;top:214.69px" class="cls_009"><span class="cls_009">an internal driver</span></div>
<div style="position:absolute;left:304.25px;top:218.94px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:218.94px" class="cls_009"><span class="cls_009">Social capability / human to human contact</span></div>
<div style="position:absolute;left:68.03px;top:229.94px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:229.94px" class="cls_009"><span class="cls_009">Youth Groups / Good support options/ different</span></div>
<div style="position:absolute;left:314.25px;top:229.94px" class="cls_009"><span class="cls_009">and connectedness</span></div>
<div style="position:absolute;left:78.03px;top:240.94px" class="cls_009"><span class="cls_009">ages / Values and belief range</span></div>
<div style="position:absolute;left:304.25px;top:245.19px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:245.19px" class="cls_009"><span class="cls_009">Being present in self Vs Avatar external identity</span></div>
<div style="position:absolute;left:68.03px;top:256.19px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:256.19px" class="cls_009"><span class="cls_009">Whanau / Impact when taken away /</span></div>
<div style="position:absolute;left:304.25px;top:260.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:260.45px" class="cls_009"><span class="cls_009">Spiritually devalued and not seen as important</span></div>
<div style="position:absolute;left:78.03px;top:267.19px" class="cls_009"><span class="cls_009">disconnect from whanau system and culture</span></div>
<div style="position:absolute;left:304.25px;top:275.70px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:275.70px" class="cls_009"><span class="cls_009">We are judgmental / Not safe for young people</span></div>
<div style="position:absolute;left:68.03px;top:282.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:282.45px" class="cls_009"><span class="cls_009">Physical / neglect</span></div>
<div style="position:absolute;left:304.25px;top:290.95px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:290.95px" class="cls_009"><span class="cls_009">Get told rather than allowed to explore</span></div>
<div style="position:absolute;left:68.03px;top:297.70px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:297.70px" class="cls_009"><span class="cls_009">Good mentors / Give opportunity / strengthen</span></div>
<div style="position:absolute;left:78.03px;top:308.70px" class="cls_009"><span class="cls_009">values</span></div>
<div style="position:absolute;left:304.25px;top:306.20px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:306.20px" class="cls_009"><span class="cls_009">Friend network may not be building young</span></div>
<div style="position:absolute;left:314.25px;top:317.20px" class="cls_009"><span class="cls_009">people’s well being</span></div>
<div style="position:absolute;left:68.03px;top:323.95px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:80.43px;top:323.95px" class="cls_009"><span class="cls_009">love and self develops strength / strong in</span></div>
<div style="position:absolute;left:78.03px;top:334.95px" class="cls_009"><span class="cls_009">some / lacking in others lead to disrespect</span></div>
<div style="position:absolute;left:304.25px;top:332.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:332.45px" class="cls_009"><span class="cls_009">Home well / how important / how relevant</span></div>
<div style="position:absolute;left:78.03px;top:345.95px" class="cls_009"><span class="cls_009">compound</span></div>
<div style="position:absolute;left:314.25px;top:343.45px" class="cls_009"><span class="cls_009">is the Christian church to young people and</span></div>
<div style="position:absolute;left:314.25px;top:354.45px" class="cls_009"><span class="cls_009">community</span></div>
<div style="position:absolute;left:68.03px;top:361.20px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:361.20px" class="cls_009"><span class="cls_009">United</span></div>
<div style="position:absolute;left:304.25px;top:369.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:369.71px" class="cls_009"><span class="cls_009">Feeling safe / to be safe / to take risk and</span></div>
<div style="position:absolute;left:68.03px;top:376.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:376.45px" class="cls_009"><span class="cls_009">Youth pastor cluster / Strong cluster</span></div>
<div style="position:absolute;left:314.25px;top:380.71px" class="cls_009"><span class="cls_009">develop / step outside the normal / to be</span></div>
<div style="position:absolute;left:68.03px;top:391.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:391.71px" class="cls_009"><span class="cls_009">Rongoa Mauri / all realms/ 3 clinics in WNG</span></div>
<div style="position:absolute;left:314.25px;top:391.71px" class="cls_009"><span class="cls_009">accepted</span></div>
<div style="position:absolute;left:68.03px;top:406.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:406.96px" class="cls_009"><span class="cls_009">School focus /Maori / Belong / connect / Has</span></div>
<div style="position:absolute;left:304.25px;top:406.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:406.96px" class="cls_009"><span class="cls_009">Things that work are not always accepted</span></div>
<div style="position:absolute;left:78.03px;top:417.96px" class="cls_009"><span class="cls_009">improved over the years</span></div>
<div style="position:absolute;left:314.25px;top:417.96px" class="cls_009"><span class="cls_009">across the community / Revo tour / youth</span></div>
<div style="position:absolute;left:314.25px;top:428.96px" class="cls_009"><span class="cls_009">group not</span></div>
<div style="position:absolute;left:68.03px;top:433.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:433.21px" class="cls_009"><span class="cls_009">Creativity strong in youth brings healing / keep</span></div>
<div style="position:absolute;left:78.03px;top:444.21px" class="cls_009"><span class="cls_009">in touch with wairua</span></div>
<div style="position:absolute;left:304.25px;top:444.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:444.21px" class="cls_009"><span class="cls_009">promoted / access young people in school /</span></div>
<div style="position:absolute;left:314.25px;top:455.21px" class="cls_009"><span class="cls_009">especially Christian e.g. Uncle Morvins Waiata /</span></div>
<div style="position:absolute;left:68.03px;top:459.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:459.46px" class="cls_009"><span class="cls_009">Kapahaka</span></div>
<div style="position:absolute;left:304.25px;top:470.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:470.46px" class="cls_009"><span class="cls_009">Borderline Christian</span></div>
<div style="position:absolute;left:68.03px;top:474.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:474.71px" class="cls_009"><span class="cls_009">Wananga o Aotearoa</span></div>
<div style="position:absolute;left:304.25px;top:485.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:485.71px" class="cls_009"><span class="cls_009">Disconnection / Foster</span></div>
<div style="position:absolute;left:68.03px;top:489.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:489.97px" class="cls_009"><span class="cls_009">Mauri / The Mauri within / Make a difference in</span></div>
<div style="position:absolute;left:78.03px;top:500.97px" class="cls_009"><span class="cls_009">their lives</span></div>
<div style="position:absolute;left:304.25px;top:500.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:500.97px" class="cls_009"><span class="cls_009">Not enough facts</span></div>
<div style="position:absolute;left:68.03px;top:516.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:516.22px" class="cls_009"><span class="cls_009">Starts within / Meditation</span></div>
<div style="position:absolute;left:304.25px;top:516.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:516.22px" class="cls_009"><span class="cls_009">Limited trust</span></div>
<div style="position:absolute;left:68.03px;top:531.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:531.47px" class="cls_009"><span class="cls_009">Awa / Waka ama / Rowing / Relationship</span></div>
<div style="position:absolute;left:304.25px;top:531.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:531.47px" class="cls_009"><span class="cls_009">Not physical activity</span></div>
<div style="position:absolute;left:68.03px;top:546.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:546.72px" class="cls_009"><span class="cls_009">Kura Maori / kohanga reo</span></div>
<div style="position:absolute;left:304.25px;top:546.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:316.65px;top:546.72px" class="cls_009"><span class="cls_009">Building Blocks / Sleep / eat well / exercise</span></div>
<div style="position:absolute;left:68.03px;top:561.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:80.43px;top:561.97px" class="cls_009"><span class="cls_009">Relationship to older people / kaumatua /</span></div>
<div style="position:absolute;left:304.25px;top:561.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:316.65px;top:561.97px" class="cls_009"><span class="cls_009">Separating superstition and myths from Facts</span></div>
<div style="position:absolute;left:78.03px;top:572.97px" class="cls_009"><span class="cls_009">Lack of these moments</span></div>
<div style="position:absolute;left:314.25px;top:572.97px" class="cls_009"><span class="cls_009">and evidence</span></div>
<div style="position:absolute;left:68.03px;top:588.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:588.23px" class="cls_009"><span class="cls_009">Whakapapa</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">11</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:11914px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background15.jpg" width=595 height=841></div>
<div style="position:absolute;left:77.67px;top:79.45px" class="cls_004"><span class="cls_004">What are our opportunities</span></div>
<div style="position:absolute;left:68.03px;top:101.24px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:101.24px" class="cls_009"><span class="cls_009">Meditation / In schools</span></div>
<div style="position:absolute;left:303.91px;top:101.24px" class="cls_009"><span class="cls_009">• WNG learning center / Waka / art installation</span></div>
<div style="position:absolute;left:68.03px;top:116.49px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:116.49px" class="cls_009"><span class="cls_009">How we going to win if we don’t right within “</span></div>
<div style="position:absolute;left:303.91px;top:116.49px" class="cls_009"><span class="cls_009">• What it means to be Maori / Create</span></div>
<div style="position:absolute;left:78.03px;top:127.49px" class="cls_009"><span class="cls_009">Lauren Hill “</span></div>
<div style="position:absolute;left:313.91px;top:127.49px" class="cls_009"><span class="cls_009">opportunities for young people to learn and be</span></div>
<div style="position:absolute;left:313.91px;top:138.49px" class="cls_009"><span class="cls_009">proud / Tell stories</span></div>
<div style="position:absolute;left:68.03px;top:142.74px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:142.74px" class="cls_009"><span class="cls_009">Yoga / Compassion is a result</span></div>
<div style="position:absolute;left:303.91px;top:153.75px" class="cls_009"><span class="cls_009">• Education / see the person as a whole</span></div>
<div style="position:absolute;left:68.03px;top:158.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:158.00px" class="cls_009"><span class="cls_009">More utilizing of Awa Tipua</span></div>
<div style="position:absolute;left:303.91px;top:169.00px" class="cls_009"><span class="cls_009">• Create space where young people can feel</span></div>
<div style="position:absolute;left:68.03px;top:173.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:173.25px" class="cls_009"><span class="cls_009">Understanding vitality / connect to our sources</span></div>
<div style="position:absolute;left:313.91px;top:180.00px" class="cls_009"><span class="cls_009">accepted and build confidence to take risk /</span></div>
<div style="position:absolute;left:78.03px;top:184.25px" class="cls_009"><span class="cls_009">/ support self-belief / support self-awareness /</span></div>
<div style="position:absolute;left:313.91px;top:191.00px" class="cls_009"><span class="cls_009">small</span></div>
<div style="position:absolute;left:68.03px;top:199.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:199.50px" class="cls_009"><span class="cls_009">accepting of self</span></div>
<div style="position:absolute;left:303.91px;top:206.25px" class="cls_009"><span class="cls_009">• groups (safe) / progress into larger group</span></div>
<div style="position:absolute;left:68.03px;top:214.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:214.75px" class="cls_009"><span class="cls_009">Mediation in community / understanding of</span></div>
<div style="position:absolute;left:303.91px;top:221.50px" class="cls_009"><span class="cls_009">• Creative expression / encourage young people</span></div>
<div style="position:absolute;left:78.03px;top:225.75px" class="cls_009"><span class="cls_009">meditation inner engineering</span></div>
<div style="position:absolute;left:313.91px;top:232.50px" class="cls_009"><span class="cls_009">to express e.g. Sisters United in Akld / more</span></div>
<div style="position:absolute;left:68.03px;top:241.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:241.00px" class="cls_009"><span class="cls_009">Came to fight and then introduced inner</span></div>
<div style="position:absolute;left:303.91px;top:247.75px" class="cls_009"><span class="cls_009">• mentors</span></div>
<div style="position:absolute;left:78.03px;top:252.00px" class="cls_009"><span class="cls_009">engineering</span></div>
<div style="position:absolute;left:303.91px;top:263.00px" class="cls_009"><span class="cls_009">• Foster care / How we better support young</span></div>
<div style="position:absolute;left:68.03px;top:267.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:267.26px" class="cls_009"><span class="cls_009">Teaching young people to be present / human</span></div>
<div style="position:absolute;left:313.91px;top:274.00px" class="cls_009"><span class="cls_009">people to stay connected when in care</span></div>
<div style="position:absolute;left:78.03px;top:278.26px" class="cls_009"><span class="cls_009">to human</span></div>
<div style="position:absolute;left:303.91px;top:289.26px" class="cls_009"><span class="cls_009">• Bring back blue light / places for young people</span></div>
<div style="position:absolute;left:68.03px;top:293.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:293.51px" class="cls_009"><span class="cls_009">Opt to engage with young people /</span></div>
<div style="position:absolute;left:313.91px;top:300.26px" class="cls_009"><span class="cls_009">to hang out</span></div>
<div style="position:absolute;left:68.03px;top:308.76px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:308.76px" class="cls_009"><span class="cls_009">More Tuakana / Teina</span></div>
<div style="position:absolute;left:303.91px;top:315.51px" class="cls_009"><span class="cls_009">• Building facilities / resources /</span></div>
<div style="position:absolute;left:68.03px;top:324.01px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:324.01px" class="cls_009"><span class="cls_009">Build Mauri ora / the journey of learning self “ko</span></div>
<div style="position:absolute;left:303.91px;top:330.76px" class="cls_009"><span class="cls_009">• Organizational conscious bias / does it exist?</span></div>
<div style="position:absolute;left:78.03px;top:335.01px" class="cls_009"><span class="cls_009">wai au”</span></div>
<div style="position:absolute;left:313.91px;top:341.76px" class="cls_009"><span class="cls_009">Maybe!</span></div>
<div style="position:absolute;left:68.03px;top:350.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:350.26px" class="cls_009"><span class="cls_009">Create opportunities to connect with and work</span></div>
<div style="position:absolute;left:303.91px;top:357.01px" class="cls_009"><span class="cls_009">• Opportunity’s for all young people to do</span></div>
<div style="position:absolute;left:78.03px;top:361.26px" class="cls_009"><span class="cls_009">with people</span></div>
<div style="position:absolute;left:313.91px;top:368.01px" class="cls_009"><span class="cls_009">pro-social activities</span></div>
<div style="position:absolute;left:68.03px;top:376.52px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:376.52px" class="cls_009"><span class="cls_009">Learn their whakapapa connection and take</span></div>
<div style="position:absolute;left:78.03px;top:387.52px" class="cls_009"><span class="cls_009">them to connect</span></div>
<div style="position:absolute;left:83.40px;top:414.06px" class="cls_008"><span class="cls_008">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:77.66px;top:426.06px" class="cls_008"><span class="cls_008">young adults, representatives of churches and agencies and community agencies and</span></div>
<div style="position:absolute;left:123.36px;top:438.06px" class="cls_008"><span class="cls_008">schools. Invitations send via çemail and open invitation via facebook</span></div>
<div style="position:absolute;left:77.35px;top:469.03px" class="cls_004"><span class="cls_004">Strengths - Themes</span></div>
<div style="position:absolute;left:313.87px;top:469.03px" class="cls_004"><span class="cls_004">Challenge</span></div>
<div style="position:absolute;left:68.03px;top:492.52px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:492.52px" class="cls_009"><span class="cls_009">Faith based network</span></div>
<div style="position:absolute;left:303.91px;top:490.82px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.91px;top:490.82px" class="cls_009"><span class="cls_009">Losing connection</span></div>
<div style="position:absolute;left:68.03px;top:507.78px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:507.78px" class="cls_009"><span class="cls_009">The ‘Within’, ‘Inner self’, Te Mauri</span></div>
<div style="position:absolute;left:303.91px;top:506.07px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.91px;top:506.07px" class="cls_009"><span class="cls_009">Lack of belonging</span></div>
<div style="position:absolute;left:68.03px;top:523.03px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:523.03px" class="cls_009"><span class="cls_009">Human to human contact & connectedness</span></div>
<div style="position:absolute;left:303.91px;top:521.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:313.91px;top:521.33px" class="cls_009"><span class="cls_009">If we lose the essence & Mauri of the person we</span></div>
<div style="position:absolute;left:313.91px;top:532.33px" class="cls_009"><span class="cls_009">have lost something essential</span></div>
<div style="position:absolute;left:77.35px;top:543.87px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:313.87px;top:553.16px" class="cls_004"><span class="cls_004">So What:</span></div>
<div style="position:absolute;left:77.35px;top:558.87px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:304.25px;top:574.95px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:574.95px" class="cls_009"><span class="cls_009">Activates, Do more and see what we notice in</span></div>
<div style="position:absolute;left:68.03px;top:580.65px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:580.65px" class="cls_009"><span class="cls_009">Human to human contact & connectedness</span></div>
<div style="position:absolute;left:314.25px;top:585.95px" class="cls_009"><span class="cls_009">young people’s wellbeing</span></div>
<div style="position:absolute;left:68.03px;top:595.91px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:595.91px" class="cls_009"><span class="cls_009">Mentoring</span></div>
<div style="position:absolute;left:304.25px;top:601.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:601.21px" class="cls_009"><span class="cls_009">Mindfulness</span></div>
<div style="position:absolute;left:68.03px;top:611.16px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:611.16px" class="cls_009"><span class="cls_009">Encouraging young people</span></div>
<div style="position:absolute;left:68.03px;top:626.41px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:626.41px" class="cls_009"><span class="cls_009">Strength, focus</span></div>
<div style="position:absolute;left:68.03px;top:641.66px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:641.66px" class="cls_009"><span class="cls_009">Challenge</span></div>
<div style="position:absolute;left:68.03px;top:656.91px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:656.91px" class="cls_009"><span class="cls_009">Giving responsibility, Tuakana, Teina</span></div>
<div style="position:absolute;left:68.03px;top:672.17px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:672.17px" class="cls_009"><span class="cls_009">Inspire, Hold hope</span></div>
<div style="position:absolute;left:68.03px;top:687.42px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:687.42px" class="cls_009"><span class="cls_009">Self awareness</span></div>
<div style="position:absolute;left:68.03px;top:702.67px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:702.67px" class="cls_009"><span class="cls_009">Not judge the other person</span></div>
<div style="position:absolute;left:68.03px;top:717.92px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:717.92px" class="cls_009"><span class="cls_009">Positive reinforcement</span></div>
<div style="position:absolute;left:68.03px;top:733.17px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:733.17px" class="cls_009"><span class="cls_009">Youth person centred focus</span></div>
<div style="position:absolute;left:68.03px;top:748.43px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:748.43px" class="cls_009"><span class="cls_009">Being present for each other</span></div>
<div style="position:absolute;left:68.03px;top:763.68px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:763.68px" class="cls_009"><span class="cls_009">There for ourselves & for others</span></div>
<div style="position:absolute;left:68.03px;top:778.93px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:778.93px" class="cls_009"><span class="cls_009">“I exist because you exist”, “You exist because</span></div>
<div style="position:absolute;left:78.03px;top:789.93px" class="cls_009"><span class="cls_009">I exist”</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">12</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:12765px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background16.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.13px" class="cls_002"><span class="cls_002">Employment Career & Independence</span></div>
<div style="position:absolute;left:102.87px;top:77.59px" class="cls_007"><span class="cls_007">7.</span></div>
<div style="position:absolute;left:95.85px;top:123.78px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.83px;top:135.78px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.44px;top:147.78px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:78.02px;top:177.54px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:68.03px;top:199.32px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:199.32px" class="cls_009"><span class="cls_009">Training providers (Heaps)</span></div>
<div style="position:absolute;left:304.83px;top:199.32px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.83px;top:199.32px" class="cls_009"><span class="cls_009">Lots of leadership groups / mentors / support</span></div>
<div style="position:absolute;left:68.03px;top:214.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:214.58px" class="cls_009"><span class="cls_009">Size of community / Interconnection</span></div>
<div style="position:absolute;left:304.83px;top:214.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.83px;top:214.58px" class="cls_009"><span class="cls_009">High speed broadband (For those that have it)</span></div>
<div style="position:absolute;left:68.03px;top:229.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:229.83px" class="cls_009"><span class="cls_009">The willingness of our community to connect</span></div>
<div style="position:absolute;left:304.83px;top:229.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.83px;top:229.83px" class="cls_009"><span class="cls_009">Lots of people that can work</span></div>
<div style="position:absolute;left:68.03px;top:245.08px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:245.08px" class="cls_009"><span class="cls_009">Requirement to create employment (Also a</span></div>
<div style="position:absolute;left:78.03px;top:256.08px" class="cls_009"><span class="cls_009">challenge) / Opportunities / Lots of enterprise</span></div>
<div style="position:absolute;left:78.03px;top:267.08px" class="cls_009"><span class="cls_009">/ Not a lot of paid employment / Plenty of</span></div>
<div style="position:absolute;left:78.03px;top:278.08px" class="cls_009"><span class="cls_009">voluntary employment (Skills and experience)</span></div>
<div style="position:absolute;left:78.02px;top:298.92px" class="cls_004"><span class="cls_004">What are our challenges:</span></div>
<div style="position:absolute;left:68.03px;top:320.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:320.71px" class="cls_009"><span class="cls_009">Preserved lack of employment opportunities /</span></div>
<div style="position:absolute;left:304.25px;top:320.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:320.71px" class="cls_009"><span class="cls_009">Lots of training providers</span></div>
<div style="position:absolute;left:78.03px;top:331.71px" class="cls_009"><span class="cls_009">What does this actually look like</span></div>
<div style="position:absolute;left:304.25px;top:335.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:335.96px" class="cls_009"><span class="cls_009">Students at tertiary with NCEA LV 1 & 2 but not</span></div>
<div style="position:absolute;left:68.03px;top:346.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:346.96px" class="cls_009"><span class="cls_009">Constrained economy</span></div>
<div style="position:absolute;left:314.25px;top:346.96px" class="cls_009"><span class="cls_009">at level to study unsupported</span></div>
<div style="position:absolute;left:68.03px;top:362.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:362.21px" class="cls_009"><span class="cls_009">Drivers Licenses / To get to work</span></div>
<div style="position:absolute;left:304.25px;top:362.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:362.21px" class="cls_009"><span class="cls_009">Life skills / CV / Financial awareness / cooking /</span></div>
<div style="position:absolute;left:314.25px;top:373.21px" class="cls_009"><span class="cls_009">shopping etc.</span></div>
<div style="position:absolute;left:68.03px;top:377.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:377.46px" class="cls_009"><span class="cls_009">Driving convictions / caught I system</span></div>
<div style="position:absolute;left:304.25px;top:388.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:388.46px" class="cls_009"><span class="cls_009">Systems and process from orgs/agencies</span></div>
<div style="position:absolute;left:68.03px;top:392.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:392.72px" class="cls_009"><span class="cls_009">Volunteer culture / expectation to work unpaid</span></div>
<div style="position:absolute;left:314.25px;top:399.46px" class="cls_009"><span class="cls_009">exclusions from opportunities / isolation</span></div>
<div style="position:absolute;left:68.03px;top:407.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:407.97px" class="cls_009"><span class="cls_009">Cooperation Vs Co-operation</span></div>
<div style="position:absolute;left:304.25px;top:414.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:414.72px" class="cls_009"><span class="cls_009">Education system</span></div>
<div style="position:absolute;left:68.03px;top:423.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:423.22px" class="cls_009"><span class="cls_009">Agencies reliant on contractual funding rather</span></div>
<div style="position:absolute;left:304.25px;top:429.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:429.97px" class="cls_009"><span class="cls_009">Temptations of media and advertising / H.P /</span></div>
<div style="position:absolute;left:78.03px;top:434.22px" class="cls_009"><span class="cls_009">than working together / competition</span></div>
<div style="position:absolute;left:314.25px;top:440.97px" class="cls_009"><span class="cls_009">Keeping up with their peers / Interest on loans</span></div>
<div style="position:absolute;left:68.03px;top:449.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:449.47px" class="cls_009"><span class="cls_009">Rangatahi not engaged in education /limited</span></div>
<div style="position:absolute;left:304.25px;top:456.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:456.22px" class="cls_009"><span class="cls_009">Suddenly have money but don’t know how to</span></div>
<div style="position:absolute;left:68.03px;top:464.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:464.72px" class="cls_009"><span class="cls_009">Opportunities to pathway / Falling through</span></div>
<div style="position:absolute;left:314.25px;top:467.22px" class="cls_009"><span class="cls_009">Budget / Spend wisely / Save (Think they can</span></div>
<div style="position:absolute;left:78.03px;top:475.72px" class="cls_009"><span class="cls_009">gaps</span></div>
<div style="position:absolute;left:314.25px;top:478.22px" class="cls_009"><span class="cls_009">party)</span></div>
<div style="position:absolute;left:68.03px;top:490.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:490.98px" class="cls_009"><span class="cls_009">One shoe fits all education system / Main</span></div>
<div style="position:absolute;left:304.25px;top:493.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:493.47px" class="cls_009"><span class="cls_009">Minimum wage</span></div>
<div style="position:absolute;left:78.03px;top:501.98px" class="cls_009"><span class="cls_009">stream</span></div>
<div style="position:absolute;left:304.25px;top:508.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:508.72px" class="cls_009"><span class="cls_009">Jobs need to apply online / barrier to those</span></div>
<div style="position:absolute;left:68.03px;top:517.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:517.23px" class="cls_009"><span class="cls_009">Size locations of Rohe</span></div>
<div style="position:absolute;left:314.25px;top:519.72px" class="cls_009"><span class="cls_009">that don’t have access</span></div>
<div style="position:absolute;left:68.03px;top:532.48px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:532.48px" class="cls_009"><span class="cls_009">Lack of knowledge re: Direction for career</span></div>
<div style="position:absolute;left:304.25px;top:534.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:534.98px" class="cls_009"><span class="cls_009">Supportive employment environment /1st Job</span></div>
<div style="position:absolute;left:78.03px;top:543.48px" class="cls_009"><span class="cls_009">opportunities</span></div>
<div style="position:absolute;left:304.25px;top:550.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:550.23px" class="cls_009"><span class="cls_009">How to receive constructive feedback and how</span></div>
<div style="position:absolute;left:68.03px;top:558.73px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:558.73px" class="cls_009"><span class="cls_009">School focus to much on university education</span></div>
<div style="position:absolute;left:314.25px;top:561.23px" class="cls_009"><span class="cls_009">to give it</span></div>
<div style="position:absolute;left:68.03px;top:573.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:573.98px" class="cls_009"><span class="cls_009">Transferable skills not emphasized</span></div>
<div style="position:absolute;left:304.25px;top:576.48px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:576.48px" class="cls_009"><span class="cls_009">Device isolation don’t have to communicate</span></div>
<div style="position:absolute;left:68.03px;top:589.24px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:589.24px" class="cls_009"><span class="cls_009">Too little or too much responsibility (Not</span></div>
<div style="position:absolute;left:314.25px;top:587.48px" class="cls_009"><span class="cls_009">face to face</span></div>
<div style="position:absolute;left:78.03px;top:600.24px" class="cls_009"><span class="cls_009">conducive to independence</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">13</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:13616px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background17.jpg" width=595 height=841></div>
<div style="position:absolute;left:77.47px;top:79.45px" class="cls_004"><span class="cls_004">What are our opportunities:</span></div>
<div style="position:absolute;left:68.03px;top:101.24px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:101.24px" class="cls_009"><span class="cls_009">Utilizing what we have</span></div>
<div style="position:absolute;left:304.45px;top:101.24px" class="cls_009"><span class="cls_009">• Collaborative pathway to support wider</span></div>
<div style="position:absolute;left:314.45px;top:112.24px" class="cls_009"><span class="cls_009">options</span></div>
<div style="position:absolute;left:68.03px;top:116.49px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:80.43px;top:116.49px" class="cls_009"><span class="cls_009">Creativity</span></div>
<div style="position:absolute;left:304.45px;top:127.49px" class="cls_009"><span class="cls_009">•  Engage rangatahi regarding career</span></div>
<div style="position:absolute;left:68.03px;top:131.74px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:131.74px" class="cls_009"><span class="cls_009">Opportunity’s to develop pathways/ network</span></div>
<div style="position:absolute;left:314.45px;top:138.49px" class="cls_009"><span class="cls_009">opportunities earlier and re defining the way</span></div>
<div style="position:absolute;left:68.03px;top:147.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:147.00px" class="cls_009"><span class="cls_009">Whanau ora / Navigators / Cradle to grave</span></div>
<div style="position:absolute;left:314.45px;top:149.49px" class="cls_009"><span class="cls_009">the “expos” are delivered / Rangatahi don’t</span></div>
<div style="position:absolute;left:78.03px;top:158.00px" class="cls_009"><span class="cls_009">24/7</span></div>
<div style="position:absolute;left:314.45px;top:160.49px" class="cls_009"><span class="cls_009">know what they need to know / is it effective</span></div>
<div style="position:absolute;left:68.03px;top:173.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:173.25px" class="cls_009"><span class="cls_009">Admission of what us and what isn’t being</span></div>
<div style="position:absolute;left:304.45px;top:175.74px" class="cls_009"><span class="cls_009">• Chamber / WNG and partners / Rangatahi</span></div>
<div style="position:absolute;left:78.03px;top:184.25px" class="cls_009"><span class="cls_009">done and recognizing gaps in between</span></div>
<div style="position:absolute;left:314.45px;top:186.74px" class="cls_009"><span class="cls_009">focus</span></div>
<div style="position:absolute;left:68.03px;top:199.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:199.50px" class="cls_009"><span class="cls_009">developing programs and training</span></div>
<div style="position:absolute;left:304.45px;top:202.00px" class="cls_009"><span class="cls_009">• Maori and Pacific trade training / Locally run</span></div>
<div style="position:absolute;left:78.03px;top:210.50px" class="cls_009"><span class="cls_009">opportunities to meet many different types of</span></div>
<div style="position:absolute;left:304.45px;top:217.25px" class="cls_009"><span class="cls_009">• Resourcing Mentors</span></div>
<div style="position:absolute;left:78.03px;top:221.50px" class="cls_009"><span class="cls_009">rangatahi and their skills / Learning styles</span></div>
<div style="position:absolute;left:304.45px;top:232.50px" class="cls_009"><span class="cls_009">• On the job career day</span></div>
<div style="position:absolute;left:68.03px;top:236.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:236.75px" class="cls_009"><span class="cls_009">Encourage trades and skills / Lack of</span></div>
<div style="position:absolute;left:78.03px;top:247.75px" class="cls_009"><span class="cls_009">apprenticeships / create more</span></div>
<div style="position:absolute;left:304.45px;top:247.75px" class="cls_009"><span class="cls_009">• What do our rangatahi need / Package /</span></div>
<div style="position:absolute;left:314.45px;top:258.75px" class="cls_009"><span class="cls_009">Drivers L / Level 1 and 2</span></div>
<div style="position:absolute;left:68.03px;top:263.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:263.00px" class="cls_009"><span class="cls_009">Technology and innovation / education system</span></div>
<div style="position:absolute;left:78.03px;top:274.00px" class="cls_009"><span class="cls_009">hasn’t adapted to meet these needs</span></div>
<div style="position:absolute;left:304.45px;top:274.00px" class="cls_009"><span class="cls_009">• What do they need to be an adult in the world?</span></div>
<div style="position:absolute;left:68.03px;top:289.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:289.26px" class="cls_009"><span class="cls_009">Creative culture / Entrepreneurship / what</span></div>
<div style="position:absolute;left:304.45px;top:289.26px" class="cls_009"><span class="cls_009">• Supported career plans developed within</span></div>
<div style="position:absolute;left:78.03px;top:300.26px" class="cls_009"><span class="cls_009">does this look like locally?</span></div>
<div style="position:absolute;left:314.45px;top:300.26px" class="cls_009"><span class="cls_009">rangatahi</span></div>
<div style="position:absolute;left:68.03px;top:315.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:315.51px" class="cls_009"><span class="cls_009">Redefined boxes re: Employment/ Career /</span></div>
<div style="position:absolute;left:304.45px;top:315.51px" class="cls_009"><span class="cls_009">• Challenging our young people to “ Broaden</span></div>
<div style="position:absolute;left:78.03px;top:326.51px" class="cls_009"><span class="cls_009">independence</span></div>
<div style="position:absolute;left:314.45px;top:326.51px" class="cls_009"><span class="cls_009">their horizon”</span></div>
<div style="position:absolute;left:107.50px;top:351.05px" class="cls_011"><span class="cls_011">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary</span></div>
<div style="position:absolute;left:87.56px;top:362.05px" class="cls_011"><span class="cls_011">students, young adults, representatives of churches and agencies and community</span></div>
<div style="position:absolute;left:89.55px;top:373.05px" class="cls_011"><span class="cls_011">agencies and schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:77.92px;top:401.46px" class="cls_004"><span class="cls_004">Challenges</span></div>
<div style="position:absolute;left:315.12px;top:401.46px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:315.12px;top:416.46px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:68.03px;top:423.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:423.25px" class="cls_009"><span class="cls_009">Barriers to becoming mentors</span></div>
<div style="position:absolute;left:68.03px;top:438.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:438.50px" class="cls_009"><span class="cls_009">Life experiences vs. goals</span></div>
<div style="position:absolute;left:304.02px;top:438.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.02px;top:438.25px" class="cls_009"><span class="cls_009">Collaborative hui</span></div>
<div style="position:absolute;left:68.03px;top:453.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:453.75px" class="cls_009"><span class="cls_009">Not a lot of faith in their abilities</span></div>
<div style="position:absolute;left:304.02px;top:453.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.02px;top:453.50px" class="cls_009"><span class="cls_009">Better engagement with communities to see</span></div>
<div style="position:absolute;left:314.02px;top:464.50px" class="cls_009"><span class="cls_009">true needs</span></div>
<div style="position:absolute;left:68.03px;top:469.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:469.00px" class="cls_009"><span class="cls_009">Schools not providing proper</span></div>
<div style="position:absolute;left:78.03px;top:480.00px" class="cls_009"><span class="cls_009">career advice</span></div>
<div style="position:absolute;left:304.02px;top:479.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.02px;top:479.75px" class="cls_009"><span class="cls_009">Business entrepreneur training</span></div>
<div style="position:absolute;left:68.03px;top:495.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:495.25px" class="cls_009"><span class="cls_009">NCEA doesn’t really relate or prepare</span></div>
<div style="position:absolute;left:304.02px;top:495.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.02px;top:495.00px" class="cls_009"><span class="cls_009">Encourage exploring</span></div>
<div style="position:absolute;left:78.03px;top:506.25px" class="cls_009"><span class="cls_009">for tertiary</span></div>
<div style="position:absolute;left:304.02px;top:510.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.02px;top:510.25px" class="cls_009"><span class="cls_009">More bosses</span></div>
<div style="position:absolute;left:68.03px;top:521.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:521.51px" class="cls_009"><span class="cls_009">Qualifications, expectations</span></div>
<div style="position:absolute;left:304.02px;top:525.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.02px;top:525.51px" class="cls_009"><span class="cls_009">Parenting skills, life skills</span></div>
<div style="position:absolute;left:304.02px;top:540.76px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.02px;top:540.76px" class="cls_009"><span class="cls_009">Kids at university or higher education</span></div>
<div style="position:absolute;left:77.92px;top:542.34px" class="cls_004"><span class="cls_004">Strengths - Themes</span></div>
<div style="position:absolute;left:304.02px;top:556.01px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.02px;top:556.01px" class="cls_009"><span class="cls_009">Celebrate success</span></div>
<div style="position:absolute;left:68.03px;top:564.13px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:564.13px" class="cls_009"><span class="cls_009">Heaps of training providers for some subjects</span></div>
<div style="position:absolute;left:304.02px;top:571.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.02px;top:571.26px" class="cls_009"><span class="cls_009">Embracing failure</span></div>
<div style="position:absolute;left:68.03px;top:579.38px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:579.38px" class="cls_009"><span class="cls_009">A lot of factories</span></div>
<div style="position:absolute;left:304.02px;top:586.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.02px;top:586.51px" class="cls_009"><span class="cls_009">Empower the community, Whanau</span></div>
<div style="position:absolute;left:68.03px;top:594.64px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:594.64px" class="cls_009"><span class="cls_009">Online tools, Trade me, Careers NZ, Seek,</span></div>
<div style="position:absolute;left:78.03px;top:605.64px" class="cls_009"><span class="cls_009">Jobs R Us</span></div>
<div style="position:absolute;left:313.52px;top:607.35px" class="cls_004"><span class="cls_004">New Mahi:</span></div>
<div style="position:absolute;left:77.92px;top:626.47px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:304.25px;top:629.14px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:629.14px" class="cls_009"><span class="cls_009">Companies, Sustainable</span></div>
<div style="position:absolute;left:77.92px;top:641.47px" class="cls_004"><span class="cls_004">we do less of?</span></div>
<div style="position:absolute;left:304.25px;top:644.39px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:644.39px" class="cls_009"><span class="cls_009">Mentoring</span></div>
<div style="position:absolute;left:304.25px;top:659.64px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:659.64px" class="cls_009"><span class="cls_009">Community empowerment</span></div>
<div style="position:absolute;left:68.03px;top:663.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:663.26px" class="cls_009"><span class="cls_009">School system, Needs overhaul</span></div>
<div style="position:absolute;left:304.25px;top:674.90px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:674.90px" class="cls_009"><span class="cls_009">Financial literacy</span></div>
<div style="position:absolute;left:68.03px;top:678.52px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:678.52px" class="cls_009"><span class="cls_009">Stale intervention</span></div>
<div style="position:absolute;left:68.03px;top:693.77px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:693.77px" class="cls_009"><span class="cls_009">Being told what to do</span></div>
<div style="position:absolute;left:68.03px;top:709.02px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:709.02px" class="cls_009"><span class="cls_009">High expectations & lack of empathy</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">14</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:14467px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background18.jpg" width=595 height=841></div>
<div style="position:absolute;left:115.05px;top:80.42px" class="cls_011"><span class="cls_011">Oct 18 - Feb 2019: Theme Focus Hui including anyone who opted into this</span></div>
<div style="position:absolute;left:226.26px;top:91.42px" class="cls_011"><span class="cls_011">particular discussion group.</span></div>
<div style="position:absolute;left:150.36px;top:117.79px" class="cls_004"><span class="cls_004">“Rangatahi Maori are connected to healthy adults in order to</span></div>
<div style="position:absolute;left:191.95px;top:132.79px" class="cls_004"><span class="cls_004">understand and build quality relationships.”</span></div>
<div style="position:absolute;left:274.97px;top:147.05px" class="cls_010"><span class="cls_010">ACTION:</span></div>
<div style="position:absolute;left:104.81px;top:162.28px" class="cls_009"><span class="cls_009">1.</span></div>
<div style="position:absolute;left:126.81px;top:162.28px" class="cls_009"><span class="cls_009">To have a known site where all providers can be located on it and links to</span></div>
<div style="position:absolute;left:126.81px;top:173.28px" class="cls_009"><span class="cls_009">supporting sites like careers website, also making hard copies available for</span></div>
<div style="position:absolute;left:126.81px;top:184.28px" class="cls_009"><span class="cls_009">schools like WTEC do with the tertiary directory</span></div>
<div style="position:absolute;left:142.48px;top:213.37px" class="cls_011"><span class="cls_011">March - April 2019: Big Picture from the Small Groups collated</span></div>
<div style="position:absolute;left:147.64px;top:243.45px" class="cls_004"><span class="cls_004">““Rangatahi Maori are connected to healthy adults in order to</span></div>
<div style="position:absolute;left:191.95px;top:258.45px" class="cls_004"><span class="cls_004">understand and build quality relationships.”</span></div>
<div style="position:absolute;left:114.43px;top:280.29px" class="cls_009"><span class="cls_009">1.</span></div>
<div style="position:absolute;left:136.43px;top:280.29px" class="cls_009"><span class="cls_009">Every rangatahi Maori is supported when they leave school to enrol in further</span></div>
<div style="position:absolute;left:136.43px;top:291.29px" class="cls_009"><span class="cls_009">training/education or to secure employment.</span></div>
<div style="position:absolute;left:114.43px;top:306.54px" class="cls_009"><span class="cls_009">2.</span></div>
<div style="position:absolute;left:136.43px;top:306.54px" class="cls_009"><span class="cls_009">To have a known site where all providers can be located on it, and links to</span></div>
<div style="position:absolute;left:136.43px;top:317.54px" class="cls_009"><span class="cls_009">supporting sites likecareers website, also making hard copies available for</span></div>
<div style="position:absolute;left:136.43px;top:328.54px" class="cls_009"><span class="cls_009">schools like WTEC do with the tertiary directory</span></div>
<div style="position:absolute;left:90.60px;top:355.42px" class="cls_011"><span class="cls_011">11/04/19: Large Hui @ Racecourse, 50+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:90.08px;top:366.42px" class="cls_011"><span class="cls_011">young adults, representatives of community agencies, government agencies and</span></div>
<div style="position:absolute;left:125.39px;top:377.42px" class="cls_011"><span class="cls_011">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:124.09px;top:407.91px" class="cls_009"><span class="cls_009">Support for young people who aren’t in school but too young for employment</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">15</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:15318px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background19.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.13px" class="cls_002"><span class="cls_002">Housing</span></div>
<div style="position:absolute;left:102.87px;top:77.59px" class="cls_007"><span class="cls_007">8.</span></div>
<div style="position:absolute;left:95.85px;top:123.78px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.83px;top:135.78px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.44px;top:147.78px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:78.02px;top:180.54px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:68.03px;top:202.32px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:202.32px" class="cls_009"><span class="cls_009">Grace foundation / Range of community</span></div>
<div style="position:absolute;left:304.25px;top:202.32px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:202.32px" class="cls_009"><span class="cls_009">Agencies willing to help support youth to get</span></div>
<div style="position:absolute;left:78.03px;top:213.32px" class="cls_009"><span class="cls_009">providers with interest</span></div>
<div style="position:absolute;left:314.25px;top:213.32px" class="cls_009"><span class="cls_009">good housing</span></div>
<div style="position:absolute;left:68.03px;top:228.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:228.58px" class="cls_009"><span class="cls_009">Salvation army</span></div>
<div style="position:absolute;left:304.25px;top:228.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:228.58px" class="cls_009"><span class="cls_009">Everywhere is walkable in relation to</span></div>
<div style="position:absolute;left:314.25px;top:239.58px" class="cls_009"><span class="cls_009">employment and where you may live</span></div>
<div style="position:absolute;left:68.03px;top:243.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:243.83px" class="cls_009"><span class="cls_009">Local churches</span></div>
<div style="position:absolute;left:304.25px;top:254.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:254.83px" class="cls_009"><span class="cls_009">We have some large villas and big spaces that</span></div>
<div style="position:absolute;left:68.03px;top:259.08px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:259.08px" class="cls_009"><span class="cls_009">Need and desire to co-create sustainable</span></div>
<div style="position:absolute;left:314.25px;top:265.83px" class="cls_009"><span class="cls_009">we could make into shared accommodation</span></div>
<div style="position:absolute;left:78.03px;top:270.08px" class="cls_009"><span class="cls_009">housing solutions</span></div>
<div style="position:absolute;left:314.25px;top:276.83px" class="cls_009"><span class="cls_009">for Young people / Local Marae</span></div>
<div style="position:absolute;left:68.03px;top:285.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:285.33px" class="cls_009"><span class="cls_009">Local innovations emerging</span></div>
<div style="position:absolute;left:78.02px;top:306.17px" class="cls_004"><span class="cls_004">What are our challenges:</span></div>
<div style="position:absolute;left:68.03px;top:327.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:327.96px" class="cls_009"><span class="cls_009">Limited housing opportunities</span></div>
<div style="position:absolute;left:304.25px;top:327.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:327.96px" class="cls_009"><span class="cls_009">Landlords and rental companies rude</span></div>
<div style="position:absolute;left:314.25px;top:338.96px" class="cls_009"><span class="cls_009">disrespectful to our young people and often to</span></div>
<div style="position:absolute;left:68.03px;top:343.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:343.21px" class="cls_009"><span class="cls_009">Below standard housing costing way too much</span></div>
<div style="position:absolute;left:314.25px;top:349.96px" class="cls_009"><span class="cls_009">those who</span></div>
<div style="position:absolute;left:68.03px;top:358.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:358.46px" class="cls_009"><span class="cls_009">Rangatahi sometimes too young to sign leases</span></div>
<div style="position:absolute;left:304.25px;top:365.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:365.21px" class="cls_009"><span class="cls_009">advocatory for them as well</span></div>
<div style="position:absolute;left:68.03px;top:373.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:373.72px" class="cls_009"><span class="cls_009">Lack of money that youth have access to</span></div>
<div style="position:absolute;left:304.25px;top:380.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:380.46px" class="cls_009"><span class="cls_009">Fear of being evicted</span></div>
<div style="position:absolute;left:68.03px;top:388.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:388.97px" class="cls_009"><span class="cls_009">Low finance / Low credit /Low wages etc.</span></div>
<div style="position:absolute;left:304.25px;top:395.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:395.72px" class="cls_009"><span class="cls_009">Bad credit</span></div>
<div style="position:absolute;left:68.03px;top:404.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:404.22px" class="cls_009"><span class="cls_009">Lack of life skills to meet the challenges of</span></div>
<div style="position:absolute;left:304.25px;top:410.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:410.97px" class="cls_009"><span class="cls_009">Housing standards poor</span></div>
<div style="position:absolute;left:78.03px;top:415.22px" class="cls_009"><span class="cls_009">being in own home</span></div>
<div style="position:absolute;left:304.25px;top:426.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:426.22px" class="cls_009"><span class="cls_009">Emergency housing / no follow up future plans</span></div>
<div style="position:absolute;left:68.03px;top:430.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:430.47px" class="cls_009"><span class="cls_009">Lack of respect from rangatahi for what has</span></div>
<div style="position:absolute;left:78.03px;top:441.47px" class="cls_009"><span class="cls_009">been offered when housed i.e. Trashingnhomes</span></div>
<div style="position:absolute;left:304.25px;top:441.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:441.47px" class="cls_009"><span class="cls_009">Stop giving asylum seekers priority over home</span></div>
<div style="position:absolute;left:314.25px;top:452.47px" class="cls_009"><span class="cls_009">grown assets / The people</span></div>
<div style="position:absolute;left:68.03px;top:456.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:456.72px" class="cls_009"><span class="cls_009">Compliance cost for landlords / property’s with</span></div>
<div style="position:absolute;left:78.03px;top:467.72px" class="cls_009"><span class="cls_009">new legislations</span></div>
<div style="position:absolute;left:78.02px;top:488.56px" class="cls_004"><span class="cls_004">What are our opportunities:</span></div>
<div style="position:absolute;left:68.03px;top:510.35px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:510.35px" class="cls_009"><span class="cls_009">Bring rangatahi into the korero and solutions /</span></div>
<div style="position:absolute;left:304.25px;top:510.35px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:510.35px" class="cls_009"><span class="cls_009">Better modern homes</span></div>
<div style="position:absolute;left:78.03px;top:521.35px" class="cls_009"><span class="cls_009">what are there reality’s</span></div>
<div style="position:absolute;left:304.25px;top:525.60px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:525.60px" class="cls_009"><span class="cls_009">Networks and their connections build with</span></div>
<div style="position:absolute;left:68.03px;top:536.60px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:536.60px" class="cls_009"><span class="cls_009">Rangatahi involved in housing improvement</span></div>
<div style="position:absolute;left:314.25px;top:536.60px" class="cls_009"><span class="cls_009">rental companies / get them to hui to meet our</span></div>
<div style="position:absolute;left:78.03px;top:547.60px" class="cls_009"><span class="cls_009">projects i.e. PTEs and others</span></div>
<div style="position:absolute;left:314.25px;top:547.60px" class="cls_009"><span class="cls_009">young people and hear their challenges</span></div>
<div style="position:absolute;left:68.03px;top:562.85px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:562.85px" class="cls_009"><span class="cls_009">Support rangatahi to learn and develop skills</span></div>
<div style="position:absolute;left:304.25px;top:562.85px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:562.85px" class="cls_009"><span class="cls_009">Education of our young people on budgeting /</span></div>
<div style="position:absolute;left:78.03px;top:573.85px" class="cls_009"><span class="cls_009">to cope</span></div>
<div style="position:absolute;left:314.25px;top:573.85px" class="cls_009"><span class="cls_009">rental agreements / bond / tenancy tribunal</span></div>
<div style="position:absolute;left:68.03px;top:589.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:589.11px" class="cls_009"><span class="cls_009">Building financial capability and resilience of</span></div>
<div style="position:absolute;left:304.25px;top:589.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:589.11px" class="cls_009"><span class="cls_009">Youth can run life skills in schools / workshops</span></div>
<div style="position:absolute;left:78.03px;top:600.11px" class="cls_009"><span class="cls_009">rangatahi and their whanau</span></div>
<div style="position:absolute;left:304.25px;top:604.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:604.36px" class="cls_009"><span class="cls_009">Build more houses</span></div>
<div style="position:absolute;left:68.03px;top:615.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:615.36px" class="cls_009"><span class="cls_009">Lots of substandard housing stock</span></div>
<div style="position:absolute;left:304.25px;top:619.61px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:619.61px" class="cls_009"><span class="cls_009">Teen parent home</span></div>
<div style="position:absolute;left:68.03px;top:630.61px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:630.61px" class="cls_009"><span class="cls_009">Safe emergency housing with wrap around</span></div>
<div style="position:absolute;left:304.25px;top:634.86px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:634.86px" class="cls_009"><span class="cls_009">Housing for youth within Youth justice system</span></div>
<div style="position:absolute;left:78.03px;top:641.61px" class="cls_009"><span class="cls_009">services onsite to build skills / resilience /</span></div>
<div style="position:absolute;left:78.03px;top:652.61px" class="cls_009"><span class="cls_009">opportunity’s</span></div>
<div style="position:absolute;left:304.25px;top:650.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:650.11px" class="cls_009"><span class="cls_009">Rent to buy system / HNZ and Public sectors</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">16</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:16169px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background20.jpg" width=595 height=841></div>
<div style="position:absolute;left:84.00px;top:85.15px" class="cls_008"><span class="cls_008">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:79.56px;top:97.15px" class="cls_008"><span class="cls_008">young adults,representatives of churches and agencies and community agencies and</span></div>
<div style="position:absolute;left:126.96px;top:109.15px" class="cls_008"><span class="cls_008">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:77.35px;top:140.15px" class="cls_004"><span class="cls_004">Strengths - Themes</span></div>
<div style="position:absolute;left:313.57px;top:140.15px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:313.57px;top:153.15px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:68.03px;top:163.64px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:163.64px" class="cls_009"><span class="cls_009">Community are providing essential housing</span></div>
<div style="position:absolute;left:78.03px;top:174.64px" class="cls_009"><span class="cls_009">support, With or Without govt financial support</span></div>
<div style="position:absolute;left:304.25px;top:176.94px" class="cls_009"><span class="cls_009">• Accessible loans</span></div>
<div style="position:absolute;left:68.03px;top:189.89px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:189.89px" class="cls_009"><span class="cls_009">Pungarehu, Papa Kainga Housing</span></div>
<div style="position:absolute;left:304.25px;top:192.19px" class="cls_009"><span class="cls_009">• PapaKainga</span></div>
<div style="position:absolute;left:68.03px;top:205.14px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:205.14px" class="cls_009"><span class="cls_009">Community is identifying and responding to</span></div>
<div style="position:absolute;left:304.25px;top:207.44px" class="cls_009"><span class="cls_009">• Communal living</span></div>
<div style="position:absolute;left:78.03px;top:216.14px" class="cls_009"><span class="cls_009">our own need</span></div>
<div style="position:absolute;left:304.25px;top:222.69px" class="cls_009"><span class="cls_009">• Multiple buildings on one land</span></div>
<div style="position:absolute;left:77.65px;top:236.98px" class="cls_004"><span class="cls_004">Challenge</span></div>
<div style="position:absolute;left:304.25px;top:237.95px" class="cls_009"><span class="cls_009">• Multiple whanau on one house</span></div>
<div style="position:absolute;left:304.25px;top:253.20px" class="cls_009"><span class="cls_009">• Teach Youth about - Money, Skills to be a</span></div>
<div style="position:absolute;left:67.69px;top:260.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:77.69px;top:260.47px" class="cls_009"><span class="cls_009">Lack of houses, Houses availble</span></div>
<div style="position:absolute;left:314.25px;top:264.20px" class="cls_009"><span class="cls_009">good tenant, Tenant rights, Budget, Being a</span></div>
<div style="position:absolute;left:67.69px;top:275.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:77.69px;top:275.72px" class="cls_009"><span class="cls_009">Cost of living</span></div>
<div style="position:absolute;left:314.25px;top:275.20px" class="cls_009"><span class="cls_009">responsiblentenant, cooking, looking after</span></div>
<div style="position:absolute;left:314.25px;top:286.20px" class="cls_009"><span class="cls_009">house</span></div>
<div style="position:absolute;left:67.69px;top:290.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:77.69px;top:290.97px" class="cls_009"><span class="cls_009">Trashing houses,</span></div>
<div style="position:absolute;left:304.25px;top:301.45px" class="cls_009"><span class="cls_009">• Tiny houses, Build your own, use of land</span></div>
<div style="position:absolute;left:67.69px;top:306.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:77.69px;top:306.23px" class="cls_009"><span class="cls_009">Not knowing how to be house proud</span></div>
<div style="position:absolute;left:304.25px;top:316.70px" class="cls_009"><span class="cls_009">• Using hemp as a building material (Jerusalem)</span></div>
<div style="position:absolute;left:67.69px;top:321.48px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:77.69px;top:321.48px" class="cls_009"><span class="cls_009">Youth related, Stigma, Money, Skills to be a</span></div>
<div style="position:absolute;left:77.69px;top:332.48px" class="cls_009"><span class="cls_009">good tenant, Tenant rights, Budget, Look, utility</span></div>
<div style="position:absolute;left:304.25px;top:331.95px" class="cls_009"><span class="cls_009">• Sustainable housing</span></div>
<div style="position:absolute;left:304.25px;top:347.21px" class="cls_009"><span class="cls_009">• Council compliance</span></div>
<div style="position:absolute;left:77.65px;top:353.32px" class="cls_004"><span class="cls_004">So What:</span></div>
<div style="position:absolute;left:68.03px;top:376.81px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:376.81px" class="cls_009"><span class="cls_009">Activates, Do more and see what we notice in</span></div>
<div style="position:absolute;left:78.03px;top:387.81px" class="cls_009"><span class="cls_009">young people’s wellbeing</span></div>
<div style="position:absolute;left:68.03px;top:403.06px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:403.06px" class="cls_009"><span class="cls_009">Mindfulness</span></div>
<div style="position:absolute;left:88.61px;top:427.31px" class="cls_011"><span class="cls_011">Oct 18 - Feb 2019: Theme Focus Hui including anyone who opted into this particular</span></div>
<div style="position:absolute;left:252.70px;top:438.31px" class="cls_011"><span class="cls_011">discussion group.</span></div>
<div style="position:absolute;left:144.85px;top:464.87px" class="cls_004"><span class="cls_004">“Rangatahi Maori and their whanau have access to affordable,</span></div>
<div style="position:absolute;left:219.69px;top:479.87px" class="cls_004"><span class="cls_004">safe, warm sustainable housing.”</span></div>
<div style="position:absolute;left:274.97px;top:494.14px" class="cls_010"><span class="cls_010">ACTION:</span></div>
<div style="position:absolute;left:114.43px;top:511.37px" class="cls_009"><span class="cls_009">1.</span></div>
<div style="position:absolute;left:136.43px;top:511.37px" class="cls_009"><span class="cls_009">Investigate accessible affordable loan options (investment, crown/Iwi loan</span></div>
<div style="position:absolute;left:136.43px;top:522.37px" class="cls_009"><span class="cls_009">funding that enables a 10% deposit as opposed to current 20%)</span></div>
<div style="position:absolute;left:114.43px;top:537.62px" class="cls_009"><span class="cls_009">2</span></div>
<div style="position:absolute;left:136.43px;top:537.62px" class="cls_009"><span class="cls_009">Support the development of papakainga and sustainable housing</span></div>
<div style="position:absolute;left:136.43px;top:548.62px" class="cls_009"><span class="cls_009">inWhanganui</span></div>
<div style="position:absolute;left:142.48px;top:575.70px" class="cls_011"><span class="cls_011">March - April 2019: Big Picture from the Small Groups collated</span></div>
<div style="position:absolute;left:115.06px;top:607.79px" class="cls_004"><span class="cls_004">“Rangatahi Maori and their whanau have access to affordable, safe, warm</span></div>
<div style="position:absolute;left:170.16px;top:622.79px" class="cls_004"><span class="cls_004">sustainable housing which is appropriately located.”</span></div>
<div style="position:absolute;left:114.43px;top:640.63px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:132.43px;top:640.63px" class="cls_009"><span class="cls_009">Investigate accessible affordable loan options (investment, crown/Iwi loan</span></div>
<div style="position:absolute;left:132.43px;top:651.63px" class="cls_009"><span class="cls_009">funding that enables a 10% deposit as opposed to current 20%)</span></div>
<div style="position:absolute;left:114.43px;top:666.88px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:132.43px;top:666.88px" class="cls_009"><span class="cls_009">Support the development of papakainga and sustainable housing in Whanganui</span></div>
<div style="position:absolute;left:114.43px;top:682.13px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:132.43px;top:682.13px" class="cls_009"><span class="cls_009">Rangatahi Maori and their whanau are supported to prepare and present</span></div>
<div style="position:absolute;left:132.43px;top:693.13px" class="cls_009"><span class="cls_009">themselves well when they are seeking rental accomodation</span></div>
<div style="position:absolute;left:90.60px;top:720.01px" class="cls_011"><span class="cls_011">11/04/19: Large Hui @ Racecourse, 50+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:90.08px;top:731.01px" class="cls_011"><span class="cls_011">young adults, representatives of community agencies, government agencies and</span></div>
<div style="position:absolute;left:125.39px;top:742.01px" class="cls_011"><span class="cls_011">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:90.21px;top:772.50px" class="cls_009"><span class="cls_009">Seek to improve the way rangatahi Maori renters are viewed in our community. Address and</span></div>
<div style="position:absolute;left:191.04px;top:783.50px" class="cls_009"><span class="cls_009">counter the fears of landlords, a positive image</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">17</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:17020px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background21.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.13px" class="cls_002"><span class="cls_002">Connected & Participating</span></div>
<div style="position:absolute;left:102.87px;top:77.59px" class="cls_007"><span class="cls_007">9.</span></div>
<div style="position:absolute;left:95.85px;top:123.78px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.83px;top:135.78px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.44px;top:147.78px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:78.02px;top:178.54px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:68.03px;top:200.32px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:200.32px" class="cls_009"><span class="cls_009">Having great role models in our community</span></div>
<div style="position:absolute;left:304.25px;top:200.32px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:200.32px" class="cls_009"><span class="cls_009">Connect with whanau that live elsewhere</span></div>
<div style="position:absolute;left:68.03px;top:215.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:215.58px" class="cls_009"><span class="cls_009">Having close knit connections in our</span></div>
<div style="position:absolute;left:304.25px;top:215.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:215.58px" class="cls_009"><span class="cls_009">Ultrafast internet / for some areas</span></div>
<div style="position:absolute;left:78.03px;top:226.58px" class="cls_009"><span class="cls_009">community</span></div>
<div style="position:absolute;left:304.25px;top:230.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:230.83px" class="cls_009"><span class="cls_009">Very It literate rangatahi</span></div>
<div style="position:absolute;left:68.03px;top:241.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:241.83px" class="cls_009"><span class="cls_009">Te Awa Tupua is a being with whom we can</span></div>
<div style="position:absolute;left:304.25px;top:246.08px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:246.08px" class="cls_009"><span class="cls_009">Connect with your rangatahi via SM</span></div>
<div style="position:absolute;left:78.03px;top:252.83px" class="cls_009"><span class="cls_009">have relationship</span></div>
<div style="position:absolute;left:304.25px;top:261.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:261.33px" class="cls_009"><span class="cls_009">Creating pathways and opportunities</span></div>
<div style="position:absolute;left:68.03px;top:268.08px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:268.08px" class="cls_009"><span class="cls_009">Community place making i.e. Stone Soup /</span></div>
<div style="position:absolute;left:304.25px;top:276.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:276.58px" class="cls_009"><span class="cls_009">Social services / youth groups</span></div>
<div style="position:absolute;left:78.03px;top:279.08px" class="cls_009"><span class="cls_009">Who / what else</span></div>
<div style="position:absolute;left:304.25px;top:291.84px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:291.84px" class="cls_009"><span class="cls_009">Youth council</span></div>
<div style="position:absolute;left:68.03px;top:294.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:294.33px" class="cls_009"><span class="cls_009">Lots of opportunity’s / Sport / Cultural /</span></div>
<div style="position:absolute;left:78.03px;top:305.33px" class="cls_009"><span class="cls_009">kapa haka</span></div>
<div style="position:absolute;left:78.02px;top:326.17px" class="cls_004"><span class="cls_004">What are our challenges:</span></div>
<div style="position:absolute;left:68.03px;top:347.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:347.96px" class="cls_009"><span class="cls_009">Accessibility / Location i.e. Rural /Urban</span></div>
<div style="position:absolute;left:304.25px;top:347.96px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:347.96px" class="cls_009"><span class="cls_009">Whanau Barriers to participate / Putea</span></div>
<div style="position:absolute;left:314.25px;top:358.96px" class="cls_009"><span class="cls_009">/ priority / time / access to equipment /</span></div>
<div style="position:absolute;left:68.03px;top:363.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:363.21px" class="cls_009"><span class="cls_009">Normalized living</span></div>
<div style="position:absolute;left:314.25px;top:369.96px" class="cls_009"><span class="cls_009">transport</span></div>
<div style="position:absolute;left:68.03px;top:378.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:378.46px" class="cls_009"><span class="cls_009">How to ensure services they need?</span></div>
<div style="position:absolute;left:304.25px;top:385.21px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:385.21px" class="cls_009"><span class="cls_009">Funding cut for youth</span></div>
<div style="position:absolute;left:68.03px;top:393.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:393.72px" class="cls_009"><span class="cls_009">Isolation be it geographical or social or</span></div>
<div style="position:absolute;left:304.25px;top:400.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:400.46px" class="cls_009"><span class="cls_009">Single parent homes</span></div>
<div style="position:absolute;left:78.03px;top:404.72px" class="cls_009"><span class="cls_009">educationally</span></div>
<div style="position:absolute;left:304.25px;top:415.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:316.65px;top:415.72px" class="cls_009"><span class="cls_009">High unemployment</span></div>
<div style="position:absolute;left:68.03px;top:419.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:419.97px" class="cls_009"><span class="cls_009">Sports, League clubs for Rangatahi not in</span></div>
<div style="position:absolute;left:78.03px;top:430.97px" class="cls_009"><span class="cls_009">school</span></div>
<div style="position:absolute;left:304.25px;top:430.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:430.97px" class="cls_009"><span class="cls_009">Broken families /homes</span></div>
<div style="position:absolute;left:68.03px;top:446.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:446.22px" class="cls_009"><span class="cls_009">Lack of collaboration between organization’s</span></div>
<div style="position:absolute;left:304.25px;top:446.22px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:446.22px" class="cls_009"><span class="cls_009">Addiction - A&D / Gaming</span></div>
<div style="position:absolute;left:68.03px;top:461.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:461.47px" class="cls_009"><span class="cls_009">Self-esteem /self-belief to engage, participate</span></div>
<div style="position:absolute;left:304.25px;top:461.47px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:316.65px;top:461.47px" class="cls_009"><span class="cls_009">Lack of connection with the whanau culture</span></div>
<div style="position:absolute;left:78.03px;top:472.47px" class="cls_009"><span class="cls_009">Resilience</span></div>
<div style="position:absolute;left:304.25px;top:476.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:476.72px" class="cls_009"><span class="cls_009">Cyber bullying / social media depression</span></div>
<div style="position:absolute;left:68.03px;top:487.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:487.72px" class="cls_009"><span class="cls_009">Broad representation of youth voice</span></div>
<div style="position:absolute;left:304.25px;top:491.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:491.98px" class="cls_009"><span class="cls_009">Sexual exploitation</span></div>
<div style="position:absolute;left:68.03px;top:502.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:502.98px" class="cls_009"><span class="cls_009">Creating a space for youth socializing</span></div>
<div style="position:absolute;left:304.25px;top:507.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:507.23px" class="cls_009"><span class="cls_009">Certain groups of rangatahi not willing to</span></div>
<div style="position:absolute;left:68.03px;top:518.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:518.23px" class="cls_009"><span class="cls_009">Poverty / Racism</span></div>
<div style="position:absolute;left:314.25px;top:518.23px" class="cls_009"><span class="cls_009">participate</span></div>
<div style="position:absolute;left:78.02px;top:545.25px" class="cls_004"><span class="cls_004">What are our opportunities:</span></div>
<div style="position:absolute;left:68.03px;top:567.04px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:567.04px" class="cls_009"><span class="cls_009">Giving the opportunity to be the teacher</span></div>
<div style="position:absolute;left:304.25px;top:567.04px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:567.04px" class="cls_009"><span class="cls_009">Rangatahi led projects / video projects /</span></div>
<div style="position:absolute;left:314.25px;top:578.04px" class="cls_009"><span class="cls_009">promoting well being</span></div>
<div style="position:absolute;left:68.03px;top:582.29px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:582.29px" class="cls_009"><span class="cls_009">Using social platforms to wananga</span></div>
<div style="position:absolute;left:304.25px;top:593.29px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:593.29px" class="cls_009"><span class="cls_009">Mau Rakau / Wananga and training to be a</span></div>
<div style="position:absolute;left:68.03px;top:597.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:597.55px" class="cls_009"><span class="cls_009">Reduce social isolation in Kaumatua</span></div>
<div style="position:absolute;left:314.25px;top:604.29px" class="cls_009"><span class="cls_009">part of their daily diet</span></div>
<div style="position:absolute;left:68.03px;top:612.80px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:612.80px" class="cls_009"><span class="cls_009">Rangatahi / young people have the power to</span></div>
<div style="position:absolute;left:304.25px;top:619.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:619.55px" class="cls_009"><span class="cls_009">Journey alongside Rangatahi / Guides / Elders</span></div>
<div style="position:absolute;left:78.03px;top:623.80px" class="cls_009"><span class="cls_009">change their power / take ownership</span></div>
<div style="position:absolute;left:314.25px;top:630.55px" class="cls_009"><span class="cls_009">/ Tuakana</span></div>
<div style="position:absolute;left:68.03px;top:639.05px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:639.05px" class="cls_009"><span class="cls_009">Work better together</span></div>
<div style="position:absolute;left:304.25px;top:645.80px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:316.65px;top:645.80px" class="cls_009"><span class="cls_009">How do we scale and make available for all?</span></div>
<div style="position:absolute;left:68.03px;top:654.30px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:654.30px" class="cls_009"><span class="cls_009">Te Reo / whakapapa</span></div>
<div style="position:absolute;left:304.25px;top:661.05px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:661.05px" class="cls_009"><span class="cls_009">Youth worker expo</span></div>
<div style="position:absolute;left:68.03px;top:669.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:80.43px;top:669.55px" class="cls_009"><span class="cls_009">Increase access to safe healthy environments</span></div>
<div style="position:absolute;left:304.25px;top:676.30px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:676.30px" class="cls_009"><span class="cls_009">Regular meeting with stake holders</span></div>
<div style="position:absolute;left:78.03px;top:680.55px" class="cls_009"><span class="cls_009">/ hubs / recreational areas</span></div>
<div style="position:absolute;left:304.25px;top:691.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:691.55px" class="cls_009"><span class="cls_009">Opportunity to recognize the online connection</span></div>
<div style="position:absolute;left:68.03px;top:695.81px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:695.81px" class="cls_009"><span class="cls_009">Increase action around connecting Rangatahi</span></div>
<div style="position:absolute;left:314.25px;top:702.55px" class="cls_009"><span class="cls_009">/ How do we reach these rangatahi here</span></div>
<div style="position:absolute;left:78.03px;top:706.81px" class="cls_009"><span class="cls_009">with Employment / social / volunteer</span></div>
<div style="position:absolute;left:304.25px;top:717.81px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:316.65px;top:717.81px" class="cls_009"><span class="cls_009">Exploring the “pay-off” that young people get</span></div>
<div style="position:absolute;left:68.03px;top:722.06px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:722.06px" class="cls_009"><span class="cls_009">Opportunities for creative expression / art /</span></div>
<div style="position:absolute;left:314.25px;top:728.81px" class="cls_009"><span class="cls_009">from connecting and participating in harmful</span></div>
<div style="position:absolute;left:78.03px;top:733.06px" class="cls_009"><span class="cls_009">dance / poetry performing arts</span></div>
<div style="position:absolute;left:314.25px;top:739.81px" class="cls_009"><span class="cls_009">networksand behavior’s</span></div>
<div style="position:absolute;left:68.03px;top:748.31px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:748.31px" class="cls_009"><span class="cls_009">Rangatahi forum (but don’t call it Rangatahi</span></div>
<div style="position:absolute;left:304.25px;top:755.06px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:316.65px;top:755.06px" class="cls_009"><span class="cls_009">Human to human contact / sometimes it</span></div>
<div style="position:absolute;left:78.03px;top:759.31px" class="cls_009"><span class="cls_009">forum</span></div>
<div style="position:absolute;left:314.25px;top:766.06px" class="cls_009"><span class="cls_009">helps to just burst that bubble “like with a hug”</span></div>
<div style="position:absolute;left:68.03px;top:774.56px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:80.43px;top:774.56px" class="cls_009"><span class="cls_009">How to parent / how to father / how to mother</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">18</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:17871px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background22.jpg" width=595 height=841></div>
<div style="position:absolute;left:84.00px;top:85.15px" class="cls_008"><span class="cls_008">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:78.26px;top:97.15px" class="cls_008"><span class="cls_008">young adults, representatives of churches and agencies and community agencies and</span></div>
<div style="position:absolute;left:126.96px;top:109.15px" class="cls_008"><span class="cls_008">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:77.35px;top:140.31px" class="cls_004"><span class="cls_004">Strengths - Themes</span></div>
<div style="position:absolute;left:68.03px;top:163.80px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:163.80px" class="cls_009"><span class="cls_009">Technology, Rangatahi are literate connect in</span></div>
<div style="position:absolute;left:78.03px;top:174.80px" class="cls_009"><span class="cls_009">this medium having good internet</span></div>
<div style="position:absolute;left:68.03px;top:190.05px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:190.05px" class="cls_009"><span class="cls_009">Connectedness, Role models, close knit</span></div>
<div style="position:absolute;left:78.03px;top:201.05px" class="cls_009"><span class="cls_009">community, Lots of places to connect,</span></div>
<div style="position:absolute;left:78.03px;top:212.05px" class="cls_009"><span class="cls_009">opportunity to</span></div>
<div style="position:absolute;left:68.03px;top:227.31px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:227.31px" class="cls_009"><span class="cls_009">create hang out space. Hapu, Iwi, Marae,</span></div>
<div style="position:absolute;left:78.03px;top:238.31px" class="cls_009"><span class="cls_009">Whanau</span></div>
<div style="position:absolute;left:68.03px;top:253.56px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:253.56px" class="cls_009"><span class="cls_009">Sports</span></div>
<div style="position:absolute;left:68.03px;top:268.81px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:268.81px" class="cls_009"><span class="cls_009">Strong committed youth workers</span></div>
<div style="position:absolute;left:77.99px;top:289.65px" class="cls_004"><span class="cls_004">Challenges</span></div>
<div style="position:absolute;left:68.03px;top:311.44px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:80.43px;top:311.44px" class="cls_009"><span class="cls_009">Family context</span></div>
<div style="position:absolute;left:68.03px;top:326.69px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:326.69px" class="cls_009"><span class="cls_009">Unhealthy relationships</span></div>
<div style="position:absolute;left:68.03px;top:341.94px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:341.94px" class="cls_009"><span class="cls_009">Intergenerational trauma</span></div>
<div style="position:absolute;left:68.03px;top:357.19px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:357.19px" class="cls_009"><span class="cls_009">Family violence</span></div>
<div style="position:absolute;left:68.03px;top:372.44px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:372.44px" class="cls_009"><span class="cls_009">Cyber bullying</span></div>
<div style="position:absolute;left:68.03px;top:387.70px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:387.70px" class="cls_009"><span class="cls_009">Addiction</span></div>
<div style="position:absolute;left:68.03px;top:402.95px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:402.95px" class="cls_009"><span class="cls_009">Barriers to connect and engage</span></div>
<div style="position:absolute;left:68.03px;top:418.20px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:418.20px" class="cls_009"><span class="cls_009">Gaming, Technology</span></div>
<div style="position:absolute;left:68.03px;top:433.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:433.45px" class="cls_009"><span class="cls_009">Navigating services, Linking to the right one as</span></div>
<div style="position:absolute;left:78.03px;top:444.45px" class="cls_009"><span class="cls_009">there are many</span></div>
<div style="position:absolute;left:68.03px;top:459.70px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:459.70px" class="cls_009"><span class="cls_009">Financial & mobility</span></div>
<div style="position:absolute;left:76.46px;top:483.10px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:76.46px;top:496.10px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:68.03px;top:519.89px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:519.89px" class="cls_009"><span class="cls_009">Getting Rangatahi to be more involved in</span></div>
<div style="position:absolute;left:78.03px;top:530.89px" class="cls_009"><span class="cls_009">leadership</span></div>
<div style="position:absolute;left:68.03px;top:546.14px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:546.14px" class="cls_009"><span class="cls_009">More opportunity for them to be involved at</span></div>
<div style="position:absolute;left:78.03px;top:557.14px" class="cls_009"><span class="cls_009">their level</span></div>
<div style="position:absolute;left:68.03px;top:572.39px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:572.39px" class="cls_009"><span class="cls_009">Easy opportunity, Happen naturally organic/</span></div>
<div style="position:absolute;left:78.03px;top:583.39px" class="cls_009"><span class="cls_009">informed which will help overcome, inspire,</span></div>
<div style="position:absolute;left:78.03px;top:594.39px" class="cls_009"><span class="cls_009">enhance, protect, role models</span></div>
<div style="position:absolute;left:68.03px;top:609.64px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:609.64px" class="cls_009"><span class="cls_009">Community relationships</span></div>
<div style="position:absolute;left:68.03px;top:624.90px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:624.90px" class="cls_009"><span class="cls_009">Youth workers in school and remote</span></div>
<div style="position:absolute;left:78.03px;top:635.90px" class="cls_009"><span class="cls_009">communities e.g. 24/7 youth</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">19</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:18722px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background23.jpg" width=595 height=841></div>
<div style="position:absolute;left:88.61px;top:84.18px" class="cls_011"><span class="cls_011">Oct 18 - Feb 2019: Theme Focus Hui including anyone who opted into this particular</span></div>
<div style="position:absolute;left:252.70px;top:95.18px" class="cls_011"><span class="cls_011">discussion group.</span></div>
<div style="position:absolute;left:184.56px;top:119.19px" class="cls_004"><span class="cls_004">“Bring rangatahi Māori to a space of wellbeing”</span></div>
<div style="position:absolute;left:110.08px;top:148.85px" class="cls_005"><span class="cls_005">We meet at Rutherford Junior High on Tuesday 27th 2018</span></div>
<div style="position:absolute;left:110.08px;top:184.85px" class="cls_005"><span class="cls_005">The Plan:</span></div>
<div style="position:absolute;left:110.08px;top:208.85px" class="cls_005"><span class="cls_005">Ask our work mates these questions:</span></div>
<div style="position:absolute;left:110.08px;top:229.35px" class="cls_005"><span class="cls_005">•   What does it look like to be connected and participating?</span></div>
<div style="position:absolute;left:110.08px;top:241.35px" class="cls_005"><span class="cls_005">•   What do you think you’re doing that contributes to successful</span></div>
<div style="position:absolute;left:128.08px;top:253.35px" class="cls_005"><span class="cls_005">connected and participating with Rangatahi</span></div>
<div style="position:absolute;left:110.08px;top:265.35px" class="cls_005"><span class="cls_005">•   Why are these things important?</span></div>
<div style="position:absolute;left:110.08px;top:277.35px" class="cls_005"><span class="cls_005">•   Is there anything to improve your practise?</span></div>
<div style="position:absolute;left:110.08px;top:301.35px" class="cls_005"><span class="cls_005">Questions for the Rangatahi;</span></div>
<div style="position:absolute;left:110.08px;top:321.85px" class="cls_005"><span class="cls_005">•   What do you think it looks and feels like to be connected?</span></div>
<div style="position:absolute;left:110.08px;top:333.85px" class="cls_005"><span class="cls_005">•   What makes you want to participate?</span></div>
<div style="position:absolute;left:146.08px;top:345.85px" class="cls_005"><span class="cls_005">- Why do those things matter?</span></div>
<div style="position:absolute;left:110.08px;top:357.85px" class="cls_005"><span class="cls_005">•   Is there anything kaimahi (teachers/social workers) could do to</span></div>
<div style="position:absolute;left:128.08px;top:369.85px" class="cls_005"><span class="cls_005">increase your participation?</span></div>
<div style="position:absolute;left:110.08px;top:393.85px" class="cls_005"><span class="cls_005">We felt that though we want the information from these questions they</span></div>
<div style="position:absolute;left:110.08px;top:405.85px" class="cls_005"><span class="cls_005">were not youth friendly, Rutherford will be taking the questions to a small</span></div>
<div style="position:absolute;left:110.08px;top:417.85px" class="cls_005"><span class="cls_005">group of their leaders and reshaping the questions sometime this week</span></div>
<div style="position:absolute;left:110.08px;top:441.85px" class="cls_005"><span class="cls_005">We will make time next week to connect to as many small groups of youth</span></div>
<div style="position:absolute;left:110.08px;top:453.85px" class="cls_005"><span class="cls_005">(schools seem like the easiest but not only option) and collect the data to</span></div>
<div style="position:absolute;left:110.08px;top:465.85px" class="cls_005"><span class="cls_005">feed back.</span></div>
<div style="position:absolute;left:91.81px;top:499.23px" class="cls_008"><span class="cls_008">I have spoken to both Jay and Judy and they do not know any other groups doing</span></div>
<div style="position:absolute;left:184.51px;top:511.23px" class="cls_008"><span class="cls_008">this and thing it should not overlap. However,</span></div>
<div style="position:absolute;left:196.57px;top:523.23px" class="cls_008"><span class="cls_008">we have two (2) weeks to feedback info.</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">20</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:19573px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background24.jpg" width=595 height=841></div>
<div style="position:absolute;left:110.08px;top:79.07px" class="cls_005"><span class="cls_005">So we asked all the schools if we could meet with a group of students to</span></div>
<div style="position:absolute;left:110.08px;top:91.07px" class="cls_005"><span class="cls_005">ask our questions. As it was the end of year, only two could fit us in,</span></div>
<div style="position:absolute;left:112.68px;top:103.07px" class="cls_012"><span class="cls_012">City College</span><span class="cls_005"> and </span><span class="cls_013">Rutherford junior high</span><span class="cls_005"> here are their answers:</span></div>
<div style="position:absolute;left:87.60px;top:122.08px" class="cls_005"><span class="cls_005">1.</span></div>
<div style="position:absolute;left:123.60px;top:122.08px" class="cls_005"><span class="cls_005">What do you think it looks & feels like to be connected?</span></div>
<div style="position:absolute;left:104.88px;top:141.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:141.08px" class="cls_014"><span class="cls_014">Giving things a go</span></div>
<div style="position:absolute;left:104.88px;top:153.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:153.08px" class="cls_014"><span class="cls_014">Feeling safe</span></div>
<div style="position:absolute;left:104.88px;top:165.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:165.08px" class="cls_014"><span class="cls_014">Feeling Happy</span></div>
<div style="position:absolute;left:104.88px;top:177.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:177.08px" class="cls_014"><span class="cls_014">Were people are encouraging you</span></div>
<div style="position:absolute;left:104.88px;top:189.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:189.08px" class="cls_014"><span class="cls_014">Healthy communication</span></div>
<div style="position:absolute;left:104.88px;top:201.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:201.08px" class="cls_014"><span class="cls_014">PIZZA - kai - food</span></div>
<div style="position:absolute;left:104.88px;top:213.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:213.08px" class="cls_014"><span class="cls_014">Young Māori out of violent homes - teachers need to talk to</span></div>
<div style="position:absolute;left:122.88px;top:225.08px" class="cls_014"><span class="cls_014">us not at us, emotional connection</span></div>
<div style="position:absolute;left:104.88px;top:237.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:237.08px" class="cls_014"><span class="cls_014">Family</span></div>
<div style="position:absolute;left:104.88px;top:249.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:249.08px" class="cls_014"><span class="cls_014">Looking after people</span></div>
<div style="position:absolute;left:104.88px;top:261.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:261.08px" class="cls_014"><span class="cls_014">Friends, relationships - healthy ones</span></div>
<div style="position:absolute;left:104.88px;top:273.08px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:273.08px" class="cls_014"><span class="cls_014">Good sports teams</span></div>
<div style="position:absolute;left:104.88px;top:285.08px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:285.08px" class="cls_015"><span class="cls_015">Good relationships</span></div>
<div style="position:absolute;left:104.88px;top:297.08px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:297.08px" class="cls_015"><span class="cls_015">Together as one</span></div>
<div style="position:absolute;left:104.88px;top:309.08px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:309.08px" class="cls_015"><span class="cls_015">Friendship</span></div>
<div style="position:absolute;left:87.60px;top:328.09px" class="cls_005"><span class="cls_005">2.</span></div>
<div style="position:absolute;left:123.60px;top:328.09px" class="cls_005"><span class="cls_005">What makes you want to participate?</span></div>
<div style="position:absolute;left:104.88px;top:347.09px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:347.09px" class="cls_014"><span class="cls_014">For the experience</span></div>
<div style="position:absolute;left:104.88px;top:359.09px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:359.09px" class="cls_014"><span class="cls_014">Travel</span></div>
<div style="position:absolute;left:104.88px;top:371.09px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:371.09px" class="cls_014"><span class="cls_014">If your friends say its cool</span></div>
<div style="position:absolute;left:104.88px;top:383.09px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:383.09px" class="cls_014"><span class="cls_014">People having fun</span></div>
<div style="position:absolute;left:104.88px;top:395.09px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:395.09px" class="cls_014"><span class="cls_014">Supporting others</span></div>
<div style="position:absolute;left:104.88px;top:407.09px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:407.09px" class="cls_015"><span class="cls_015">Fun x2</span></div>
<div style="position:absolute;left:104.88px;top:419.09px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:419.09px" class="cls_015"><span class="cls_015">Friends</span></div>
<div style="position:absolute;left:104.88px;top:431.09px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:431.09px" class="cls_015"><span class="cls_015">Trusted adults</span></div>
<div style="position:absolute;left:104.88px;top:443.09px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:443.09px" class="cls_015"><span class="cls_015">Wanting to help out</span></div>
<div style="position:absolute;left:123.60px;top:462.09px" class="cls_005"><span class="cls_005">We then asked what turns you off participating?</span></div>
<div style="position:absolute;left:104.88px;top:481.10px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:481.10px" class="cls_014"><span class="cls_014">Judgements</span></div>
<div style="position:absolute;left:104.88px;top:493.10px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:493.10px" class="cls_014"><span class="cls_014">Putdowns</span></div>
<div style="position:absolute;left:104.88px;top:505.10px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:505.10px" class="cls_014"><span class="cls_014">If it doesn’t look fun</span></div>
<div style="position:absolute;left:87.60px;top:524.10px" class="cls_005"><span class="cls_005">3.</span></div>
<div style="position:absolute;left:123.60px;top:524.10px" class="cls_005"><span class="cls_005">Is there anything the kaimahi can do to increase your participating?</span></div>
<div style="position:absolute;left:104.88px;top:543.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:543.11px" class="cls_014"><span class="cls_014">Other events that rangatahi would be interested in</span></div>
<div style="position:absolute;left:104.88px;top:555.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:555.11px" class="cls_014"><span class="cls_014">Not forcing us</span></div>
<div style="position:absolute;left:104.88px;top:567.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:567.11px" class="cls_014"><span class="cls_014">More out of school activities</span></div>
<div style="position:absolute;left:104.88px;top:579.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:579.11px" class="cls_014"><span class="cls_014">More youth gatherings</span></div>
<div style="position:absolute;left:104.88px;top:591.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:591.11px" class="cls_014"><span class="cls_014">Fortnite</span></div>
<div style="position:absolute;left:104.88px;top:603.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:603.11px" class="cls_014"><span class="cls_014">Encourage us</span></div>
<div style="position:absolute;left:104.88px;top:615.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:615.11px" class="cls_014"><span class="cls_014">Give extra support</span></div>
<div style="position:absolute;left:104.88px;top:627.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:627.11px" class="cls_014"><span class="cls_014">In large groups it’s hard to have your say (you have no say)</span></div>
<div style="position:absolute;left:123.60px;top:646.11px" class="cls_005"><span class="cls_005">At the end I asked was there anything else they wanted to say or add.</span></div>
<div style="position:absolute;left:104.88px;top:665.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:665.11px" class="cls_014"><span class="cls_014">Lower prices for uniforms</span></div>
<div style="position:absolute;left:104.88px;top:677.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:677.11px" class="cls_014"><span class="cls_014">Better basketball hoops</span></div>
<div style="position:absolute;left:104.88px;top:689.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:689.11px" class="cls_014"><span class="cls_014">More notices about the youth groups around.</span></div>
<div style="position:absolute;left:104.88px;top:701.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:701.11px" class="cls_014"><span class="cls_014">An open gym</span></div>
<div style="position:absolute;left:104.88px;top:713.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:713.11px" class="cls_014"><span class="cls_014">Bowling alley</span></div>
<div style="position:absolute;left:104.88px;top:725.11px" class="cls_014"><span class="cls_014">•</span></div>
<div style="position:absolute;left:122.88px;top:725.11px" class="cls_014"><span class="cls_014">Somewhere where they can go swimming every day.</span></div>
<div style="position:absolute;left:104.88px;top:737.11px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:737.11px" class="cls_015"><span class="cls_015">Are you going to offer extra support to kids in need?</span></div>
<div style="position:absolute;left:104.88px;top:749.11px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:749.11px" class="cls_015"><span class="cls_015">Suicide prevention</span></div>
<div style="position:absolute;left:104.88px;top:761.11px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:761.11px" class="cls_015"><span class="cls_015">Kids who need help with love</span></div>
<div style="position:absolute;left:104.88px;top:773.11px" class="cls_015"><span class="cls_015">•</span></div>
<div style="position:absolute;left:122.88px;top:773.11px" class="cls_015"><span class="cls_015">Alcohol and drug prevention… lots of our friends need this</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">21</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:20424px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background25.jpg" width=595 height=841></div>
<div style="position:absolute;left:68.03px;top:79.45px" class="cls_005"><span class="cls_005">A quick overview. I feeling that all the rangatahi want to feel connected and to participate</span></div>
<div style="position:absolute;left:68.03px;top:91.45px" class="cls_005"><span class="cls_005">and know what connected looks like but have the barriers of not knowing what is available</span></div>
<div style="position:absolute;left:68.03px;top:103.45px" class="cls_005"><span class="cls_005">or happening and feeling that the activities that are available cost too much for their</span></div>
<div style="position:absolute;left:68.03px;top:115.45px" class="cls_005"><span class="cls_005">family.</span></div>
<div style="position:absolute;left:68.03px;top:133.12px" class="cls_005"><span class="cls_005">Also many of the kids only get opportunities to join in at school and are nervous to fail</span></div>
<div style="position:absolute;left:68.03px;top:145.12px" class="cls_005"><span class="cls_005">in front of their friends or the whole school. But they want to be involved in all of it from</span></div>
<div style="position:absolute;left:68.03px;top:157.12px" class="cls_005"><span class="cls_005">choosing the activity to joining in. Smaller group activities ruther than big community or</span></div>
<div style="position:absolute;left:68.03px;top:169.12px" class="cls_005"><span class="cls_005">school activities where it safe to be themselves</span></div>
<div style="position:absolute;left:142.48px;top:208.41px" class="cls_011"><span class="cls_011">March - April 2019: Big Picture from the Small Groups collated</span></div>
<div style="position:absolute;left:156.99px;top:232.33px" class="cls_004"><span class="cls_004">“Rangatahi Maori feel connected and safe and participate</span></div>
<div style="position:absolute;left:254.42px;top:247.33px" class="cls_004"><span class="cls_004">as rangatahi Maori”</span></div>
<div style="position:absolute;left:229.00px;top:265.17px" class="cls_009"><span class="cls_009">Review & resurrect For our Kids</span></div>
<div style="position:absolute;left:92.32px;top:291.59px" class="cls_008"><span class="cls_008">11/04/19: Large Hui @ Racecourse, 50+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:93.47px;top:303.59px" class="cls_008"><span class="cls_008">young adults,representatives of community agencies, government agencies and</span></div>
<div style="position:absolute;left:127.03px;top:315.59px" class="cls_008"><span class="cls_008">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:100.69px;top:342.95px" class="cls_009"><span class="cls_009">We have not captured the collated work well at all. Needs another look, and bring all the</span></div>
<div style="position:absolute;left:158.31px;top:353.95px" class="cls_009"><span class="cls_009">rich koreroforward into a high level statement and key actions</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">22</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:21275px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background26.jpg" width=595 height=841></div>
<div style="position:absolute;left:96.68px;top:78.59px" class="cls_007"><span class="cls_007">10. </span><span class="cls_002">  Hinengaro</span></div>
<div style="position:absolute;left:95.85px;top:123.78px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.83px;top:135.78px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.44px;top:147.78px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:78.02px;top:177.34px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:68.03px;top:196.29px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:196.29px" class="cls_009"><span class="cls_009">There’s a lot of support / Whanau</span></div>
<div style="position:absolute;left:304.25px;top:196.29px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:196.29px" class="cls_009"><span class="cls_009">Services / Culture change</span></div>
<div style="position:absolute;left:68.03px;top:211.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:211.55px" class="cls_009"><span class="cls_009">Good access to internet</span></div>
<div style="position:absolute;left:304.25px;top:211.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:211.55px" class="cls_009"><span class="cls_009">Artist community</span></div>
<div style="position:absolute;left:68.03px;top:226.80px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:226.80px" class="cls_009"><span class="cls_009">There’s a lot of help / YST / Toiha /Man-Up</span></div>
<div style="position:absolute;left:304.25px;top:226.80px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:226.80px" class="cls_009"><span class="cls_009">Marae / Hapu / iwi initiatives</span></div>
<div style="position:absolute;left:68.03px;top:242.05px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:242.05px" class="cls_009"><span class="cls_009">Courses</span></div>
<div style="position:absolute;left:304.25px;top:242.05px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:242.05px" class="cls_009"><span class="cls_009">Church communities</span></div>
<div style="position:absolute;left:68.03px;top:257.30px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:257.30px" class="cls_009"><span class="cls_009">Environment / Awa / Gardens / Beach</span></div>
<div style="position:absolute;left:78.02px;top:275.31px" class="cls_004"><span class="cls_004">What are our challenges:</span></div>
<div style="position:absolute;left:68.03px;top:294.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:294.26px" class="cls_009"><span class="cls_009">Mental awareness based on age suitability /</span></div>
<div style="position:absolute;left:304.25px;top:294.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:294.26px" class="cls_009"><span class="cls_009">Huge long waiting list for safe n free /</span></div>
<div style="position:absolute;left:78.03px;top:305.26px" class="cls_009"><span class="cls_009">access stigma awareness program in schools</span></div>
<div style="position:absolute;left:314.25px;top:305.26px" class="cls_009"><span class="cls_009">phycologists, have to jump through lots of</span></div>
<div style="position:absolute;left:314.25px;top:316.26px" class="cls_009"><span class="cls_009">hoops to access HELP</span></div>
<div style="position:absolute;left:68.03px;top:320.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:320.51px" class="cls_009"><span class="cls_009">Tenant trauma / mental health increasing /</span></div>
<div style="position:absolute;left:78.03px;top:331.51px" class="cls_009"><span class="cls_009">Deprived / More understanding</span></div>
<div style="position:absolute;left:304.25px;top:331.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:331.51px" class="cls_009"><span class="cls_009">Destigmatize change culture around the kupu</span></div>
<div style="position:absolute;left:314.25px;top:342.51px" class="cls_009"><span class="cls_009">Mental Health</span></div>
<div style="position:absolute;left:68.03px;top:346.76px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:346.76px" class="cls_009"><span class="cls_009">Lack of communication</span></div>
<div style="position:absolute;left:68.03px;top:362.02px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:362.02px" class="cls_009"><span class="cls_009">Wins only funds 20 sessions of counselling that</span></div>
<div style="position:absolute;left:78.03px;top:373.02px" class="cls_009"><span class="cls_009">only scratches the surface you can only apply</span></div>
<div style="position:absolute;left:78.03px;top:384.02px" class="cls_009"><span class="cls_009">for 10 more</span></div>
<div style="position:absolute;left:78.02px;top:402.02px" class="cls_004"><span class="cls_004">What are our opportunities:</span></div>
<div style="position:absolute;left:68.03px;top:420.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:420.97px" class="cls_009"><span class="cls_009">Care model and medical model</span></div>
<div style="position:absolute;left:304.25px;top:420.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:420.97px" class="cls_009"><span class="cls_009">Art community</span></div>
<div style="position:absolute;left:68.03px;top:436.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:436.23px" class="cls_009"><span class="cls_009">More community support when suicide occurs</span></div>
<div style="position:absolute;left:304.25px;top:436.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:436.23px" class="cls_009"><span class="cls_009">Supporting offender out of prison</span></div>
<div style="position:absolute;left:78.03px;top:447.23px" class="cls_009"><span class="cls_009">e.g. In schools</span></div>
<div style="position:absolute;left:304.25px;top:451.48px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:451.48px" class="cls_009"><span class="cls_009">Networking</span></div>
<div style="position:absolute;left:68.03px;top:462.48px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:462.48px" class="cls_009"><span class="cls_009">Align the youth age across all services</span></div>
<div style="position:absolute;left:304.25px;top:466.73px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:466.73px" class="cls_009"><span class="cls_009">Include those from other hapu, iwi in Tira</span></div>
<div style="position:absolute;left:68.03px;top:477.73px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:477.73px" class="cls_009"><span class="cls_009">Conference where Mental Health is brought</span></div>
<div style="position:absolute;left:314.25px;top:477.73px" class="cls_009"><span class="cls_009">Hoe waka etc.</span></div>
<div style="position:absolute;left:78.03px;top:488.73px" class="cls_009"><span class="cls_009">across all sectors to educate on mental health</span></div>
<div style="position:absolute;left:304.25px;top:492.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:492.98px" class="cls_009"><span class="cls_009">More education around what is or how you</span></div>
<div style="position:absolute;left:78.03px;top:499.73px" class="cls_009"><span class="cls_009">/combined commitment / Kawarau model /</span></div>
<div style="position:absolute;left:314.25px;top:503.98px" class="cls_009"><span class="cls_009">perceive mental health / sharing ideas on</span></div>
<div style="position:absolute;left:78.03px;top:510.73px" class="cls_009"><span class="cls_009">Canterbury conference</span></div>
<div style="position:absolute;left:314.25px;top:514.98px" class="cls_009"><span class="cls_009">keeping well</span></div>
<div style="position:absolute;left:68.03px;top:525.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:525.98px" class="cls_009"><span class="cls_009">Graded assessment and access to health</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">23</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:22126px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background27.jpg" width=595 height=841></div>
<div style="position:absolute;left:84.07px;top:88.28px" class="cls_008"><span class="cls_008">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:89.66px;top:100.28px" class="cls_008"><span class="cls_008">young adults, representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:117.01px;top:112.28px" class="cls_008"><span class="cls_008">and schools. Invitations send viaemail and open invitation via facebook</span></div>
<div style="position:absolute;left:77.35px;top:142.95px" class="cls_004"><span class="cls_004">Strengths - Themes</span></div>
<div style="position:absolute;left:312.68px;top:142.95px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:312.68px;top:155.95px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:68.03px;top:166.44px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:166.44px" class="cls_009"><span class="cls_009">Community Support</span></div>
<div style="position:absolute;left:68.03px;top:181.69px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:181.69px" class="cls_009"><span class="cls_009">Connection</span></div>
<div style="position:absolute;left:304.25px;top:179.74px" class="cls_009"><span class="cls_009">• Lift the roof</span></div>
<div style="position:absolute;left:68.03px;top:196.94px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:196.94px" class="cls_009"><span class="cls_009">Rangatahi Support network</span></div>
<div style="position:absolute;left:304.25px;top:194.99px" class="cls_009"><span class="cls_009">• Explore ways to connect Rangatahi</span></div>
<div style="position:absolute;left:68.03px;top:212.19px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:212.19px" class="cls_009"><span class="cls_009">Sport & Physical activity</span></div>
<div style="position:absolute;left:304.25px;top:210.24px" class="cls_009"><span class="cls_009">• See info from Rangatahi</span></div>
<div style="position:absolute;left:68.03px;top:227.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:227.45px" class="cls_009"><span class="cls_009">Connection and belong</span></div>
<div style="position:absolute;left:304.25px;top:225.49px" class="cls_009"><span class="cls_009">• Safe Rangatahi spaces</span></div>
<div style="position:absolute;left:304.25px;top:240.74px" class="cls_009"><span class="cls_009">• Safe people they can relate to , Link them into</span></div>
<div style="position:absolute;left:77.99px;top:248.28px" class="cls_004"><span class="cls_004">Challenges</span></div>
<div style="position:absolute;left:314.25px;top:251.74px" class="cls_009"><span class="cls_009">what they need</span></div>
<div style="position:absolute;left:304.25px;top:267.00px" class="cls_009"><span class="cls_009">• Getting back to basics, Listen, Value, Support</span></div>
<div style="position:absolute;left:68.03px;top:270.07px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:270.07px" class="cls_009"><span class="cls_009">Not everybody has connection</span></div>
<div style="position:absolute;left:78.03px;top:281.07px" class="cls_009"><span class="cls_009">( Positive & Cultural )</span></div>
<div style="position:absolute;left:304.25px;top:282.25px" class="cls_009"><span class="cls_009">• How to better engage with schools and</span></div>
<div style="position:absolute;left:314.25px;top:293.25px" class="cls_009"><span class="cls_009">Rangatahi where they are at through “Safe”</span></div>
<div style="position:absolute;left:68.03px;top:296.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:296.33px" class="cls_009"><span class="cls_009">Not enough support for Rangatahi</span></div>
<div style="position:absolute;left:314.25px;top:304.25px" class="cls_009"><span class="cls_009">adults in those spaces</span></div>
<div style="position:absolute;left:78.03px;top:307.33px" class="cls_009"><span class="cls_009">& their whanau</span></div>
<div style="position:absolute;left:304.25px;top:319.50px" class="cls_009"><span class="cls_009">• Rangatahi teaching adults, Empathy</span></div>
<div style="position:absolute;left:68.03px;top:322.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:322.58px" class="cls_009"><span class="cls_009">Lack of knowledge of what’s out there</span></div>
<div style="position:absolute;left:314.25px;top:330.50px" class="cls_009"><span class="cls_009">& Understanding</span></div>
<div style="position:absolute;left:68.03px;top:337.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:337.83px" class="cls_009"><span class="cls_009">Lack of resources</span></div>
<div style="position:absolute;left:68.03px;top:353.08px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:353.08px" class="cls_009"><span class="cls_009">Too many criteria’s</span></div>
<div style="position:absolute;left:115.05px;top:382.17px" class="cls_011"><span class="cls_011">Oct 18 - Feb 2019: Theme Focus Hui including anyone who opted into this</span></div>
<div style="position:absolute;left:226.26px;top:393.17px" class="cls_011"><span class="cls_011">particular discussion group.</span></div>
<div style="position:absolute;left:167.95px;top:424.18px" class="cls_009"><span class="cls_009">A small group met, there don’t appear to be any notes.</span></div>
<div style="position:absolute;left:168.88px;top:453.27px" class="cls_011"><span class="cls_011">March - April 2019: Big Picture Statements from the</span></div>
<div style="position:absolute;left:241.55px;top:464.27px" class="cls_011"><span class="cls_011">Small Groups collated</span></div>
<div style="position:absolute;left:131.01px;top:495.34px" class="cls_004"><span class="cls_004">“Rangatahi Maori have a voice, have access to support and have</span></div>
<div style="position:absolute;left:208.06px;top:510.34px" class="cls_004"><span class="cls_004">outlets for expressing themselves”</span></div>
<div style="position:absolute;left:92.73px;top:540.42px" class="cls_011"><span class="cls_011">11/04/19: Large Hui @ Racecourse, 50+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:92.20px;top:551.42px" class="cls_011"><span class="cls_011">young adults, representatives of community agencies, government agencies and</span></div>
<div style="position:absolute;left:127.52px;top:562.42px" class="cls_011"><span class="cls_011">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:199.90px;top:595.62px" class="cls_009"><span class="cls_009">No added notes. This needs more attention.</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">24</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:22977px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background28.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.13px" class="cls_002"><span class="cls_002">Whakapapa Whanau</span></div>
<div style="position:absolute;left:96.68px;top:78.59px" class="cls_007"><span class="cls_007">11.</span></div>
<div style="position:absolute;left:95.85px;top:123.78px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.83px;top:135.78px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.44px;top:147.78px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:78.02px;top:177.82px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:68.03px;top:199.61px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:199.61px" class="cls_009"><span class="cls_009">Kowhai park</span></div>
<div style="position:absolute;left:304.25px;top:199.61px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:199.61px" class="cls_009"><span class="cls_009">Aspirations</span></div>
<div style="position:absolute;left:68.03px;top:214.86px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:214.86px" class="cls_009"><span class="cls_009">Awa Sports / Kohanga / Kura/ Awa Kings</span></div>
<div style="position:absolute;left:304.25px;top:214.86px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:214.86px" class="cls_009"><span class="cls_009">Happiness</span></div>
<div style="position:absolute;left:78.03px;top:225.86px" class="cls_009"><span class="cls_009">Values / Kowhai park</span></div>
<div style="position:absolute;left:304.25px;top:230.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:230.11px" class="cls_009"><span class="cls_009">Matauranga (Education)</span></div>
<div style="position:absolute;left:68.03px;top:241.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:241.11px" class="cls_009"><span class="cls_009">Korero / whakapapa / manaaki / connections</span></div>
<div style="position:absolute;left:304.25px;top:245.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:245.36px" class="cls_009"><span class="cls_009">Karakia / Growth / Respect</span></div>
<div style="position:absolute;left:78.03px;top:252.11px" class="cls_009"><span class="cls_009">/ whanaungatanga</span></div>
<div style="position:absolute;left:304.25px;top:260.62px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:260.62px" class="cls_009"><span class="cls_009">Tradition</span></div>
<div style="position:absolute;left:78.02px;top:272.95px" class="cls_004"><span class="cls_004">What are our challenges:</span></div>
<div style="position:absolute;left:68.03px;top:294.74px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:294.74px" class="cls_009"><span class="cls_009">Step up “ takes a village to raise a child</span></div>
<div style="position:absolute;left:304.25px;top:294.34px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:294.34px" class="cls_009"><span class="cls_009">Navigating to get the right service</span></div>
<div style="position:absolute;left:68.03px;top:309.99px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:309.99px" class="cls_009"><span class="cls_009">Addiction / Nurturing role models</span></div>
<div style="position:absolute;left:304.25px;top:309.59px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:309.59px" class="cls_009"><span class="cls_009">Gangs as whanau / What do rangatahi</span></div>
<div style="position:absolute;left:314.25px;top:320.59px" class="cls_009"><span class="cls_009">consider whanau</span></div>
<div style="position:absolute;left:68.03px;top:325.24px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:325.24px" class="cls_009"><span class="cls_009">Depression / Trauma</span></div>
<div style="position:absolute;left:304.25px;top:335.84px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:335.84px" class="cls_009"><span class="cls_009">Rangatahi falling through the gaps / only help</span></div>
<div style="position:absolute;left:68.03px;top:340.49px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:340.49px" class="cls_009"><span class="cls_009">Back yard playing with kids</span></div>
<div style="position:absolute;left:314.25px;top:346.84px" class="cls_009"><span class="cls_009">for the really bad ones</span></div>
<div style="position:absolute;left:68.03px;top:355.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:355.75px" class="cls_009"><span class="cls_009">Device management</span></div>
<div style="position:absolute;left:304.25px;top:362.09px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:362.09px" class="cls_009"><span class="cls_009">Having rangatahi apart of the exercise /</span></div>
<div style="position:absolute;left:68.03px;top:371.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:371.00px" class="cls_009"><span class="cls_009">Disconnection from where you came from</span></div>
<div style="position:absolute;left:314.25px;top:373.09px" class="cls_009"><span class="cls_009">participationHuge long waiting list for safe n</span></div>
<div style="position:absolute;left:68.03px;top:386.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:386.25px" class="cls_009"><span class="cls_009">Gates and fences</span></div>
<div style="position:absolute;left:314.25px;top:384.09px" class="cls_009"><span class="cls_009">free / phycologists, have to jump through lots</span></div>
<div style="position:absolute;left:314.25px;top:395.09px" class="cls_009"><span class="cls_009">of hoops to access HELP</span></div>
<div style="position:absolute;left:68.03px;top:401.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:401.50px" class="cls_009"><span class="cls_009">Disconnection / Identity</span></div>
<div style="position:absolute;left:304.25px;top:410.34px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:410.34px" class="cls_009"><span class="cls_009">Destigmatize change culture around the kupu</span></div>
<div style="position:absolute;left:68.03px;top:416.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:416.75px" class="cls_009"><span class="cls_009">Visibility for support</span></div>
<div style="position:absolute;left:314.25px;top:421.34px" class="cls_009"><span class="cls_009">Mental Health</span></div>
<div style="position:absolute;left:78.02px;top:437.59px" class="cls_004"><span class="cls_004">What are our opportunities:</span></div>
<div style="position:absolute;left:68.03px;top:459.38px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:459.38px" class="cls_009"><span class="cls_009">More marae activity’s</span></div>
<div style="position:absolute;left:304.25px;top:459.38px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:459.38px" class="cls_009"><span class="cls_009">Barriers to conversation</span></div>
<div style="position:absolute;left:68.03px;top:474.63px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:474.63px" class="cls_009"><span class="cls_009">Hapu development</span></div>
<div style="position:absolute;left:304.25px;top:474.63px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:474.63px" class="cls_009"><span class="cls_009">What stops rangatahi from speaking out</span></div>
<div style="position:absolute;left:68.03px;top:489.88px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:489.88px" class="cls_009"><span class="cls_009">Social media</span></div>
<div style="position:absolute;left:304.25px;top:489.88px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:489.88px" class="cls_009"><span class="cls_009">Safe places to talk around not to be judges</span></div>
<div style="position:absolute;left:68.03px;top:505.14px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:505.14px" class="cls_009"><span class="cls_009">Wananga (TWOA)</span></div>
<div style="position:absolute;left:304.25px;top:505.14px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:505.14px" class="cls_009"><span class="cls_009">Employment / Second chances</span></div>
<div style="position:absolute;left:68.03px;top:520.39px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:520.39px" class="cls_009"><span class="cls_009">Language development (Te Ara Reo)</span></div>
<div style="position:absolute;left:304.25px;top:520.39px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:520.39px" class="cls_009"><span class="cls_009">Need more role models</span></div>
<div style="position:absolute;left:68.03px;top:535.64px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:535.64px" class="cls_009"><span class="cls_009">Whanau taking ownership of the past</span></div>
<div style="position:absolute;left:304.25px;top:535.64px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:535.64px" class="cls_009"><span class="cls_009">Time to give our Rangatahi</span></div>
<div style="position:absolute;left:68.03px;top:550.89px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:550.89px" class="cls_009"><span class="cls_009">Rangatahi culture</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">25</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:23828px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background29.jpg" width=595 height=841></div>
<div style="position:absolute;left:262.37px;top:87.07px" class="cls_011"><span class="cls_011">Out of the box</span></div>
<div style="position:absolute;left:104.88px;top:116.29px" class="cls_005"><span class="cls_005">Page 1 (Pages were not labelled)</span></div>
<div style="position:absolute;left:104.88px;top:138.08px" class="cls_009"><span class="cls_009">• Unity and community</span></div>
<div style="position:absolute;left:104.88px;top:153.33px" class="cls_009"><span class="cls_009">• Mental well-being</span></div>
<div style="position:absolute;left:104.88px;top:168.58px" class="cls_009"><span class="cls_009">• Funding A community to support out of the box learning</span></div>
<div style="position:absolute;left:114.88px;top:179.58px" class="cls_009"><span class="cls_009">opportunities / Identity needs</span></div>
<div style="position:absolute;left:104.88px;top:194.84px" class="cls_009"><span class="cls_009">• Use our natural environment / Awa / present logistic</span></div>
<div style="position:absolute;left:104.88px;top:210.09px" class="cls_009"><span class="cls_009">• Let them be kids / Create spaces</span></div>
<div style="position:absolute;left:104.88px;top:225.34px" class="cls_009"><span class="cls_009">• International student exchange programs</span></div>
<div style="position:absolute;left:104.88px;top:240.59px" class="cls_009"><span class="cls_009">• Transform rather than reform of educational system</span></div>
<div style="position:absolute;left:104.88px;top:255.84px" class="cls_009"><span class="cls_009">• Creativity at centers enhanced / Too structured rather than fluid</span></div>
<div style="position:absolute;left:114.88px;top:266.84px" class="cls_009"><span class="cls_009">/ take into account learning styles</span></div>
<div style="position:absolute;left:104.88px;top:282.10px" class="cls_009"><span class="cls_009">• Retail work experience opportunities</span></div>
<div style="position:absolute;left:104.88px;top:297.35px" class="cls_009"><span class="cls_009">• Unity and community</span></div>
<div style="position:absolute;left:104.88px;top:318.19px" class="cls_005"><span class="cls_005">Page 2</span></div>
<div style="position:absolute;left:104.88px;top:339.97px" class="cls_009"><span class="cls_009">• Should we be starting younger?</span></div>
<div style="position:absolute;left:104.88px;top:355.23px" class="cls_009"><span class="cls_009">• Gang involvement in discussion within youth justice system</span></div>
<div style="position:absolute;left:104.88px;top:370.48px" class="cls_009"><span class="cls_009">• Inclusive transition age groups</span></div>
<div style="position:absolute;left:104.88px;top:385.73px" class="cls_009"><span class="cls_009">• Youth participating in decision making / introduce trajectory strategies policy</span></div>
<div style="position:absolute;left:104.88px;top:400.98px" class="cls_009"><span class="cls_009">• Financial support for sports interest</span></div>
<div style="position:absolute;left:104.88px;top:416.23px" class="cls_009"><span class="cls_009">• Engage whanau to support rangatahi</span></div>
<div style="position:absolute;left:104.88px;top:431.49px" class="cls_009"><span class="cls_009">• Friendly environment/ civics processes</span></div>
<div style="position:absolute;left:104.88px;top:446.74px" class="cls_009"><span class="cls_009">• Youth voice / what they want</span></div>
<div style="position:absolute;left:104.88px;top:461.99px" class="cls_009"><span class="cls_009">• How survey through youth organization’s</span></div>
<div style="position:absolute;left:104.88px;top:482.83px" class="cls_005"><span class="cls_005">Page 3</span></div>
<div style="position:absolute;left:104.88px;top:504.62px" class="cls_009"><span class="cls_009">• Youth collective / service providers / Old former buildings</span></div>
<div style="position:absolute;left:104.88px;top:519.87px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:114.88px;top:519.87px" class="cls_009"><span class="cls_009">“I have a dream” Northland.</span></div>
<div style="position:absolute;left:104.88px;top:535.12px" class="cls_009"><span class="cls_009">• Big Brother</span></div>
<div style="position:absolute;left:104.88px;top:550.37px" class="cls_009"><span class="cls_009">• Mentors / whanau scouts etc.</span></div>
<div style="position:absolute;left:104.88px;top:565.62px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:114.88px;top:565.62px" class="cls_009"><span class="cls_009">“ For our kids “</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">26</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:24679px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background30.jpg" width=595 height=841></div>
<div style="position:absolute;left:84.07px;top:87.20px" class="cls_008"><span class="cls_008">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:78.33px;top:99.20px" class="cls_008"><span class="cls_008">young adults, representatives of churches and agencies and community agencies and</span></div>
<div style="position:absolute;left:127.03px;top:111.20px" class="cls_008"><span class="cls_008">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:77.35px;top:141.25px" class="cls_004"><span class="cls_004">Strengths - Themes</span></div>
<div style="position:absolute;left:312.68px;top:141.25px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:312.68px;top:154.25px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:68.03px;top:161.88px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:161.88px" class="cls_009"><span class="cls_009">Sports opportunities</span></div>
<div style="position:absolute;left:68.03px;top:177.13px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:177.13px" class="cls_009"><span class="cls_009">Support services</span></div>
<div style="position:absolute;left:304.25px;top:178.04px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:178.04px" class="cls_009"><span class="cls_009">Safe environment</span></div>
<div style="position:absolute;left:68.03px;top:192.38px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:192.38px" class="cls_009"><span class="cls_009">Rangatahi</span></div>
<div style="position:absolute;left:304.25px;top:193.29px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:193.29px" class="cls_009"><span class="cls_009">Feel loved and connected</span></div>
<div style="position:absolute;left:68.03px;top:207.63px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:207.63px" class="cls_009"><span class="cls_009">Community</span></div>
<div style="position:absolute;left:304.25px;top:208.54px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:208.54px" class="cls_009"><span class="cls_009">Rangatahi achieving</span></div>
<div style="position:absolute;left:68.03px;top:222.88px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:222.88px" class="cls_009"><span class="cls_009">Social Media ,Keeping connected, Positive &</span></div>
<div style="position:absolute;left:304.25px;top:223.79px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:223.79px" class="cls_009"><span class="cls_009">No Silo’s</span></div>
<div style="position:absolute;left:78.03px;top:233.88px" class="cls_009"><span class="cls_009">Negative affects</span></div>
<div style="position:absolute;left:304.25px;top:239.04px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:239.04px" class="cls_009"><span class="cls_009">No age limits</span></div>
<div style="position:absolute;left:77.99px;top:254.72px" class="cls_004"><span class="cls_004">Challenges</span></div>
<div style="position:absolute;left:304.25px;top:254.30px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:254.30px" class="cls_009"><span class="cls_009">Rangatahi Voice & their aspirations (Not</span></div>
<div style="position:absolute;left:314.25px;top:265.30px" class="cls_009"><span class="cls_009">parents)</span></div>
<div style="position:absolute;left:68.03px;top:276.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:276.51px" class="cls_009"><span class="cls_009">Negative influences</span></div>
<div style="position:absolute;left:304.25px;top:280.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:280.55px" class="cls_009"><span class="cls_009">No criteria to achieve or fit in a box</span></div>
<div style="position:absolute;left:68.03px;top:291.76px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:291.76px" class="cls_009"><span class="cls_009">Colonisation</span></div>
<div style="position:absolute;left:304.25px;top:295.80px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:295.80px" class="cls_009"><span class="cls_009">Networking</span></div>
<div style="position:absolute;left:68.03px;top:307.01px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:307.01px" class="cls_009"><span class="cls_009">Whanau past experiences</span></div>
<div style="position:absolute;left:304.25px;top:311.05px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:311.05px" class="cls_009"><span class="cls_009">Life goal coaching in schools</span></div>
<div style="position:absolute;left:68.03px;top:322.27px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:322.27px" class="cls_009"><span class="cls_009">Community segregation</span></div>
<div style="position:absolute;left:304.25px;top:326.30px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:326.30px" class="cls_009"><span class="cls_009">Mixed courses</span></div>
<div style="position:absolute;left:68.03px;top:337.52px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:337.52px" class="cls_009"><span class="cls_009">Stereotyping</span></div>
<div style="position:absolute;left:304.25px;top:341.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:341.55px" class="cls_009"><span class="cls_009">More appreciative</span></div>
<div style="position:absolute;left:68.03px;top:352.77px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:352.77px" class="cls_009"><span class="cls_009">Social media , Negative</span></div>
<div style="position:absolute;left:304.25px;top:356.81px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:356.81px" class="cls_009"><span class="cls_009">Community events , Sports days, Games to</span></div>
<div style="position:absolute;left:314.25px;top:367.81px" class="cls_009"><span class="cls_009">connect with whanau</span></div>
<div style="position:absolute;left:77.99px;top:373.61px" class="cls_004"><span class="cls_004">Opportunities</span></div>
<div style="position:absolute;left:312.68px;top:388.65px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:68.03px;top:395.40px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:395.40px" class="cls_009"><span class="cls_009">Cultural knowledge & connection</span></div>
<div style="position:absolute;left:312.68px;top:401.65px" class="cls_004"><span class="cls_004">we do less of?</span></div>
<div style="position:absolute;left:68.03px;top:410.65px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:410.65px" class="cls_009"><span class="cls_009">Participation</span></div>
<div style="position:absolute;left:68.03px;top:425.90px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:425.90px" class="cls_009"><span class="cls_009">Education</span></div>
<div style="position:absolute;left:304.25px;top:425.43px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:425.43px" class="cls_009"><span class="cls_009">Saying No, more of let’s look at options</span></div>
<div style="position:absolute;left:68.03px;top:441.15px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:441.15px" class="cls_009"><span class="cls_009">Safety</span></div>
<div style="position:absolute;left:68.03px;top:456.40px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:456.40px" class="cls_009"><span class="cls_009">Growth & Community opportunities</span></div>
<div style="position:absolute;left:115.05px;top:485.49px" class="cls_011"><span class="cls_011">Oct 18 - Feb 2019: Theme Focus Hui including anyone who opted into this</span></div>
<div style="position:absolute;left:226.26px;top:496.49px" class="cls_011"><span class="cls_011">particular discussion group.</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">27</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:25530px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background31.jpg" width=595 height=841></div>
<div style="position:absolute;left:115.05px;top:87.70px" class="cls_011"><span class="cls_011">Oct 18 - Feb 2019: Theme Focus Hui including anyone who opted into this</span></div>
<div style="position:absolute;left:226.26px;top:98.70px" class="cls_011"><span class="cls_011">particular discussion group.</span></div>
<div style="position:absolute;left:85.75px;top:129.77px" class="cls_004"><span class="cls_004">Vision:</span></div>
<div style="position:absolute;left:321.97px;top:133.56px" class="cls_004"><span class="cls_004">Mission Statement:</span></div>
<div style="position:absolute;left:85.75px;top:144.40px" class="cls_009"><span class="cls_009">Rangatahi have the knowledge and</span></div>
<div style="position:absolute;left:321.97px;top:148.19px" class="cls_009"><span class="cls_009">To support rangatahi and whānau to learn</span></div>
<div style="position:absolute;left:85.75px;top:155.20px" class="cls_009"><span class="cls_009">understanding of the Māori world view</span></div>
<div style="position:absolute;left:321.97px;top:158.99px" class="cls_009"><span class="cls_009">about their whakapapa and enhance their</span></div>
<div style="position:absolute;left:85.75px;top:166.00px" class="cls_009"><span class="cls_009">and actively transmitting to whānau</span></div>
<div style="position:absolute;left:321.97px;top:169.79px" class="cls_009"><span class="cls_009">knowledge and understanding of “Te aronga</span></div>
<div style="position:absolute;left:85.75px;top:176.80px" class="cls_009"><span class="cls_009">and extended whānau.</span></div>
<div style="position:absolute;left:321.97px;top:180.59px" class="cls_009"><span class="cls_009">māori” (Māori world view)</span></div>
<div style="position:absolute;left:86.03px;top:197.64px" class="cls_004"><span class="cls_004">Goals:</span></div>
<div style="position:absolute;left:86.03px;top:215.48px" class="cls_004"><span class="cls_004">Wānanga:</span></div>
<div style="position:absolute;left:68.03px;top:230.31px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:230.31px" class="cls_009"><span class="cls_009">Current programmes/education with a</span></div>
<div style="position:absolute;left:304.25px;top:231.45px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:231.45px" class="cls_009"><span class="cls_009">Celebrating Rangatahi Success</span></div>
<div style="position:absolute;left:86.03px;top:241.31px" class="cls_009"><span class="cls_009">Mātauranga Māori flavour integrated across</span></div>
<div style="position:absolute;left:304.25px;top:246.70px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:246.70px" class="cls_009"><span class="cls_009">Mātauranga Māori:</span></div>
<div style="position:absolute;left:86.03px;top:252.31px" class="cls_009"><span class="cls_009">the broad, RISE: Atua Māori, Te Ihu Waka,</span></div>
<div style="position:absolute;left:86.03px;top:263.31px" class="cls_009"><span class="cls_009">Whakapapa and Decolonisation (Probation),</span></div>
<div style="position:absolute;left:304.25px;top:261.95px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:261.95px" class="cls_009"><span class="cls_009">To ensure the appropriate people are</span></div>
<div style="position:absolute;left:86.03px;top:274.31px" class="cls_009"><span class="cls_009">Tikanga Ririki, Jigsaw Whanganui Parenting</span></div>
<div style="position:absolute;left:322.25px;top:272.95px" class="cls_009"><span class="cls_009">associated to the learning aspects. Being in a</span></div>
<div style="position:absolute;left:86.03px;top:285.31px" class="cls_009"><span class="cls_009">(Community Based and Prison Based),</span></div>
<div style="position:absolute;left:322.25px;top:283.95px" class="cls_009"><span class="cls_009">position to view from a Māori Lens (Te Aronga</span></div>
<div style="position:absolute;left:86.03px;top:296.31px" class="cls_009"><span class="cls_009">Whānui Māori Focussed Unit Kaupapa Māori</span></div>
<div style="position:absolute;left:322.25px;top:294.95px" class="cls_009"><span class="cls_009">Māori, A Māori Worldview) all the time, not</span></div>
<div style="position:absolute;left:86.03px;top:307.31px" class="cls_009"><span class="cls_009">education,</span></div>
<div style="position:absolute;left:322.25px;top:305.95px" class="cls_009"><span class="cls_009">just sometimes)</span></div>
<div style="position:absolute;left:68.03px;top:322.56px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:322.56px" class="cls_009"><span class="cls_009">Hākinakina (Sports & recreation) WMMA,</span></div>
<div style="position:absolute;left:304.25px;top:321.20px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:321.20px" class="cls_009"><span class="cls_009">Tira Hoe Waka, Pakaitore Day</span></div>
<div style="position:absolute;left:86.03px;top:333.56px" class="cls_009"><span class="cls_009">Basketball, Netball,</span></div>
<div style="position:absolute;left:304.25px;top:336.46px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:336.46px" class="cls_009"><span class="cls_009">Other Iwi significant event</span></div>
<div style="position:absolute;left:68.03px;top:348.81px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:348.81px" class="cls_009"><span class="cls_009">Taonga tuku iho</span></div>
<div style="position:absolute;left:304.25px;top:355.71px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:355.71px" class="cls_009"><span class="cls_009">Significant Māori Events (Waitangi Day,)</span></div>
<div style="position:absolute;left:68.03px;top:364.07px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:364.07px" class="cls_009"><span class="cls_009">Whakapapa & Te Reo</span></div>
<div style="position:absolute;left:323.25px;top:373.96px" class="cls_004"><span class="cls_004">Taonga Tuku iho:</span></div>
<div style="position:absolute;left:68.03px;top:379.32px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:379.32px" class="cls_009"><span class="cls_009">Tikanga Ririki (Parenting)</span></div>
<div style="position:absolute;left:304.25px;top:388.79px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:388.79px" class="cls_009"><span class="cls_009">Educate our rangatahi about our traditional</span></div>
<div style="position:absolute;left:68.03px;top:394.57px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:394.57px" class="cls_009"><span class="cls_009">Māori Design and Art (Traditional &</span></div>
<div style="position:absolute;left:322.25px;top:399.79px" class="cls_009"><span class="cls_009">knowledge/history/kōrero/ātua. To promote</span></div>
<div style="position:absolute;left:86.03px;top:405.57px" class="cls_009"><span class="cls_009">Contemporary)</span></div>
<div style="position:absolute;left:322.25px;top:410.79px" class="cls_009"><span class="cls_009">our mātauranga, making it visible within the</span></div>
<div style="position:absolute;left:68.03px;top:420.82px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:420.82px" class="cls_009"><span class="cls_009">Social Media/ Short Films/Feature Films</span></div>
<div style="position:absolute;left:322.25px;top:421.79px" class="cls_009"><span class="cls_009">community, through arts, and/or other visual</span></div>
<div style="position:absolute;left:322.25px;top:432.79px" class="cls_009"><span class="cls_009">forms.</span></div>
<div style="position:absolute;left:68.03px;top:436.07px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:436.07px" class="cls_009"><span class="cls_009">Te Ara Tika (Addictions)</span></div>
<div style="position:absolute;left:304.25px;top:448.05px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:448.05px" class="cls_009"><span class="cls_009">Atua Māori</span></div>
<div style="position:absolute;left:68.03px;top:451.33px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:451.33px" class="cls_009"><span class="cls_009">Te Ihu Waka (Whakapapa & Decolonisation)</span></div>
<div style="position:absolute;left:304.25px;top:463.30px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:463.30px" class="cls_009"><span class="cls_009">Te Orokohanga (Creation)</span></div>
<div style="position:absolute;left:68.03px;top:466.58px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:466.58px" class="cls_009"><span class="cls_009">Rise (Atua Māori)</span></div>
<div style="position:absolute;left:304.25px;top:478.55px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:478.55px" class="cls_009"><span class="cls_009">Tikanga and Kawa</span></div>
<div style="position:absolute;left:68.03px;top:481.83px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:481.83px" class="cls_009"><span class="cls_009">Whānui Māori Focus Unit (Mita Davis)</span></div>
<div style="position:absolute;left:304.25px;top:493.80px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:493.80px" class="cls_009"><span class="cls_009">Marae Experiences</span></div>
<div style="position:absolute;left:68.03px;top:497.08px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:497.08px" class="cls_009"><span class="cls_009">Oranga Whānau (Potential) Integration of</span></div>
<div style="position:absolute;left:86.03px;top:508.08px" class="cls_009"><span class="cls_009">knowledge to create a specific programme</span></div>
<div style="position:absolute;left:323.25px;top:512.05px" class="cls_004"><span class="cls_004">Objectives:</span></div>
<div style="position:absolute;left:86.03px;top:519.08px" class="cls_009"><span class="cls_009">for ALL Rangatahi and whānau, drawn from</span></div>
<div style="position:absolute;left:86.03px;top:530.08px" class="cls_009"><span class="cls_009">Whānau Pūrakau</span></div>
<div style="position:absolute;left:322.25px;top:529.89px" class="cls_004"><span class="cls_004">Resources:</span></div>
<div style="position:absolute;left:304.25px;top:544.72px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:544.72px" class="cls_009"><span class="cls_009">Human Resources:</span></div>
<div style="position:absolute;left:86.03px;top:548.33px" class="cls_004"><span class="cls_004">Whānau Pūrakau:</span></div>
<div style="position:absolute;left:304.25px;top:559.97px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:559.97px" class="cls_009"><span class="cls_009">Turama Hawira, Mohi Apou, Rauru Broughton,</span></div>
<div style="position:absolute;left:68.03px;top:563.17px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:563.17px" class="cls_009"><span class="cls_009">Develop a Puna of Human Resources for</span></div>
<div style="position:absolute;left:322.25px;top:570.97px" class="cls_009"><span class="cls_009">Che Wilson, Ken Mair, Doni Karatau, Lee</span></div>
<div style="position:absolute;left:86.03px;top:574.17px" class="cls_009"><span class="cls_009">whānau to draw from for information,</span></div>
<div style="position:absolute;left:322.25px;top:581.97px" class="cls_009"><span class="cls_009">Williams, Paul</span></div>
<div style="position:absolute;left:86.03px;top:585.17px" class="cls_009"><span class="cls_009">resources,</span></div>
<div style="position:absolute;left:304.25px;top:597.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:597.23px" class="cls_009"><span class="cls_009">Teki, Des Canterbury, Mita Davis, Christian</span></div>
<div style="position:absolute;left:68.03px;top:600.42px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:600.42px" class="cls_009"><span class="cls_009">connections, facilitation, research,</span></div>
<div style="position:absolute;left:322.25px;top:608.23px" class="cls_009"><span class="cls_009">Smith, Aroha & Kiriana Beckham, Lee Ashford,</span></div>
<div style="position:absolute;left:86.03px;top:611.42px" class="cls_009"><span class="cls_009">technology</span></div>
<div style="position:absolute;left:322.25px;top:619.23px" class="cls_009"><span class="cls_009">Rama Ashford,</span></div>
<div style="position:absolute;left:68.03px;top:626.67px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:626.67px" class="cls_009"><span class="cls_009">Traditional Wellbeing, empowering whānau</span></div>
<div style="position:absolute;left:304.25px;top:634.48px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:634.48px" class="cls_009"><span class="cls_009">Misty Harrison, Kelly Harrison, Jason Harrison,</span></div>
<div style="position:absolute;left:86.03px;top:637.67px" class="cls_009"><span class="cls_009">with resources (similar to whānau ora, variety</span></div>
<div style="position:absolute;left:322.25px;top:645.48px" class="cls_009"><span class="cls_009">Kahurangi Simon, Kaha Simon, Jigsaw</span></div>
<div style="position:absolute;left:86.03px;top:648.67px" class="cls_009"><span class="cls_009">club</span></div>
<div style="position:absolute;left:322.25px;top:656.48px" class="cls_009"><span class="cls_009">Whanganui,</span></div>
<div style="position:absolute;left:68.03px;top:663.92px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:663.92px" class="cls_009"><span class="cls_009">funding) to facilitate their own wānanga</span></div>
<div style="position:absolute;left:304.25px;top:671.73px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:671.73px" class="cls_009"><span class="cls_009">Tupoho Iwi Services, Land Based Training,</span></div>
<div style="position:absolute;left:86.03px;top:674.92px" class="cls_009"><span class="cls_009">hauora, wānanga mātauranga māori</span></div>
<div style="position:absolute;left:322.25px;top:682.73px" class="cls_009"><span class="cls_009">Whānui M.F.U, Rise, Nga Tai o te Awa, YMCA,</span></div>
<div style="position:absolute;left:86.03px;top:685.92px" class="cls_009"><span class="cls_009">including whakapapa, pepeha, mihimihi, te</span></div>
<div style="position:absolute;left:322.25px;top:693.73px" class="cls_009"><span class="cls_009">Te Oranganui,</span></div>
<div style="position:absolute;left:86.03px;top:696.92px" class="cls_009"><span class="cls_009">reo māori, Pūrākau-ā-whānau,</span></div>
<div style="position:absolute;left:304.25px;top:708.98px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:708.98px" class="cls_009"><span class="cls_009">CMH, Te Ora Hou,</span></div>
<div style="position:absolute;left:68.03px;top:712.18px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:86.03px;top:712.18px" class="cls_009"><span class="cls_009">Social enterprise Development/Whānau Ora</span></div>
<div style="position:absolute;left:86.03px;top:723.18px" class="cls_009"><span class="cls_009">Economic Development and Wealth Creation</span></div>
<div style="position:absolute;left:304.25px;top:724.23px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:322.25px;top:724.23px" class="cls_009"><span class="cls_009">(And a heap more)</span></div>
<div style="position:absolute;left:111.60px;top:753.80px" class="cls_011"><span class="cls_011">March - April 2019: Big Picture Statements from the Small Groups collated</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">28</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:26381px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background32.jpg" width=595 height=841></div>
<div style="position:absolute;left:219.61px;top:304.68px" class="cls_016"><span class="cls_016">Whakapapa Whānau</span></div>
<div style="position:absolute;left:199.16px;top:344.71px" class="cls_009"><span class="cls_009">Rangatahi Maori and whanau are supported</span></div>
<div style="position:absolute;left:196.49px;top:355.71px" class="cls_009"><span class="cls_009">to learn about their whakapapa and enhance</span></div>
<div style="position:absolute;left:213.37px;top:366.71px" class="cls_009"><span class="cls_009">their knowledge and understanding of</span></div>
<div style="position:absolute;left:261.63px;top:377.71px" class="cls_009"><span class="cls_009">Te aronga Maori’</span></div>
<div style="position:absolute;left:193.69px;top:398.97px" class="cls_009"><span class="cls_009">1.</span></div>
<div style="position:absolute;left:211.69px;top:398.97px" class="cls_009"><span class="cls_009">Link to or create wananga for Rangatahi to</span></div>
<div style="position:absolute;left:252.22px;top:409.97px" class="cls_009"><span class="cls_009">learn about whakapapa.</span></div>
<div style="position:absolute;left:194.85px;top:423.80px" class="cls_009"><span class="cls_009">2.</span></div>
<div style="position:absolute;left:212.85px;top:423.80px" class="cls_009"><span class="cls_009">Link to or create storytellers and resources</span></div>
<div style="position:absolute;left:211.05px;top:434.80px" class="cls_009"><span class="cls_009">to ensure whanau porakau are alive & well.</span></div>
<div style="position:absolute;left:210.31px;top:448.64px" class="cls_009"><span class="cls_009">3.</span></div>
<div style="position:absolute;left:228.31px;top:448.64px" class="cls_009"><span class="cls_009">Encourage or provide opportunities</span></div>
<div style="position:absolute;left:226.54px;top:459.64px" class="cls_009"><span class="cls_009">to entrepreneurial skills that support</span></div>
<div style="position:absolute;left:271.64px;top:470.64px" class="cls_009"><span class="cls_009">wealth creation.</span></div>
<div style="position:absolute;left:195.75px;top:484.47px" class="cls_009"><span class="cls_009">4.   Celebrate Rangatahi success through the</span></div>
<div style="position:absolute;left:219.27px;top:495.47px" class="cls_009"><span class="cls_009">telling & celebration of whanau poraka.</span></div>
<div style="position:absolute;left:210.22px;top:509.31px" class="cls_009"><span class="cls_009">5.   Link to or create opportunities to be</span></div>
<div style="position:absolute;left:224.32px;top:520.31px" class="cls_009"><span class="cls_009">exposed to matauranga Maori & nga</span></div>
<div style="position:absolute;left:271.23px;top:531.31px" class="cls_009"><span class="cls_009">taonga tuku iho.</span></div>
<div style="position:absolute;left:202.42px;top:545.14px" class="cls_009"><span class="cls_009">6.   Groups, agencies and organisation will</span></div>
<div style="position:absolute;left:210.92px;top:556.14px" class="cls_009"><span class="cls_009">actively seek to grow thei understanding of</span></div>
<div style="position:absolute;left:259.98px;top:567.14px" class="cls_009"><span class="cls_009">whakapapa whanau.</span></div>
<div style="position:absolute;left:89.14px;top:715.52px" class="cls_011"><span class="cls_011">11/04/19: Large Hui @ Racecourse, 50+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:88.62px;top:726.52px" class="cls_011"><span class="cls_011">young adults, representatives of community agencies, government agencies and</span></div>
<div style="position:absolute;left:123.94px;top:737.52px" class="cls_011"><span class="cls_011">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:112.16px;top:759.31px" class="cls_005"><span class="cls_005">We missed this one out, when we printed the circles, and so we missed the</span></div>
<div style="position:absolute;left:233.47px;top:774.31px" class="cls_005"><span class="cls_005">voice of the roopu on this.</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">29</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:27232px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background33.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.13px" class="cls_002"><span class="cls_002">Tinana</span></div>
<div style="position:absolute;left:96.68px;top:78.59px" class="cls_007"><span class="cls_007">11.</span></div>
<div style="position:absolute;left:95.85px;top:123.78px" class="cls_008"><span class="cls_008">06/09/2018: Large Hui Racecourse, 90+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:96.83px;top:135.78px" class="cls_008"><span class="cls_008">young adults representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:124.44px;top:147.78px" class="cls_008"><span class="cls_008">and schools. Invitations sent via email and open invitation on facebook</span></div>
<div style="position:absolute;left:78.02px;top:177.82px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:68.03px;top:199.61px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:199.61px" class="cls_009"><span class="cls_009">A Lot of services / facilities available, but</span></div>
<div style="position:absolute;left:304.25px;top:199.61px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:199.61px" class="cls_009"><span class="cls_009">Cost not as big as bigger cities</span></div>
<div style="position:absolute;left:78.03px;top:210.61px" class="cls_009"><span class="cls_009">underutilised, Passionate people in the</span></div>
<div style="position:absolute;left:304.25px;top:214.86px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:214.86px" class="cls_009"><span class="cls_009">Mountain biking</span></div>
<div style="position:absolute;left:78.03px;top:221.61px" class="cls_009"><span class="cls_009">community invest a lot.</span></div>
<div style="position:absolute;left:304.25px;top:230.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:230.11px" class="cls_009"><span class="cls_009">Awa</span></div>
<div style="position:absolute;left:68.03px;top:236.86px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:236.86px" class="cls_009"><span class="cls_009">Events, schools, council lead by example -</span></div>
<div style="position:absolute;left:78.03px;top:247.86px" class="cls_009"><span class="cls_009">Healthy</span></div>
<div style="position:absolute;left:304.25px;top:245.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:245.36px" class="cls_009"><span class="cls_009">Community groups / Lots of Volunteers</span></div>
<div style="position:absolute;left:304.25px;top:260.62px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:260.62px" class="cls_009"><span class="cls_009">Martial arts / Cross fit / Gyms</span></div>
<div style="position:absolute;left:68.03px;top:263.11px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:263.11px" class="cls_009"><span class="cls_009">Tough kids, Social Physical</span></div>
<div style="position:absolute;left:304.25px;top:275.87px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:275.87px" class="cls_009"><span class="cls_009">Proud of one’s self</span></div>
<div style="position:absolute;left:68.03px;top:278.36px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:278.36px" class="cls_009"><span class="cls_009">Activities aren’t full on - Bowls, Golf, Waka</span></div>
<div style="position:absolute;left:78.03px;top:289.36px" class="cls_009"><span class="cls_009">AmaSports, Swimming, touch</span></div>
<div style="position:absolute;left:304.25px;top:291.12px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:291.12px" class="cls_009"><span class="cls_009">Dentist / Health checks</span></div>
<div style="position:absolute;left:68.03px;top:304.62px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:304.62px" class="cls_009"><span class="cls_009">Whanau / Iwi Marae sports events / Pa Wars</span></div>
<div style="position:absolute;left:304.25px;top:306.37px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:306.37px" class="cls_009"><span class="cls_009">Rangatahi team at Te Oranganui very under</span></div>
<div style="position:absolute;left:68.03px;top:319.87px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:319.87px" class="cls_009"><span class="cls_009">School nutrition education</span></div>
<div style="position:absolute;left:314.25px;top:317.37px" class="cls_009"><span class="cls_009">utilised</span></div>
<div style="position:absolute;left:304.25px;top:332.62px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:332.62px" class="cls_009"><span class="cls_009">Schools are open to people coming in and</span></div>
<div style="position:absolute;left:68.03px;top:335.12px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:80.43px;top:335.12px" class="cls_009"><span class="cls_009">Role models / P.E Teachers / Coaches /</span></div>
<div style="position:absolute;left:314.25px;top:343.62px" class="cls_009"><span class="cls_009">sharing knowledge</span></div>
<div style="position:absolute;left:78.03px;top:346.12px" class="cls_009"><span class="cls_009">Rangatahi - Tuakana/Teina</span></div>
<div style="position:absolute;left:68.03px;top:361.37px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:361.37px" class="cls_009"><span class="cls_009">Kapa Haka</span></div>
<div style="position:absolute;left:78.02px;top:382.21px" class="cls_004"><span class="cls_004">What are our challenges:</span></div>
<div style="position:absolute;left:68.03px;top:401.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:401.00px" class="cls_009"><span class="cls_009">Service providers need to communicate and</span></div>
<div style="position:absolute;left:304.25px;top:401.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:401.00px" class="cls_009"><span class="cls_009">Side line culture / Club culture</span></div>
<div style="position:absolute;left:78.03px;top:412.00px" class="cls_009"><span class="cls_009">collaborate to maximise opportunities</span></div>
<div style="position:absolute;left:304.25px;top:416.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:416.25px" class="cls_009"><span class="cls_009">Collaboration</span></div>
<div style="position:absolute;left:68.03px;top:427.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:427.25px" class="cls_009"><span class="cls_009">Whanau / Access /Travel /Affordability /</span></div>
<div style="position:absolute;left:304.25px;top:431.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:431.50px" class="cls_009"><span class="cls_009">Intimidation on referees</span></div>
<div style="position:absolute;left:78.03px;top:438.25px" class="cls_009"><span class="cls_009">Facilities cost / Gears / Uniform</span></div>
<div style="position:absolute;left:304.25px;top:446.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:446.75px" class="cls_009"><span class="cls_009">Lack of support for coaches & Volunteers</span></div>
<div style="position:absolute;left:68.03px;top:453.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:453.50px" class="cls_009"><span class="cls_009">Community of high deprivation</span></div>
<div style="position:absolute;left:304.25px;top:462.01px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:462.01px" class="cls_009"><span class="cls_009">Fear of failure at sports</span></div>
<div style="position:absolute;left:68.03px;top:468.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:468.75px" class="cls_009"><span class="cls_009">Social / Self-esteem -Too fat - Not good</span></div>
<div style="position:absolute;left:78.03px;top:479.75px" class="cls_009"><span class="cls_009">enough</span></div>
<div style="position:absolute;left:304.25px;top:477.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:477.26px" class="cls_009"><span class="cls_009">High expectations from parents, peers etc.</span></div>
<div style="position:absolute;left:304.25px;top:492.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:492.51px" class="cls_009"><span class="cls_009">Bad influences in community</span></div>
<div style="position:absolute;left:68.03px;top:495.01px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:495.01px" class="cls_009"><span class="cls_009">Resources</span></div>
<div style="position:absolute;left:304.25px;top:507.76px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:507.76px" class="cls_009"><span class="cls_009">Hire facilities are expensive</span></div>
<div style="position:absolute;left:68.03px;top:510.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:510.26px" class="cls_009"><span class="cls_009">Understanding their body</span></div>
<div style="position:absolute;left:68.03px;top:525.51px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:525.51px" class="cls_009"><span class="cls_009">Whanau participation</span></div>
<div style="position:absolute;left:304.25px;top:523.01px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:523.01px" class="cls_009"><span class="cls_009">Awa under utilised</span></div>
<div style="position:absolute;left:68.03px;top:540.76px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:540.76px" class="cls_009"><span class="cls_009">Cost / Expenses</span></div>
<div style="position:absolute;left:304.25px;top:538.27px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:538.27px" class="cls_009"><span class="cls_009">What have we got for people with disabilities</span></div>
<div style="position:absolute;left:304.25px;top:553.52px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:553.52px" class="cls_009"><span class="cls_009">Education on nutrition</span></div>
<div style="position:absolute;left:68.03px;top:556.01px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:556.01px" class="cls_009"><span class="cls_009">Nutrition -buying food for the whanau cost Vs</span></div>
<div style="position:absolute;left:78.03px;top:567.01px" class="cls_009"><span class="cls_009">Nutritional value</span></div>
<div style="position:absolute;left:304.25px;top:568.77px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:568.77px" class="cls_009"><span class="cls_009">Language - Understanding what departments</span></div>
<div style="position:absolute;left:314.25px;top:579.77px" class="cls_009"><span class="cls_009">are saying</span></div>
<div style="position:absolute;left:68.03px;top:582.27px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:582.27px" class="cls_009"><span class="cls_009">Doctor visits expensive</span></div>
<div style="position:absolute;left:68.03px;top:597.52px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:597.52px" class="cls_009"><span class="cls_009">What is there for those that are not into sports?</span></div>
<div style="position:absolute;left:304.25px;top:595.02px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:595.02px" class="cls_009"><span class="cls_009">Do they know community groups exist?</span></div>
<div style="position:absolute;left:68.03px;top:612.77px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:612.77px" class="cls_009"><span class="cls_009">Role Models / Whanau peers</span></div>
<div style="position:absolute;left:304.25px;top:610.27px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:610.27px" class="cls_009"><span class="cls_009">Cost / Money -How to apply for funding,</span></div>
<div style="position:absolute;left:314.25px;top:621.27px" class="cls_009"><span class="cls_009">where to go?</span></div>
<div style="position:absolute;left:68.03px;top:628.02px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:628.02px" class="cls_009"><span class="cls_009">Hygiene education</span></div>
<div style="position:absolute;left:304.25px;top:636.53px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:636.53px" class="cls_009"><span class="cls_009">Health & safety police checks</span></div>
<div style="position:absolute;left:68.03px;top:643.27px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:643.27px" class="cls_009"><span class="cls_009">If home life is not balanced there are going to</span></div>
<div style="position:absolute;left:304.25px;top:651.78px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:651.78px" class="cls_009"><span class="cls_009">Family / buy in or participation</span></div>
<div style="position:absolute;left:78.03px;top:654.27px" class="cls_009"><span class="cls_009">be barriers</span></div>
<div style="position:absolute;left:68.03px;top:669.53px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:669.53px" class="cls_009"><span class="cls_009">What about kids in poverty / Gangs -How do</span></div>
<div style="position:absolute;left:304.25px;top:667.03px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:667.03px" class="cls_009"><span class="cls_009">People who hold funding only certain</span></div>
<div style="position:absolute;left:78.03px;top:680.53px" class="cls_009"><span class="cls_009">we cater for them</span></div>
<div style="position:absolute;left:314.25px;top:678.03px" class="cls_009"><span class="cls_009">people can access it,</span></div>
<div style="position:absolute;left:68.03px;top:695.78px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:695.78px" class="cls_009"><span class="cls_009">Transport /public / whanau</span></div>
<div style="position:absolute;left:304.25px;top:693.28px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:693.28px" class="cls_009"><span class="cls_009">Diet / sugar /fatty foods</span></div>
<div style="position:absolute;left:304.25px;top:708.53px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:708.53px" class="cls_009"><span class="cls_009">Technology / gaming</span></div>
<div style="position:absolute;left:68.03px;top:711.03px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:711.03px" class="cls_009"><span class="cls_009">Lack of Volunteers</span></div>
<div style="position:absolute;left:304.25px;top:723.79px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:723.79px" class="cls_009"><span class="cls_009">Participation - Confidently / introverts /</span></div>
<div style="position:absolute;left:68.03px;top:726.28px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:726.28px" class="cls_009"><span class="cls_009">Broken homes / No shoes or uniform / lack of</span></div>
<div style="position:absolute;left:314.25px;top:734.79px" class="cls_009"><span class="cls_009">not comfortable / low esteem</span></div>
<div style="position:absolute;left:78.03px;top:737.28px" class="cls_009"><span class="cls_009">whanau support</span></div>
<div style="position:absolute;left:68.03px;top:752.53px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:752.53px" class="cls_009"><span class="cls_009">Age group break down - Intermediate age</span></div>
<div style="position:absolute;left:304.25px;top:750.04px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:750.04px" class="cls_009"><span class="cls_009">Disabilities /intellectual / physical /</span></div>
<div style="position:absolute;left:78.03px;top:763.53px" class="cls_009"><span class="cls_009">barriers - Body image - having the wright</span></div>
<div style="position:absolute;left:304.25px;top:765.29px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:765.29px" class="cls_009"><span class="cls_009">Barriers for family and individuals</span></div>
<div style="position:absolute;left:78.03px;top:774.53px" class="cls_009"><span class="cls_009">gear.</span></div>
<div style="position:absolute;left:304.25px;top:780.54px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:780.54px" class="cls_009"><span class="cls_009">Connecting Rangatahi in</span></div>
<div style="position:absolute;left:68.03px;top:789.79px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:789.79px" class="cls_009"><span class="cls_009">One size doesn’t fit all</span></div>
<div style="position:absolute;left:304.25px;top:795.79px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:314.25px;top:795.79px" class="cls_009"><span class="cls_009">Resources and Money</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">30</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:28083px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background34.jpg" width=595 height=841></div>
<div style="position:absolute;left:78.02px;top:79.45px" class="cls_004"><span class="cls_004">What are our opportunities:</span></div>
<div style="position:absolute;left:68.03px;top:101.24px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:101.24px" class="cls_009"><span class="cls_009">Organisations more funding / Collaboration</span></div>
<div style="position:absolute;left:303.83px;top:101.24px" class="cls_009"><span class="cls_009">• Shine Girls / Strength / self-esteem</span></div>
<div style="position:absolute;left:78.03px;top:112.24px" class="cls_009"><span class="cls_009">e.g. YMCA underutilised</span></div>
<div style="position:absolute;left:313.83px;top:112.24px" class="cls_009"><span class="cls_009">programme</span></div>
<div style="position:absolute;left:68.03px;top:127.49px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:127.49px" class="cls_009"><span class="cls_009">Social environment set up where everyone is</span></div>
<div style="position:absolute;left:303.83px;top:127.49px" class="cls_009"><span class="cls_009">• Get into schools earlier and work on challenges</span></div>
<div style="position:absolute;left:78.03px;top:138.49px" class="cls_009"><span class="cls_009">welcome / increase opportunity’s</span></div>
<div style="position:absolute;left:303.83px;top:142.74px" class="cls_009"><span class="cls_009">• Referee and coach courses / supporters</span></div>
<div style="position:absolute;left:68.03px;top:153.74px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:153.74px" class="cls_009"><span class="cls_009">Events / Push for Water only / healthy kai /</span></div>
<div style="position:absolute;left:303.83px;top:158.00px" class="cls_009"><span class="cls_009">• Youth workers for mentoring</span></div>
<div style="position:absolute;left:78.03px;top:164.74px" class="cls_009"><span class="cls_009">healthy environment</span></div>
<div style="position:absolute;left:303.83px;top:173.25px" class="cls_009"><span class="cls_009">• Creating more opportunities outside schools</span></div>
<div style="position:absolute;left:68.03px;top:180.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:180.00px" class="cls_009"><span class="cls_009">Have-A-Go day / experience sports activity’s</span></div>
<div style="position:absolute;left:78.03px;top:191.00px" class="cls_009"><span class="cls_009">that they might like to try.</span></div>
<div style="position:absolute;left:303.83px;top:188.50px" class="cls_009"><span class="cls_009">• Collaboration</span></div>
<div style="position:absolute;left:303.83px;top:203.75px" class="cls_009"><span class="cls_009">• Waka-Ama</span></div>
<div style="position:absolute;left:68.03px;top:206.25px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:206.25px" class="cls_009"><span class="cls_009">Nutrition education in classes</span></div>
<div style="position:absolute;left:68.03px;top:221.50px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:221.50px" class="cls_009"><span class="cls_009">Matauranga Maori -Strengthen</span></div>
<div style="position:absolute;left:303.83px;top:219.00px" class="cls_009"><span class="cls_009">• Don’t be shy to apply -ask community</span></div>
<div style="position:absolute;left:313.83px;top:230.00px" class="cls_009"><span class="cls_009">organisations</span></div>
<div style="position:absolute;left:68.03px;top:236.75px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:236.75px" class="cls_009"><span class="cls_009">Dance more genre - Hip hop / do youth want</span></div>
<div style="position:absolute;left:78.03px;top:247.75px" class="cls_009"><span class="cls_009">to dance?</span></div>
<div style="position:absolute;left:303.83px;top:245.26px" class="cls_009"><span class="cls_009">• Social media / sharing / caring</span></div>
<div style="position:absolute;left:303.83px;top:260.51px" class="cls_009"><span class="cls_009">• Schools / youth groups / collaboration</span></div>
<div style="position:absolute;left:68.03px;top:263.00px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:263.00px" class="cls_009"><span class="cls_009">How do we build on / Strengthen classes? /</span></div>
<div style="position:absolute;left:78.03px;top:274.00px" class="cls_009"><span class="cls_009">Aotea Empire</span></div>
<div style="position:absolute;left:303.83px;top:275.76px" class="cls_009"><span class="cls_009">• Sports alternative</span></div>
<div style="position:absolute;left:68.03px;top:289.26px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:289.26px" class="cls_009"><span class="cls_009">Role Models</span></div>
<div style="position:absolute;left:84.07px;top:316.60px" class="cls_008"><span class="cls_008">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:78.33px;top:328.60px" class="cls_008"><span class="cls_008">young adults, representatives of churches and agencies and community agencies and</span></div>
<div style="position:absolute;left:127.03px;top:340.60px" class="cls_008"><span class="cls_008">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:77.35px;top:370.65px" class="cls_004"><span class="cls_004">Strengths - Themes</span></div>
<div style="position:absolute;left:312.26px;top:370.65px" class="cls_004"><span class="cls_004">If there were no Limits what would</span></div>
<div style="position:absolute;left:312.26px;top:383.65px" class="cls_004"><span class="cls_004">we do more of?</span></div>
<div style="position:absolute;left:68.03px;top:394.14px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:394.14px" class="cls_009"><span class="cls_009">Sports, clubs, organised</span></div>
<div style="position:absolute;left:303.83px;top:404.26px" class="cls_009"><span class="cls_009">• Use what we have better, Natural resources</span></div>
<div style="position:absolute;left:68.03px;top:409.39px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:409.39px" class="cls_009"><span class="cls_009">Community volunteers</span></div>
<div style="position:absolute;left:303.83px;top:419.51px" class="cls_009"><span class="cls_009">• Remove barriers, Money resources,</span></div>
<div style="position:absolute;left:68.03px;top:424.65px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:424.65px" class="cls_009"><span class="cls_009">Not utilised, Accessibility, Strength</span></div>
<div style="position:absolute;left:313.83px;top:430.51px" class="cls_009"><span class="cls_009">Accessibility, Criteria</span></div>
<div style="position:absolute;left:68.03px;top:439.90px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:439.90px" class="cls_009"><span class="cls_009">Adventure</span></div>
<div style="position:absolute;left:303.83px;top:445.77px" class="cls_009"><span class="cls_009">• Celebrations, doing more, Telling stories of</span></div>
<div style="position:absolute;left:68.03px;top:455.15px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:455.15px" class="cls_009"><span class="cls_009">Commitment, Culture of...</span></div>
<div style="position:absolute;left:313.83px;top:456.77px" class="cls_009"><span class="cls_009">good stuff/sports awards ECT.</span></div>
<div style="position:absolute;left:68.03px;top:470.40px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:470.40px" class="cls_009"><span class="cls_009">Connection, Adults & Rangatahi</span></div>
<div style="position:absolute;left:303.83px;top:472.02px" class="cls_009"><span class="cls_009">• Adults & Rangatahi building relationships</span></div>
<div style="position:absolute;left:303.83px;top:487.27px" class="cls_009"><span class="cls_009">• Collective vision</span></div>
<div style="position:absolute;left:77.99px;top:491.24px" class="cls_004"><span class="cls_004">Challenges</span></div>
<div style="position:absolute;left:303.83px;top:502.52px" class="cls_009"><span class="cls_009">• Working as a community rather than</span></div>
<div style="position:absolute;left:68.03px;top:513.03px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:513.03px" class="cls_009"><span class="cls_009">Under utilisation of recourses, Awa,</span></div>
<div style="position:absolute;left:313.83px;top:513.52px" class="cls_009"><span class="cls_009">competing</span></div>
<div style="position:absolute;left:78.03px;top:524.03px" class="cls_009"><span class="cls_009">Maunga, Moana</span></div>
<div style="position:absolute;left:303.83px;top:528.77px" class="cls_009"><span class="cls_009">• Casual random doing and being present i.e.</span></div>
<div style="position:absolute;left:68.03px;top:539.28px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:539.28px" class="cls_009"><span class="cls_009">Resources, Accessibility</span></div>
<div style="position:absolute;left:313.83px;top:539.77px" class="cls_009"><span class="cls_009">Neighbourhood park, Games</span></div>
<div style="position:absolute;left:68.03px;top:554.53px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:554.53px" class="cls_009"><span class="cls_009">Negative influences</span></div>
<div style="position:absolute;left:303.83px;top:555.03px" class="cls_009"><span class="cls_009">• People congregating</span></div>
<div style="position:absolute;left:303.83px;top:570.28px" class="cls_009"><span class="cls_009">• Connecting with the people around you.</span></div>
<div style="position:absolute;left:114.83px;top:593.39px" class="cls_011"><span class="cls_011">Oct 18 - Feb 2019: Theme Focus Hui including anyone who opted into this</span></div>
<div style="position:absolute;left:226.05px;top:604.39px" class="cls_011"><span class="cls_011">particular discussion group.</span></div>
<div style="position:absolute;left:173.33px;top:635.45px" class="cls_005"><span class="cls_005">There wasn’t any group interest in working on this.</span></div>
<div style="position:absolute;left:133.57px;top:665.54px" class="cls_011"><span class="cls_011">March - April 2019: Big Picture Statements from the Small Groups</span></div>
<div style="position:absolute;left:276.85px;top:676.54px" class="cls_011"><span class="cls_011">collated</span></div>
<div style="position:absolute;left:202.00px;top:707.61px" class="cls_005"><span class="cls_005">Jay and Jude put something together.</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">31</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:28934px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background35.jpg" width=595 height=841></div>
<div style="position:absolute;left:274.40px;top:297.35px" class="cls_016"><span class="cls_016">Tinana</span></div>
<div style="position:absolute;left:216.46px;top:345.38px" class="cls_009"><span class="cls_009">Rangatahi Maori are supported and</span></div>
<div style="position:absolute;left:216.46px;top:356.38px" class="cls_009"><span class="cls_009">connected to opportunities which</span></div>
<div style="position:absolute;left:216.46px;top:367.38px" class="cls_009"><span class="cls_009">enhance their physical wellbeing</span></div>
<div style="position:absolute;left:205.74px;top:395.64px" class="cls_009"><span class="cls_009">1.</span></div>
<div style="position:absolute;left:223.74px;top:395.64px" class="cls_009"><span class="cls_009">Review and resurrect the For Our Kids</span></div>
<div style="position:absolute;left:286.78px;top:406.64px" class="cls_009"><span class="cls_009">kaupapa</span></div>
<div style="position:absolute;left:210.05px;top:420.47px" class="cls_009"><span class="cls_009">2.</span></div>
<div style="position:absolute;left:228.05px;top:420.47px" class="cls_009"><span class="cls_009">Sports groups are encouraged and</span></div>
<div style="position:absolute;left:230.59px;top:431.47px" class="cls_009"><span class="cls_009">equipped to respond to rangatahi</span></div>
<div style="position:absolute;left:236.19px;top:442.47px" class="cls_009"><span class="cls_009">Maori in ways that support their</span></div>
<div style="position:absolute;left:223.15px;top:453.47px" class="cls_009"><span class="cls_009">physical engagemenand values their</span></div>
<div style="position:absolute;left:267.36px;top:464.47px" class="cls_009"><span class="cls_009">cultural wellbeing</span></div>
<div style="position:absolute;left:209.18px;top:478.31px" class="cls_009"><span class="cls_009">3.</span></div>
<div style="position:absolute;left:227.18px;top:478.31px" class="cls_009"><span class="cls_009">Rangatahi Maori are able to access</span></div>
<div style="position:absolute;left:246.63px;top:489.31px" class="cls_009"><span class="cls_009">diverse physical aactivities</span></div>
<div style="position:absolute;left:89.14px;top:715.52px" class="cls_011"><span class="cls_011">11/04/19: Large Hui @ Racecourse, 50+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:88.62px;top:726.52px" class="cls_011"><span class="cls_011">young adults, representatives of community agencies, government agencies and</span></div>
<div style="position:absolute;left:123.94px;top:737.52px" class="cls_011"><span class="cls_011">schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:120.17px;top:763.55px" class="cls_005"><span class="cls_005">‘open’ facilities (sports grounds, schools, halls) Cool spaces and places</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">32</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:29785px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background36.jpg" width=595 height=841></div>
<div style="position:absolute;left:172.37px;top:86.13px" class="cls_002"><span class="cls_002">Added Ideas</span></div>
<div style="position:absolute;left:96.68px;top:78.59px" class="cls_007"><span class="cls_007">13.</span></div>
<div style="position:absolute;left:130.55px;top:123.77px" class="cls_008"><span class="cls_008">Hui 06/09/2018 @ Racecourse, 90+ people including parents, tertiary</span></div>
<div style="position:absolute;left:127.64px;top:135.77px" class="cls_008"><span class="cls_008">students, young adults,representatives of churches and agencies and</span></div>
<div style="position:absolute;left:218.28px;top:147.77px" class="cls_008"><span class="cls_008">community agencies and schools</span></div>
<div style="position:absolute;left:68.03px;top:177.65px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:177.65px" class="cls_009"><span class="cls_009">Be strong for them</span></div>
<div style="position:absolute;left:314.24px;top:177.70px" class="cls_004"><span class="cls_004">What are our opportunities</span></div>
<div style="position:absolute;left:68.03px;top:192.90px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:192.90px" class="cls_009"><span class="cls_009">For our kids</span></div>
<div style="position:absolute;left:304.25px;top:199.49px" class="cls_009"><span class="cls_009">• Access to services / Funding / real world skills</span></div>
<div style="position:absolute;left:314.25px;top:210.49px" class="cls_009"><span class="cls_009">/ Understanding healthy relationships and</span></div>
<div style="position:absolute;left:78.02px;top:213.74px" class="cls_004"><span class="cls_004">What are the strengths?</span></div>
<div style="position:absolute;left:314.25px;top:221.49px" class="cls_009"><span class="cls_009">money /</span></div>
<div style="position:absolute;left:68.03px;top:235.53px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:235.53px" class="cls_009"><span class="cls_009">Raukotahi / Tira hoe waka / Kaupapa driven /</span></div>
<div style="position:absolute;left:304.25px;top:236.74px" class="cls_009"><span class="cls_009">• Mana enhancing programs / Rangatahi</span></div>
<div style="position:absolute;left:78.03px;top:246.53px" class="cls_009"><span class="cls_009">Kaumatua kaunihera / Iwi initiatives / Parks /</span></div>
<div style="position:absolute;left:314.25px;top:247.74px" class="cls_009"><span class="cls_009">based activities / Early intervention</span></div>
<div style="position:absolute;left:314.25px;top:258.74px" class="cls_009"><span class="cls_009">/ Exposure to positive</span></div>
<div style="position:absolute;left:68.03px;top:261.78px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:261.78px" class="cls_009"><span class="cls_009">Environments / Sports facilities / It’s our home</span></div>
<div style="position:absolute;left:304.25px;top:273.99px" class="cls_009"><span class="cls_009">• initiatives</span></div>
<div style="position:absolute;left:78.02px;top:282.62px" class="cls_004"><span class="cls_004">What are our challenges:</span></div>
<div style="position:absolute;left:313.82px;top:294.83px" class="cls_004"><span class="cls_004">Recognizing what we already have</span></div>
<div style="position:absolute;left:68.03px;top:304.40px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:304.40px" class="cls_009"><span class="cls_009">Cost /Lack of council support / Engaging</span></div>
<div style="position:absolute;left:78.03px;top:315.40px" class="cls_009"><span class="cls_009">hard to reach whanau / Cost of kai / Youth</span></div>
<div style="position:absolute;left:303.83px;top:316.62px" class="cls_009"><span class="cls_009">• In our community</span></div>
<div style="position:absolute;left:78.03px;top:326.40px" class="cls_009"><span class="cls_009">supported</span></div>
<div style="position:absolute;left:303.83px;top:331.87px" class="cls_009"><span class="cls_009">• Sports groups</span></div>
<div style="position:absolute;left:68.03px;top:341.66px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:341.66px" class="cls_009"><span class="cls_009">initiatives / poverty / Positive role models /</span></div>
<div style="position:absolute;left:303.83px;top:347.12px" class="cls_009"><span class="cls_009">• Youth groups</span></div>
<div style="position:absolute;left:78.03px;top:352.66px" class="cls_009"><span class="cls_009">Support for talented youth</span></div>
<div style="position:absolute;left:303.83px;top:362.37px" class="cls_009"><span class="cls_009">• Church groupsMentoring</span></div>
<div style="position:absolute;left:78.02px;top:373.49px" class="cls_004"><span class="cls_004">Rangatahi Ideas - End of hui discussion</span></div>
<div style="position:absolute;left:303.83px;top:377.62px" class="cls_009"><span class="cls_009">• Acceptance</span></div>
<div style="position:absolute;left:303.83px;top:392.88px" class="cls_009"><span class="cls_009">• Lack of connection</span></div>
<div style="position:absolute;left:68.03px;top:395.28px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:395.28px" class="cls_009"><span class="cls_009">Paying a group pf rangatahi to get rangatahi</span></div>
<div style="position:absolute;left:78.03px;top:406.28px" class="cls_009"><span class="cls_009">own voice so they understand it well</span></div>
<div style="position:absolute;left:303.83px;top:408.13px" class="cls_009"><span class="cls_009">• Tikanga</span></div>
<div style="position:absolute;left:68.03px;top:421.54px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:421.54px" class="cls_009"><span class="cls_009">Youth council / community</span></div>
<div style="position:absolute;left:303.83px;top:423.38px" class="cls_009"><span class="cls_009">• kawa</span></div>
<div style="position:absolute;left:68.03px;top:436.79px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:436.79px" class="cls_009"><span class="cls_009">Hard to reach people who already from those</span></div>
<div style="position:absolute;left:303.83px;top:438.63px" class="cls_009"><span class="cls_009">• Advertising youth events.</span></div>
<div style="position:absolute;left:78.03px;top:447.79px" class="cls_009"><span class="cls_009">groups / Tuakana</span></div>
<div style="position:absolute;left:68.03px;top:463.04px" class="cls_009"><span class="cls_009">•</span></div>
<div style="position:absolute;left:78.03px;top:463.04px" class="cls_009"><span class="cls_009">E tu whanau</span></div>
<div style="position:absolute;left:90.39px;top:490.39px" class="cls_008"><span class="cls_008">26/09/2018: Large Hui @ Racecourse, 70+ people including parents, tertiary students,</span></div>
<div style="position:absolute;left:95.85px;top:502.39px" class="cls_008"><span class="cls_008">young adults, representatives of churches and agencies and community agencies</span></div>
<div style="position:absolute;left:121.90px;top:514.39px" class="cls_008"><span class="cls_008">and schools. Invitations send via email and open invitation via facebook</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">33</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:30636px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background37.jpg" width=595 height=841></div>
<div style="position:absolute;left:101.64px;top:79.45px" class="cls_004"><span class="cls_004">Lets meet up</span></div>
<div style="position:absolute;left:106.14px;top:105.74px" class="cls_009"><span class="cls_009">Topic</span></div>
<div style="position:absolute;left:165.87px;top:105.74px" class="cls_009"><span class="cls_009">Empowering Role Models through sports, clubs, arts ect. (Adults)</span></div>
<div style="position:absolute;left:106.14px;top:125.34px" class="cls_009"><span class="cls_009">Host:</span></div>
<div style="position:absolute;left:165.87px;top:125.34px" class="cls_009"><span class="cls_009">Greg Tichbon</span></div>
<div style="position:absolute;left:106.14px;top:145.90px" class="cls_009"><span class="cls_009">Contact: #</span></div>
<div style="position:absolute;left:165.87px;top:145.90px" class="cls_009"><span class="cls_009">0272495088</span></div>
<div style="position:absolute;left:106.14px;top:166.45px" class="cls_009"><span class="cls_009">Email:</span></div>
<div style="position:absolute;left:165.87px;top:166.45px" class="cls_009"><span class="cls_009">gtichbon@teorahou.org.nz</span></div>
<div style="position:absolute;left:101.64px;top:209.11px" class="cls_004"><span class="cls_004">Yes I want to meet up!!</span></div>
<div style="position:absolute;left:106.14px;top:233.40px" class="cls_009"><span class="cls_009">Name</span></div>
<div style="position:absolute;left:267.42px;top:233.40px" class="cls_009"><span class="cls_009">Contact</span></div>
<div style="position:absolute;left:330.59px;top:233.40px" class="cls_009"><span class="cls_009">Email</span></div>
<div style="position:absolute;left:106.14px;top:252.85px" class="cls_009"><span class="cls_009">Willz Thomspon</span></div>
<div style="position:absolute;left:267.42px;top:252.85px" class="cls_009"><span class="cls_009">0223422067</span></div>
<div style="position:absolute;left:330.59px;top:252.85px" class="cls_009"><span class="cls_009">Willz.thomspson2919@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:270.30px" class="cls_009"><span class="cls_009">Shane Doull</span></div>
<div style="position:absolute;left:267.42px;top:270.30px" class="cls_009"><span class="cls_009">0212372736</span></div>
<div style="position:absolute;left:330.59px;top:270.30px" class="cls_009"><span class="cls_009">Da11asdou11@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:287.75px" class="cls_009"><span class="cls_009">Hayden Bradley</span></div>
<div style="position:absolute;left:330.59px;top:287.75px" class="cls_009"><span class="cls_009">Hayden.bradley@tepraganui.co.nz</span></div>
<div style="position:absolute;left:106.14px;top:305.20px" class="cls_009"><span class="cls_009">Justin Gush</span></div>
<div style="position:absolute;left:330.59px;top:305.20px" class="cls_009"><span class="cls_009">Ngahinal73@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:322.65px" class="cls_009"><span class="cls_009">Keegan Easton</span></div>
<div style="position:absolute;left:330.59px;top:322.65px" class="cls_009"><span class="cls_009">Keaston@teorahou.org.nz</span></div>
<div style="position:absolute;left:106.14px;top:340.10px" class="cls_009"><span class="cls_009">Donna Mcculllough</span></div>
<div style="position:absolute;left:330.59px;top:340.10px" class="cls_009"><span class="cls_009">Donnamccullough44@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:357.55px" class="cls_009"><span class="cls_009">Linda Hurt</span></div>
<div style="position:absolute;left:330.59px;top:357.55px" class="cls_009"><span class="cls_009">Lhurt144@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:375.00px" class="cls_009"><span class="cls_009">Taylor Nikora</span></div>
<div style="position:absolute;left:267.42px;top:375.00px" class="cls_009"><span class="cls_009">0277118826</span></div>
<div style="position:absolute;left:106.14px;top:392.45px" class="cls_009"><span class="cls_009">Aisha Beazley</span></div>
<div style="position:absolute;left:330.59px;top:392.45px" class="cls_009"><span class="cls_009">aishabeazley@live.com</span></div>
<div style="position:absolute;left:106.14px;top:409.90px" class="cls_009"><span class="cls_009">Glenn Daly</span></div>
<div style="position:absolute;left:330.59px;top:409.90px" class="cls_009"><span class="cls_009">Glenndaly2018@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:427.35px" class="cls_009"><span class="cls_009">Lee Michelle Ngatoa</span></div>
<div style="position:absolute;left:267.42px;top:427.35px" class="cls_009"><span class="cls_009">0220106460</span></div>
<div style="position:absolute;left:330.59px;top:427.35px" class="cls_009"><span class="cls_009">71mn999@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:444.80px" class="cls_009"><span class="cls_009">Mel Miller</span></div>
<div style="position:absolute;left:330.59px;top:444.80px" class="cls_009"><span class="cls_009">Melaniemiller133@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:462.25px" class="cls_009"><span class="cls_009">Cheryl Rogers</span></div>
<div style="position:absolute;left:330.59px;top:462.25px" class="cls_009"><span class="cls_009">Cherylrogers004@msd.govt.co.nz</span></div>
<div style="position:absolute;left:106.14px;top:479.70px" class="cls_009"><span class="cls_009">Katrina Hina</span></div>
<div style="position:absolute;left:267.42px;top:479.70px" class="cls_009"><span class="cls_009">0293890610</span></div>
<div style="position:absolute;left:330.59px;top:479.70px" class="cls_009"><span class="cls_009">k.hina@uwi.ac.nz</span></div>
<div style="position:absolute;left:106.14px;top:497.15px" class="cls_009"><span class="cls_009">Jacqueline Bra</span></div>
<div style="position:absolute;left:267.42px;top:497.15px" class="cls_009"><span class="cls_009">0211359948</span></div>
<div style="position:absolute;left:330.59px;top:497.15px" class="cls_009"><span class="cls_009">jacuiline@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:514.60px" class="cls_009"><span class="cls_009">Maddy</span></div>
<div style="position:absolute;left:267.42px;top:514.60px" class="cls_009"><span class="cls_009">0274395375</span></div>
<div style="position:absolute;left:101.64px;top:539.94px" class="cls_004"><span class="cls_004">Lets meet up</span></div>
<div style="position:absolute;left:106.14px;top:566.23px" class="cls_009"><span class="cls_009">Topic</span></div>
<div style="position:absolute;left:165.87px;top:566.23px" class="cls_009"><span class="cls_009">Matakite 2018 (Visioning)</span></div>
<div style="position:absolute;left:106.14px;top:589.35px" class="cls_009"><span class="cls_009">Host:</span></div>
<div style="position:absolute;left:165.87px;top:589.35px" class="cls_009"><span class="cls_009">Waru & Gillian</span></div>
<div style="position:absolute;left:106.14px;top:614.26px" class="cls_009"><span class="cls_009">Contact: #</span></div>
<div style="position:absolute;left:165.87px;top:614.26px" class="cls_009"><span class="cls_009">0274593851</span></div>
<div style="position:absolute;left:106.14px;top:638.11px" class="cls_009"><span class="cls_009">Email:</span></div>
<div style="position:absolute;left:165.87px;top:638.11px" class="cls_009"><span class="cls_009">gillianwaru@gmail.com</span></div>
<div style="position:absolute;left:101.64px;top:669.60px" class="cls_004"><span class="cls_004">Yes I want to meet up!!</span></div>
<div style="position:absolute;left:106.14px;top:693.88px" class="cls_009"><span class="cls_009">Name</span></div>
<div style="position:absolute;left:267.42px;top:693.88px" class="cls_009"><span class="cls_009">Contact</span></div>
<div style="position:absolute;left:330.59px;top:693.88px" class="cls_009"><span class="cls_009">Email</span></div>
<div style="position:absolute;left:106.14px;top:713.33px" class="cls_009"><span class="cls_009">Maddy</span></div>
<div style="position:absolute;left:267.42px;top:713.33px" class="cls_009"><span class="cls_009">0274395375</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">34</span></div>
</div>
<div style="position:absolute;left:50%;margin-left:-297px;top:31487px;width:595px;height:841px;border-style:outset;overflow:hidden">
<div style="position:absolute;left:0px;top:0px">
<img src="316e2f6a-ba49-11e9-9d71-0cc47a792c0a_id_316e2f6a-ba49-11e9-9d71-0cc47a792c0a_files/background38.jpg" width=595 height=841></div>
<div style="position:absolute;left:101.64px;top:79.45px" class="cls_004"><span class="cls_004">Lets meet up</span></div>
<div style="position:absolute;left:106.14px;top:105.74px" class="cls_009"><span class="cls_009">Topic</span></div>
<div style="position:absolute;left:165.87px;top:105.74px" class="cls_009"><span class="cls_009">Creative Stuff</span></div>
<div style="position:absolute;left:106.14px;top:128.86px" class="cls_009"><span class="cls_009">Host:</span></div>
<div style="position:absolute;left:165.87px;top:128.86px" class="cls_009"><span class="cls_009">Jay Rerekura</span></div>
<div style="position:absolute;left:106.14px;top:153.77px" class="cls_009"><span class="cls_009">Contact: #</span></div>
<div style="position:absolute;left:165.87px;top:153.77px" class="cls_009"><span class="cls_009">Not listed</span></div>
<div style="position:absolute;left:106.14px;top:177.63px" class="cls_009"><span class="cls_009">Email:</span></div>
<div style="position:absolute;left:165.87px;top:177.63px" class="cls_009"><span class="cls_009">Not listed</span></div>
<div style="position:absolute;left:101.64px;top:209.11px" class="cls_004"><span class="cls_004">Yes I want to meet up!!</span></div>
<div style="position:absolute;left:106.14px;top:233.40px" class="cls_009"><span class="cls_009">Name</span></div>
<div style="position:absolute;left:267.42px;top:233.40px" class="cls_009"><span class="cls_009">Contact</span></div>
<div style="position:absolute;left:330.59px;top:233.40px" class="cls_009"><span class="cls_009">Email</span></div>
<div style="position:absolute;left:106.14px;top:252.85px" class="cls_009"><span class="cls_009">Willz Thomspon</span></div>
<div style="position:absolute;left:267.42px;top:252.85px" class="cls_009"><span class="cls_009">0223422067</span></div>
<div style="position:absolute;left:330.59px;top:252.85px" class="cls_009"><span class="cls_009">Willz.thomspson2919@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:270.30px" class="cls_009"><span class="cls_009">Shane Doull</span></div>
<div style="position:absolute;left:267.42px;top:270.30px" class="cls_009"><span class="cls_009">0212372736</span></div>
<div style="position:absolute;left:330.59px;top:270.30px" class="cls_009"><span class="cls_009">Da11asdou11@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:287.75px" class="cls_009"><span class="cls_009">Aisha Beazley</span></div>
<div style="position:absolute;left:330.59px;top:287.75px" class="cls_009"><span class="cls_009">aishabeazley@live.com</span></div>
<div style="position:absolute;left:106.14px;top:305.20px" class="cls_009"><span class="cls_009">Justin Gush</span></div>
<div style="position:absolute;left:330.59px;top:305.20px" class="cls_009"><span class="cls_009">Ngahinal73@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:322.65px" class="cls_009"><span class="cls_009">Taylor Nikora</span></div>
<div style="position:absolute;left:267.42px;top:322.65px" class="cls_009"><span class="cls_009">0277118826</span></div>
<div style="position:absolute;left:106.14px;top:340.10px" class="cls_009"><span class="cls_009">Jacqueline Bra</span></div>
<div style="position:absolute;left:267.42px;top:340.10px" class="cls_009"><span class="cls_009">0211359948</span></div>
<div style="position:absolute;left:330.59px;top:340.10px" class="cls_009"><span class="cls_009">jacuiline@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:357.55px" class="cls_009"><span class="cls_009">Lee Williams</span></div>
<div style="position:absolute;left:267.42px;top:357.55px" class="cls_009"><span class="cls_009">0278660439</span></div>
<div style="position:absolute;left:330.59px;top:357.55px" class="cls_009"><span class="cls_009">elizabethleewilliams@gmail.com</span></div>
<div style="position:absolute;left:106.14px;top:375.00px" class="cls_009"><span class="cls_009">Bailie Edwards</span></div>
<div style="position:absolute;left:267.42px;top:375.00px" class="cls_009"><span class="cls_009">0273717229</span></div>
<div style="position:absolute;left:330.59px;top:375.00px" class="cls_009"><span class="cls_009">Bailie908@hotmail.com</span></div>
<div style="position:absolute;left:106.14px;top:392.45px" class="cls_009"><span class="cls_009">Marlene Whetton</span></div>
<div style="position:absolute;left:267.42px;top:392.45px" class="cls_009"><span class="cls_009">069658153</span></div>
<div style="position:absolute;left:330.59px;top:392.45px" class="cls_009"><span class="cls_009">Marlene.whetton004@msd.govt.nz</span></div>
<div style="position:absolute;left:106.14px;top:409.90px" class="cls_009"><span class="cls_009">Tristan S</span></div>
<div style="position:absolute;left:267.42px;top:409.90px" class="cls_009"><span class="cls_009">0274433053</span></div>
<div style="position:absolute;left:330.59px;top:409.90px" class="cls_009"><span class="cls_009">tristansmith@ymca</span></div>
<div style="position:absolute;left:106.14px;top:427.35px" class="cls_009"><span class="cls_009">Cheryl Rogers</span></div>
<div style="position:absolute;left:330.59px;top:427.35px" class="cls_009"><span class="cls_009">Cherylrogers004@msd.govt.co.nz</span></div>
<div style="position:absolute;left:106.14px;top:444.80px" class="cls_009"><span class="cls_009">Charlie Williams</span></div>
<div style="position:absolute;left:267.42px;top:444.80px" class="cls_009"><span class="cls_009">0204075275</span></div>
<div style="position:absolute;left:330.59px;top:444.80px" class="cls_009"><span class="cls_009">cboi</span></div>
<div style="position:absolute;left:291.02px;top:813.15px" class="cls_004"><span class="cls_004">35</span></div>
</div>
</asp:Content>

