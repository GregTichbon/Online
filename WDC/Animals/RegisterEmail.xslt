<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <body>
        <h2>New Owner / Animal Registration</h2>
        <table class="submissionhead">
          <tr>
            <td>
              Thank you for your registration.
            </td>
          </tr>
        </table>
        <table width="95%" border="1" cellpadding="10" cellspacing="0" align="center">
          <tr>
            <td align="right" width="50%">Reference number</td>
            <td>
              <xsl:value-of select="root/reference"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Last name</td>
            <td>
              <xsl:value-of select="root/lastname"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">First name</td>
            <td>
              <xsl:value-of select="root/firstname"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Other name(s)</td>
            <td>
              <xsl:value-of select="root/othernames"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Known as</td>
            <td>
              <xsl:value-of select="root/knownas"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Residential address</td>
            <td>
              <xsl:value-of select="root/residentialaddress"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Postal address</td>
            <td>
              <xsl:value-of select="root/postaladdress"/>
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
            <td align="right" width="50%">Mobile phone</td>
            <td>
              <xsl:value-of select="root/mobilephone"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Home phone</td>
            <td>
              <xsl:value-of select="root/homephone"/>
            </td>
          </tr>

          <tr>
            <td align="right" width="50%">Work phone</td>
            <td>
              <xsl:value-of select="root/workphone"/>
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
              <xsl:value-of select="root/dateofbirth"/>
            </td>
          </tr>

          <tr>
            <td colspan="2" align="center">
              <b>Dog(s)</b>
            </td>
          </tr>
          <tr>

              <xsl:for-each select="root/DogRepeater/Dog">
                <td align="right" width="50%">
                  <b>Dog: <xsl:value-of select="DogIndex"/>
                  </b>
                </td>
                <td>
                  Name: <xsl:value-of select="name"/><br />
                  Primary breed: <xsl:value-of select="breed1"/><br />
                  Secondary breed: <xsl:value-of select="breed2"/><br />
                  Age: <xsl:value-of select="years"/>:<xsl:value-of select="months"/><br />
                  Primary colour: <xsl:value-of select="colour1"/><br />
                  Secondary colour: <xsl:value-of select="colour2"/><br />
                  Gender: <xsl:value-of select="gender"/><br />
                  Neutered: <xsl:value-of select="neutered"/><br />
                  Chip: <xsl:value-of select="chip"/><br />
                </td>
              </xsl:for-each>
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
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>







