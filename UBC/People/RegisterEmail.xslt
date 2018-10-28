<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <html>
      <body bgcolor="#B1C9E6">
        <table width="100%" border="1" cellpadding="10" cellspacing="0" align="center">
          <td>
            <img src="http://private.unionboatclub.co.nz/dependencies/images/Logo-Page-Head-350.png" />
          </td>
          <td>

          <h2> Union Boat Club Rower Registration</h2>

          <h4> Thank you for your registration.</h4>
          </td>
        </table>

        <table width="95%" border="1" cellpadding="10" cellspacing="0" align="center">
          
          <tr>
            <td align="right" width="50%">First name</td>
            <td>
              <xsl:value-of select="root/firstname"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Last name</td>
            <td>
              <xsl:value-of select="root/lastname"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Gender</td>
            <td>
              <xsl:value-of select="root/gender"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Date of birth</td>
            <td>
              <xsl:value-of select="root/birthdate"/>
            </td>
          </tr>

          <xsl:if test="string(root/school)">
            <tr>
              <td align="right" width="50%">School</td>
              <td>
                <xsl:value-of select="root/school"/>
              </td>
            </tr>

            <tr>
              <td align="right" width="50%">School year</td>
              <td>
                <xsl:value-of select="root/schoolyear"/>
              </td>
            </tr>
          </xsl:if>

          <tr>
            <td align="right" width="50%">Medical needs</td>
            <td>
              <xsl:value-of select="root/medical"/>
            </td>
          </tr>
          <tr>
            <td align="right" width="50%">Special Dietry requirements</td>
            <td>
              <xsl:value-of select="root/dietry"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Email address</td>
            <td>
              <a>
                <xsl:attribute name="href">
                  mailto:<xsl:value-of select="root/emailaddress"/>
                </xsl:attribute>
                <xsl:value-of select="root/emailaddress"/>
              </a>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Home phone</td>
            <td>
              <xsl:value-of select="root/homephone"/>
            </td>
          </tr>
          <tr>
            <td align="right" width="50%">Mobile phone</td>
            <td>
              <xsl:value-of select="root/mobilephone"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Home address</td>
            <td>


              <xsl:call-template name="break">
                <xsl:with-param name="text" select="root/residentialaddress" />
              </xsl:call-template>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Swimming ability</td>
            <td>
              <xsl:value-of select="root/swimmer"/>
            </td>
          </tr>

          <xsl:if test="string(root/parentcaregiver1)">

            <tr>
              <td colspan="2" align="left">
                <h2>Parent/Caregivers</h2></td>
            </tr>

            <tr>
              <td align="right" width="50%">Name (1)</td>
              <td>
                <xsl:value-of select="root/parentcaregiver1"/>
              </td>
            </tr>
            <tr>
              <td align="right" width="50%">Mobile phone (1)</td>
              <td>
                <xsl:value-of select="root/parentcaregiver1mobilephone"/>
              </td>
            </tr>
            <tr>
              <td align="right" width="50%">Email address (1)</td>
              <td>
                <xsl:value-of select="root/parentcaregiver1emailaddress"/>
              </td>
            </tr>
          </xsl:if>

          <xsl:if test="string(root/parentcaregiver2)">

 
            <tr>
              <td align="right" width="50%">Name (2)</td>
              <td>
                <xsl:value-of select="root/parentcaregiver2"/>
              </td>
            </tr>
            <tr>
              <td align="right" width="50%">Mobile phone (2)</td>
              <td>
                <xsl:value-of select="root/parentcaregiver2mobilephone"/>
              </td>
            </tr>
            <tr>
              <td align="right" width="50%">Email address (2)</td>
              <td>
                <xsl:value-of select="root/parentcaregiver2emailaddress"/>
              </td>
            </tr>
          </xsl:if>

          <tr>
            <td colspan="2" align="left">
              Declaration
              <ul>
                <li>I hereby apply for membership of the Union Boat Club. - I agree to be bound by the rules of the Club and to pay the annual subscription fees as set at the Annual General Meeting.</li>
                <li>I also agree to pay such additional fees and levies which may be set from time to time to cover such items as: plant replacement, regatta entries and travel expenses.</li>
                <li>I understand that there may be risk of personal injury involved in participating in the sport of rowing and hereby indemnify the Union Boat Club, its Executive, fellow members and coaches from any liability.</li>
              </ul>
            </td>
          </tr>
          <tr>
            <td align="right" width="50%">I agree with the above statements.</td>
            <td>
              <xsl:value-of select="root/agreement"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">I also agree, for my email address to added to the Union Boat Club database to receive email newsletters and updates.</td>
            <td>
              <xsl:value-of select="root/correspondence"/>
            </td>
          </tr>
          <!--
        <tr>
            <td>Attachments</td>
            <td>
              <xsl:for-each select="root/uploaded/fu_attachments">
                <a>
                  <xsl:attribute name="href">
                    <xsl:value-of select="url"/>
                  </xsl:attribute>
                  <xsl:attribute name="target">_blank</xsl:attribute>
                  <xsl:value-of select="filename"/>
                </a>
                <br />
              </xsl:for-each>
            </td>
          </tr>
            -->
        </table>
        <p> </p>
      </body>
    </html>

  </xsl:template>


  <xsl:template name="break">
    <xsl:param name="text" select="string(.)"/>
    <xsl:choose>
      <xsl:when test="contains($text, '&#xa;')">
        <xsl:value-of select="substring-before($text, '&#xa;')"/>
        <br/>
        <xsl:call-template name="break">
          <xsl:with-param
            name="text"
            select="substring-after($text, '&#xa;')"
        />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>




  </xsl:template>
</xsl:stylesheet>







