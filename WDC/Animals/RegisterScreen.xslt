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
        <table class="submissiontable">
          <tr>
            <td>Reference number</td>
            <td>
              <xsl:value-of select="root/reference"/>
            </td>
          </tr>

          <tr>
            <td>Last name</td>
            <td>
              <xsl:value-of select="root/lastname"/>
            </td>
          </tr>

          <tr>
            <td>First name</td>
            <td>
              <xsl:value-of select="root/firstname"/>
            </td>
          </tr>

          <tr>
            <td>Other name(s)</td>
            <td>
              <xsl:value-of select="root/othernames"/>
            </td>
          </tr>

          <tr>
            <td>Known as</td>
            <td>
              <xsl:value-of select="root/knownas"/>
            </td>
          </tr>

          <tr>
            <td>Residential address</td>
            <td>
              <xsl:value-of select="root/residentialaddress"/>
            </td>
          </tr>

          <tr>
            <td>Postal address</td>
            <td>
              <xsl:value-of select="root/postaladdress"/>
            </td>
          </tr>

          <tr>
            <td>Email address</td>
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
            <td>Mobile phone</td>
            <td>
              <xsl:value-of select="root/mobilephone"/>
            </td>
          </tr>

          <tr>
            <td>Home phone</td>
            <td>
              <xsl:value-of select="root/homephone"/>
            </td>
          </tr>

          <tr>
            <td>Work phone</td>
            <td>
              <xsl:value-of select="root/workphone"/>
            </td>
          </tr>

          <tr>
            <td>Gender</td>
            <td>
              <xsl:value-of select="root/gender"/>
            </td>
          </tr>

          <tr>
            <td>Date of birth</td>
            <td>
              <xsl:value-of select="root/dateofbirth"/>
            </td>
          </tr>

          <tr>
            <td colspan="2" class="center">Dog(s)</td>
          </tr>
          <tr>
            <xsl:for-each select="root/DogRepeater/Dog">
              <td>
                Dog: <xsl:value-of select="DogIndex"/>
              </td>
              <td>
                <b>Name:</b> <xsl:value-of select="name"/><br />
                <b>Primary breed:</b> <xsl:value-of select="breed1"/><br />
                <b>Secondary breed:</b> <xsl:value-of select="breed2"/><br />
                <b>Age:</b> <xsl:value-of select="years"/>:<xsl:value-of select="months"/><br />
                <b>Primary colour:</b> <xsl:value-of select="colour1"/><br />
                <b>Secondary colour:</b> <xsl:value-of select="colour2"/><br />
                <b>Gender:</b> <xsl:value-of select="gender"/><br />
                <b>Neutered:</b> <xsl:value-of select="neutered"/><br />
                <b>Chip:</b> <xsl:value-of select="chip"/><br />
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

