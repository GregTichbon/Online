<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <body>
        <h2>Whanganui District Council Appointment Acknowledgment</h2>
        <table class="submissionhead">
          <tr>
            <td>
              Thank you for your appointment.  This information has also been emailed to you.
            </td>
          </tr>
        </table>
        <table class="submissiontable">
          <tr>
            <td>Reference number</td>
            <td>
              <xsl:value-of select="root/newreference"/>
            </td>
          </tr>
          <tr>
            <td>Appointment</td>
            <td>
              <xsl:value-of select="root/tb_appointment"/>
            </td>
          </tr>
          <tr>
            <td>Property</td>
            <td>
              <xsl:value-of select="root/tb_property"/>
            </td>
          </tr>
          <tr>
              <td>Name</td>
              <td>
                <xsl:value-of select="root/tb_name"/>
              </td>
            </tr>
            <tr>
              <td>Email address</td>
              <td>

                <a>
                  <xsl:attribute name="href">mailto:<xsl:value-of select="root/tb_emailaddress"/>
                  </xsl:attribute>
                  <xsl:value-of select="root/tb_emailaddress"/>
                </a>
              </td>
            </tr>
            <tr>
              <td>Phone details</td>
              <td>
                <xsl:value-of select="root/tb_contactphone"/>
              </td>
            </tr>
            <tr>
              <td>Other useful information</td>
              <td>
                <xsl:value-of select="root/tb_information"/>
              </td>
            </tr>
          <tr>
            <td colspan="2">If you need to amend any information or cancel this appointment please click 
            <a>
              <xsl:attribute name="href">
                                <xsl:value-of select="root/screenlink"/>
              </xsl:attribute>
              <xsl:attribute name="target">_blank</xsl:attribute>
              here</a>.</td>
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

