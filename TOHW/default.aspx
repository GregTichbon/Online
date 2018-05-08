<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TOHW._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--
    Hyperspace by HTML5 UP
    html5up.net | @ajlkn
    Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
    <title>Te Ora Hou Whanganui</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
    <link rel="stylesheet" href="assets/css/main.css" />
    <!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
    <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->

    <style>
        .b-popup {
            background-color: #fff;
            border-radius: 10px 10px 10px 10px;
            box-shadow: 0 0 25px 5px #999;
            color: #111;
            display: none;
            min-width: 450px;
            padding: 25px;
        }

        .b-button {
            background-color: #2b91af;
            border-radius: 10px;
            box-shadow: 0 2px 3px rgba(0, 0, 0, 0.3);
            color: #fff;
            cursor: pointer;
            display: inline-block;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
        }

            .b-button.small {
                border-radius: 15px;
                float: right;
                margin: 22px 5px 0;
                padding: 6px 15px;
            }

            .b-button:hover {
                background-color: #1e1e1e;
            }

            .b-button > span {
                font-size: 84%;
            }

            .b-button.b-close {
                border-radius: 7px 7px 7px 7px;
                box-shadow: none;
                font: bold 131% sans-serif;
                padding: 0 6px 2px;
                position: absolute;
                right: -7px;
                top: -7px;
            }
    </style>

    <!-- Scripts -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/jquery.scrollex.min.js"></script>
    <script src="assets/js/jquery.scrolly.min.js"></script>
    <script src="assets/js/skel.min.js"></script>
    <script src="assets/js/util.js"> </script>
    <!-- [if lte IE 8] > <script src="assets/js/ie/respond.min.js" > </script > <![endif] -->
    <script src="assets/js/main.js"></script>
    <script src="scripts/bPopup.js"></script>
    <script>
        $(document).ready(function () {
            $(function () {

                // Binding a click event
                // From jQuery v.1.7.0 use .on() instead of .bind()
                $('.b-popup-link').bind('click', function (e) {

                    // Prevents the default action to be triggered. 
                    e.preventDefault();

                    target = $(this).data('target');

                    // Triggering bPopup when click event is fired
                    $('#' + target).bPopup();

                    /*
                    $('#' + target).bPopup({
                        contentContainer: '.content',
                        loadUrl: 'test1.html' //Uses jQuery.load()
                    });
                    */

                });

            });


        }); </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Sidebar -->
    <section id="sidebar">
        <div class="inner">
            <nav>
                <ul>
                    <li><a href="#intro">Welcome</a> </li>
                    <li><a href="#one">Who we are</a> </li>
                    <li><a href="#two">What we do</a> </li>
                    <li><a href="#three">Who supports us</a> </li>
                    <li><a href="#four">Interns</a> </li>
                    <li><a href="#five">Get in touch</a> </li>
                </ul>
            </nav>
        </div>
    </section>
    <!-- Wrapper -->
    <div id="wrapper">
        <!-- Intro -->
        <section id="intro" class="wrapper style1 fullscreen fade-up">
            <div class="inner">
                <h1>Te Ora Hou Whanganui</h1>
                <p>Welcome to Te Ora Hou Whanganui</p>
                <ul class="actions">
                    <li><a href="#one" class="button scrolly">Learn more</a> </li>
                </ul>
            </div>
        </section>
        <!-- One -->
        <section id="one" class="wrapper style2 spotlights">
            <section>
                <a href="#" class="image">
                    <img src="images/JudyKumeroa.jpg" alt="" data-position="center center" /></a>
                <div class="content">
                    <div class="inner">
                        <h2>Judy Kumeroa</h2>
                        <p>Kaihautu</p>
                        <ul class="actions">
                            <li><a href="javascript:void(0);" class="button b-popup-link" data-target="judy_popup">Learn more</a> </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section>
                <a href="#" class="image">
                    <img src="images/aimeeMatthews.jpg" alt="" data-position="top center" />
                </a>
                <div class="content">
                    <div class="inner">
                        <h2>Aimee Matthews</h2>
                        <p>Office Manager / Drivers Licence Co-ordinator</p>
                        <ul class="actions">
                            <li><a href="javascript:void(0);" class="button" data-bpopup='{"contentContainer":".content","loadUrl":"test1.html"}'>Learn more</a> </li>
                            <li><a href="#" class="button">Learn more</a> </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section>
                <a href="#" class="image">
                    <img src="images/JordinHaami-Rerekura.jpg" alt="" data-position="25% 25%" />
                </a>
                <div class="content">
                    <div class="inner">
                        <h2>Jordin Haami-Rerekura</h2>
                        <p>Youth Worker / Te Pihi Ora Hou Wahine Co-ordinator</p>
                        <ul class="actions">
                            <li><a href="#" class="button">Learn more</a> </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section>
                <a href="#" class="image">
                    <img src="images/KeeganEaston.jpg" alt="" data-position="25% 25%" />
                </a>
                <div class="content">
                    <div class="inner">
                        <h2>Keegan Easton</h2>
                        <p>Youth Worker / Te Pihi Ora Hou Tane Co-ordinator</p>
                        <ul class="actions">
                            <li><a href="#" class="button">Learn more</a> </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section>
                <a href="#" class="image">
                    <img src="images/Charlie-BoyWilliams.jpg" alt="" data-position="25% 25%" />
                </a>
                <div class="content">
                    <div class="inner">
                        <h2>Charlie-Boy Williams</h2>
                        <p>Youth Worker / Senior Club Co-ordinator</p>
                        <ul class="actions">
                            <li><a href="#" class="button">Learn more</a> </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section>
                <a href="#" class="image">
                    <img src="images/KathParnell.jpg" alt="" data-position="25% 25%" />
                </a>
                <div class="content">
                    <div class="inner">
                        <h2>Kathy Parnell</h2>
                        <p>Stone Soup Community Facilitator</p>
                        <ul class="actions">
                            <li><a href="#" class="button">Learn more</a> </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section>
                <a href="#" class="image">
                    <img src="images/MahangaWilliams.jpg" alt="" data-position="25% 25%" />
                </a>
                <div class="content">
                    <div class="inner">
                        <h2>Mahanga Williams</h2>
                        <p>Whanau Support Worker</p>
                        <ul class="actions">
                            <li><a href="#" class="button">Learn more</a> </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section>
                <a href="#" class="image">&nbsp;</a><div class="content">
                    <div class="inner">
                        <h2>Ataria </h2>
                        <p>Stone Soup Worker</p>
                        <ul class="actions">
                            <li><a href="#" class="button">Learn more</a> </li>
                        </ul>
                    </div>
                </div>
            </section>
            <section>
                <a href="#" class="image">
                    <img src="images/GregTichbon.jpg" alt="" data-position="25% 25%" />
                </a>
                <div class="content">
                    <div class="inner">
                        <h2>Greg Tichbon</h2>
                        <p>No one knows</p>
                        <p>Greg has been around youthwork for over 30 years and with Te Ora Hou for around 20 years. He is involved in most aspects of Te Ora Hou Whanganui, and has a bit of a bent for IT (Information Technology). He works part-time at the Whanganui District Council as a "Solutions Designer and Developer"</p>
                        <ul class="actions">
                            <li><a href="#" class="button">Learn more</a> </li>
                        </ul>
                    </div>
                </div>
            </section>
            <!--
            <section>
                <a href="#" class="image">
                    <img src="images/LeoneandMellisa.jpg" alt="" data-position="25% 25%" />
                </a>
                <div class="content">
                    <div class="inner">
                        <h2>Leonie de Vries & Melissa van Soest</h2>
                        <p>Interns from the Netherlands</p>
                        <p>Greg has been around youthwork for over 30 years and with Te Ora Hou for around 20 years. He is involved in most aspects of Te Ora Hou Whanganui, and has a bit of a bent for IT (Information Technology). He works part-time at the Whanganui District Council as a "Solutions Designer and Developer"</p>
                        <ul class="actions">
                            <li><a href="#" class="button">Learn more</a> </li>
                        </ul>
                    </div>
                </div>
            </section>
            -->

        </section>
        <!-- Two -->
        <section id="two" class="wrapper style3 fade-up">
            <div class="inner">
                <h2>What we do</h2>
                <p>Phasellus convallis elit id ullamcorper pulvinar. Duis aliquam turpis mauris, eu ultricies erat malesuada quis. Aliquam dapibus, lacus eget hendrerit bibendum, urna est aliquam sem, sit amet imperdiet est velit quis lorem.</p>
                <div class="features">
                    <section>
                        <span class="icon major fa-code"></span>
                        <h3>Whānau Ora</h3>
                        <p>Whānau Ora is an inclusive approach to providing services and opportunities to families across New Zealand. It’s about bringing together the various agencies that help whānau and delivering support in a more efficient and effective way. Key to the success of Whānau Ora is utilising whānau strengths and ensuring that the agencies organise their services around whānau instead of the other way around.</p>
                    </section>
                    <section>
                        <span class="icon major fa-code"></span>
                        <h3>Senior Club</h3>
                        <p>Senior Club is a youth programme that is run on a Monday night from 6.45pm-9.30pm (this is dependant on the actual activity each week). We just ask for a koha, and the best thing is – every young person are picked up and dropped off before and after the programme.</p>
                        <p>The purpose is to engage young people and allow them the opportunity to meet new people. They will experience different activities ranging from food olympics, re-creating film scenes, pamper evenings to storm the heights, raft racing and multi-sport challenges. With a programme that has numerous opportunities, all young people are guaranteed to have a great time, be fed and feel loved.</p>
                        <p>Throughout the year, during the school holidays, the youth workers deliver holiday programmes which is open to all young people who attend Monday Night Clubs. The Southern EasterCamp is amongst these, for every year Te Ora Hou offer the opportunity to their young people to experience the big camp under the TOH umbrella. There is also a bi-annual national camp called Tautoko, where young people get the opportunity to attend the week long camp in one of the TOH centres cities/towns.</p>
                        <p>Young people who participate in Monday Night Clubs and show promise in leadership are offered the opportunity to join the Whakapakari Leadership Programme.</p>
                        <p>Senior Club is delivered by experienced, trained and qualified youth workers and supported with volunteers. If you are interested in getting involved, check out the information for volunteers.</p>
                    </section>
                    <section>
                        <span class="icon major fa-code"></span>
                        <h3>Whakapakari</h3>
                        <p></p>
                    </section>
                    <section>
                        <span class="icon major fa-lock"></span>
                        <h3>Te Pihi Ora Hou Wahine</h3>
                        <p></p>
                    </section>
                    <section>
                        <span class="icon major fa-cog"></span>
                        <h3>Te Pihi Ora Hou Tane</h3>
                        <p></p>
                    </section>
                    <section>
                        <span class="icon major fa-desktop"></span>
                        <h3>Holiday Programs</h3>
                        <p></p>
                    </section>
                    <section>
                        <span class="icon major fa-chain"></span>
                        <h3>Ngatoa</h3>
                        <p></p>
                    </section>
                    <section>
                        <span class="icon major fa-diamond"></span>
                        <h3>Stone Soup</h3>
                        <p>Te Ora Hou Whanganui is proud to be part of the Stone Soup Community.</p>
                        <p><a href="http://stonesoup.org.nz" target="_blank">Stone Soup Website</a> </p>
                    </section>
                    <section>
                        <span class="icon major fa-diamond"></span>
                        <h3>Driver Licence</h3>
                        <p></p>
                    </section>
                    <section>
                        <span class="icon major fa-diamond"></span>
                        <h3>Fundraising services / Social Enterprise</h3>
                        <p>Te Ora Hou Whanganui endevours to raise some funds through a number of activities and in doing so helps people to develop new skills.</p>
                        <p>
                            Slap Dat Tat is the number one spray-on tat service in Whanganui providing a low cost, fast, fun and easy-removable tattoo for all ages and events. From big youth camps to community events ‘Slap Dat Tat’ has proven to be popular amongst stalls.
                            <p>This service also offers the opportunity for young people to gain work experience as young people are asked to assist in the delivery of the service for the majority of events that Slap Dat Tat are involved in.</p>
                            <p>The profit from Slap Dat Tat helps to support the delivery of the youth programmes that sit under Te Ora Hou Whanganui.</p>
                            <p>For more information and bookings, please contact us here in advance for your upcoming event.</p>
                    </section>
                </div>
                <ul class="actions">
                    <li><a href="#" class="button">Learn more</a> </li>
                </ul>
            </div>
        </section>
        <!-- Three -->
        <section id="three" class="wrapper style3 fade-up">
            <div class="inner">
                <h2>Who supports us</h2>
                <p>We are very thankful for all those groups, people, organisations, and funders that support Te Ora Hou Whanganui</p>
                <div class="features">
                    <section>
                        <span class="icon major fa-code"></span>
                        <h3>Our Workers</h3>
                        <p>Our workers don't just work their hours but offer much more than that.  They are available at all sorts of time to assist young people, their whanau, and our community in many varied ways.  Often their own whanau are also involved as well.</p>
                    </section>
                    <section>
                        <span class="icon major fa-code"></span>
                        <h3>Our Volunteers</h3>
                        <p>There are so many to be thankful to. We enjoy working together with like minded people who offer of their time to help make a better community. Special mention must go to some of our long-time faithful people, such as Keith Ramage, Jay Rerekura, Watties Matthews, Nathan Haami-Rerekura, the Robertson whanau.</p>
                    </section>
                    <section>
                        <span class="icon major fa-code"></span>
                        <h3>Our Board</h3>
                        <p>Te Ora Hou Whanganui is incredibly fortunate to have a wise board who give of their time and experience freely to support our direction and governance. </p>
                        <p>Our board is made up of: Des Warahi (Chairman), Tracey Hawker, (Treasurer), Eugene Katene, Roz Armstrong, and Judy Kumeroa (Kaihautu)</p>
                    </section>
                    <section>
                        <span class="icon major fa-code"></span>
                        <h3>Our Community</h3>
                        <p></p>
                    </section>
                    <section>
                        <span class="icon major fa-lock"></span>
                        <h3>Ara Kohatu</h3>
                        <p>Those people who regularly support us financially.</p>
                    </section>
                    <section>
                        <span class="icon major fa-cog"></span>
                        <h3>Our Funders</h3>
                        <p></p>
                    </section>
 
                </div>
                <ul class="actions">
                    <li><a href="#" class="button">Learn more</a> </li>
                </ul>
            </div>
        </section>

        <!-- Four -->
        <section id="four" class="wrapper style1 fullscreen fade-up">
            <div class="inner">
                <h2>Interns</h2>
                <p>We have been priveledged over the years to host a number of interns.</p>
<p>The following are the interns that we have had over the years</p>
                        <table>
                            <tbody>
                                <tr>
                                    <th>Name</th>
                                    <th>Country</th>
                                    <th>Year</th>
                                </tr>
                                <tr>
                                    <td>Sarah Ware</td>
                                    <td>USA</td>
                                    <td>2009</td>
                                </tr>
                                <tr>
                                    <td>Tiffany Schmmitz</td>
                                    <td>USA</td>
                                    <td>2009</td>
                                </tr>
                                <tr>
                                    <td>Marlieke Mols</td>
                                    <td>Netherlands</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Isa Wrntjs</td>
                                    <td>Netherlands</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Emma Eyes</td>
                                    <td>USA</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>PK Thao</td>
                                    <td>USA</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Caroline</td>
                                    <td>USA</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Shonelle</td>
                                    <td>USA</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Katie</td>
                                    <td>USA</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Cassie</td>
                                    <td>USA</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Nicole</td>
                                    <td>USA</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Stephanie</td>
                                    <td>USA</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Heather</td>
                                    <td>USA</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Leonie de Vries</td>
                                    <td>Netherlands</td>
                                    <td>2017</td>
                                </tr>
                                <tr>
                                    <td>Melissa van Soest</td>
                                    <td>Netherlands</td>
                                    <td>2017</td>
                                </tr>
                            </tbody>
                        </table>

                <ul class="actions">
                    <li><a href="#one" class="button scrolly">Learn more</a> </li>
                </ul>
            </div>
        </section>



        <!-- Five -->
        <section id="five" class="wrapper style1 fade-up">
            <div class="inner">
                <h2>Get in touch</h2>
                <p>We'd love to hear from you.</p>
                <div class="split style1">
                    <section>

                        <div class="field half first">
                            <label for="name">Name</label>
                            <input type="text" name="name" id="name" />
                        </div>
                        <div class="field half">
                            <label for="email">Email</label>
                            <input type="text" name="email" id="email" />
                        </div>
                        <div class="field">
                            <label for="message">Message</label>
                            <textarea name="message" id="message" rows="5"> </textarea>
                        </div>
                        <ul class="actions">
                            <li><a href="" class="button submit">Send Message</a> </li>
                        </ul>

                    </section>
                    <section>
                        <ul class="contact">
                            <li>
                                <h3>Address</h3>
                                <span>32 Totara Street<br />
                                    Tawhero<br />
                                    Whanganui 4501 </span></li>
                            <li>
                                <h3>Email</h3>
                                <a href="#">whanganui@teorahou.org.nz</a> </li>
                            <li>
                                <h3>Phone</h3>
                                <span>(06) 3447860</span> </li>
                            <li>
                                <h3>Social</h3>
                                <ul class="icons">
                                    <li><a href="https://www.facebook.com/teorahou.whanganui" target="_blank" class="fa-facebook"><span class="label">Facebook</span> </a></li>
                                    <!--
                                    <li > <a href="#" class="fa-twitter" > <span class="label" > Twitter</span > </a > </li > <li > <a href="#" class="fa-github" > <span class="label" > GitHub</span > </a > </li > <li > <a href="#" class="fa-instagram" > <span class="label" > Instagram</span > </a > </li > <li > <a href="#" class="fa-linkedin" > <span class="label" > LinkedIn</span > </a > </li >
                                    -->
                                </ul>
                            </li>
                        </ul>
                    </section>
                </div>
            </div>
        </section>
    </div>
    <!-- Footer -->
    <footer id="footer" class="wrapper style1-alt">
        <div class="inner">
            <ul class="menu">
                <li>&copy; Te Ora Hou Whanganui. All rights reserved.</li>
                <li>Design: Data Innovations</li>
            </ul>
        </div>
    </footer>
    <div id="judy_popup" class="b-popup">
        <span class="b-button b-close"><span>X</span></span>
        <p>Judy is 5' 10" is good looking and found love, so this is not a dating site.</p>
    </div>


</asp:Content>
